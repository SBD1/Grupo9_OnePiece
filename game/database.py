import os

import psycopg2


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

    def __enter__(self):
        self.connection.__enter__()
        return self

    def __exit__(self, *args, **kwargs):
        self.connection.__exit__(*args, **kwargs)

    def __del__(self):
        self.close()

    def close(self) -> None:
        self.connection.close()
