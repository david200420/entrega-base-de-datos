mysql> drop database if exists random;
Query OK, 0 rows affected, 1 warning (0,01 sec)

mysql> create database random;
Query OK, 1 row affected (0,02 sec)

mysql> use random;
Database changed
mysql> CREATE TABLE jugadores ( ID integer not null primary key, nombre VARCHAR(25), contraseña VARCHAR(25), victoria_derrota VARCHAR(10));
Query OK, 0 rows affected (0,08 sec)

mysql> show columns from jugadores
    -> ;
+------------------+-------------+------+-----+---------+-------+
| Field            | Type        | Null | Key | Default | Extra |
+------------------+-------------+------+-----+---------+-------+
| ID               | int         | NO   | PRI | NULL    |       |
| nombre           | varchar(25) | YES  |     | NULL    |       |
| contraseña       | varchar(25) | YES  |     | NULL    |       |
| victoria_derrota | varchar(10) | YES  |     | NULL    |       |
+------------------+-------------+------+-----+---------+-------+
4 rows in set (0,00 sec)

mysql> CREATE TABLE partida ( ID integer not null primary key, fecha VARCHAR(25), tiempo integer, num_jug integer);
Query OK, 0 rows affected (0,06 sec)

mysql> show columns from partida;
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| ID      | int         | NO   | PRI | NULL    |       |
| fecha   | varchar(25) | YES  |     | NULL    |       |
| tiempo  | int         | YES  |     | NULL    |       |
| num_jug | int         | YES  |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+
4 rows in set (0,00 sec)

mysql> CREATE INDEX idx_victoria_derrota ON jugadores(victoria_derrota);
Query OK, 0 rows affected (0,06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> CREATE TABLE referenciaJP (
    ->     ID INTEGER NOT NULL PRIMARY KEY,
    ->     IP_J INTEGER,
    ->     IP_P INTEGER,
    ->     Resultado VARCHAR(10),
    ->     FOREIGN KEY (IP_J) REFERENCES jugadores(ID),
    ->     FOREIGN KEY (IP_P) REFERENCES referenciaJP(ID),
EY (R    ->     FOREIGN KEY (Resultado) REFERENCES jugadores(victoria_derrota)
    -> );
Query OK, 0 rows affected (0,09 sec)


mysql> show columns from referenciaJP;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| ID        | int         | NO   | PRI | NULL    |       |
| IP_J      | int         | YES  | MUL | NULL    |       |
| IP_P      | int         | YES  | MUL | NULL    |       |
| Resultado | varchar(10) | YES  | MUL | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
4 rows in set (0,00 sec)

mysql> INSERT INTO jugadores VALUES (1, 'david', 'David2004', '26/0');
Query OK, 1 row affected (0,01 sec)