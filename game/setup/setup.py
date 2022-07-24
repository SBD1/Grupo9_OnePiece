import os
import re

import psycopg2


def create_tables():
    """Create tables in the database."""
    connection = psycopg2.connect("host=localhost dbname=one_piece user=postgres password=postgres")

    cursor = connection.cursor()
    with open(os.path.join(os.path.dirname(__file__), "ddl.sql"), 'r') as f:
        file_content = re.sub(r'\n', ' ', re.sub(r'.*--.*', '', f.read()))
        for line in file_content.split(';'):
            line = line.strip()
            if line.startswith("--"):
                print(f'Skipping comment: {line}\n')
                continue
            if not line:
                print('Skipping empty line\n')
                continue

            print(f'Executing: {line}\n')
            cursor.execute(line)

    connection.commit()
    connection.close()


if __name__ == '__main__':
    create_tables()
