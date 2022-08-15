import os

import psycopg2
from psycopg2.extensions import cursor


class Database:
    TABLE_FIELDS: dict = {}

    def __init__(self) -> None:
        self.connection = psycopg2.connect(
            host=os.getenv('DB_HOST', 'localhost'),
            dbname=os.getenv('DB_NAME', 'one_piece'),
            user=os.getenv('DB_USER', 'postgres'),
            password=os.getenv('DB_PASSWORD', 'postgres')
        )
        self.cursor = self.connection.cursor()

        if not Database.TABLE_FIELDS:
            self.__load_tables()

    def __enter__(self):
        self.connection.__enter__()
        return self

    def __exit__(self, *args, **kwargs):
        self.connection.__exit__(*args, **kwargs)

    def __getattribute__(self, name: str) -> 'Dao':
        if name in Database.TABLE_FIELDS:
            return Dao(name, Database.TABLE_FIELDS[name], self.cursor)
        return super().__getattribute__(name)

    def __load_tables(self) -> None:
        self.cursor.execute('SELECT table_name FROM information_schema.tables WHERE table_schema=%s AND table_type=%s', [
                            'public', 'BASE TABLE'])
        table_names = [names[0] for names in self.cursor.fetchall()]
        for table_name in table_names:
            self.cursor.execute(
                'SELECT column_name FROM information_schema.columns WHERE table_name=%s', [table_name])
            Database.TABLE_FIELDS[table_name] = [columns[0]
                                                 for columns in self.cursor.fetchall()]

    def __del__(self):
        self.close()

    def close(self) -> None:
        self.connection.close()


class Dao:
    SELECT_QUERY = 'SELECT {fields} FROM {table} {filters}'

    def __init__(self, table_name: str, fields: list, cursor: cursor) -> None:
        self.table_name = table_name
        self.fields = fields
        self.cursor = cursor

    def get(self, filters: dict = None, fields: list = None):
        fields = fields or self.fields
        self.cursor.execute(Dao.SELECT_QUERY.format(
            fields=','.join(fields),
            table=self.table_name,
            filters=self.generate_filters(filters)
        ), [*filters.values()])
        return [{k: v for k, v in zip(fields, result)}
                for result in self.cursor.fetchall()]

    def generate_filters(self, filters: dict) -> str:
        if not filters:
            return ''
        result = ' AND '.join('{column} {operator} %s'.format(
            column=column,
            operator='='
        ) for column in filters.keys())
        return f'WHERE {result}'
