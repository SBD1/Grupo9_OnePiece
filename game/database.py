from contextlib import contextmanager
import os

import psycopg2
import psycopg2.extras


@contextmanager
def get_connection():
    conn = psycopg2.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        dbname=os.getenv('DB_NAME', 'one_piece'),
        user=os.getenv('DB_USER', 'jogo'),
        password=os.getenv('DB_PASSWORD', 'senhasupersegura')
    )
    try:
        yield conn
    finally:
        conn.close()


AS_DICT = psycopg2.extras.RealDictCursor
