#include <mysql.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

MYSQL *conn;

void conectarBD() {
	conn = mysql_init(NULL);
	if (conn == NULL) {
		fprintf(stderr, "mysql_init() failed\n");
		exit(EXIT_FAILURE);
	}
	if (mysql_real_connect(conn, "random", "usuario", "contraseña", NULL, 0, NULL, 0) == NULL) {
		fprintf(stderr, "mysql_real_connect() failed\n");
		mysql_close(conn);
		exit(EXIT_FAILURE);
	}
}

void ejecutarConsulta(char *sql) {
	if (mysql_query(conn, sql) != 0) {
		fprintf(stderr, "Error en la consulta: %s\n", mysql_error(conn));
		mysql_close(conn);
		exit(EXIT_FAILURE);
	}
}

int main() {
	conectarBD();
	
	// Crear la base de datos
	ejecutarConsulta("CREATE DATABASE IF NOT EXISTS random");
	
	// Seleccionar la base de datos recién creada
	ejecutarConsulta("USE random");
	
	ejecutarConsulta("CREATE TABLE IF NOT EXISTS Jugadores ("
					 "player_id INT AUTO_INCREMENT PRIMARY KEY,"
					 "nombre VARCHAR(255) NOT NULL,"
					 "contraseña VARCHAR(255) NOT NULL,"
					 "partidas_ganadas INT,"
					 "partidas_jugadas INT,"
					 "puntos INT"
					 ")");
	
	// Crear tabla Partidas
	ejecutarConsulta("CREATE TABLE IF NOT EXISTS Partidas ("
					 "game_id INT AUTO_INCREMENT PRIMARY KEY,"
					 "fecha DATE NOT NULL,"
					 "tiempo_duracion TIME NOT NULL,"
					 "num_jugadores INT"
					 ")");
	
	// Crear tabla Relacion_Jugador_Partida
	ejecutarConsulta("CREATE TABLE IF NOT EXISTS Relacion_Jugador_Partida ("
					 "player_game_id INT AUTO_INCREMENT PRIMARY KEY,"
					 "player_id INT,"
					 "game_id INT,"
					 "puntos_ganados INT,"
					 "resultado INT,""FOREIGN KEY (player_id) REFERENCES Jugadores(player_id),"
					 "FOREIGN KEY (game_id) REFERENCES Partidas(game_id)"
					 ")");
	
	mysql_close(conn);
	return 0;
}


