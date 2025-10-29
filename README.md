# Práctica: Modelo Relacional, Vistas y Disparadores
## Administración y Diseño de Bases de Datos

---

## 📋 Información General

**Asignatura:** Administración y Diseño de Bases de Datos  
**Grado:** Ingeniería Informática  
**Curso académico:** 2025-2026  
**Autor(es):** [Nombre del estudiante/pareja]

---

## 🎯 Objetivos

Los principales objetivos de esta práctica son los siguientes:

- Continuar desarrollando habilidades en las operaciones básicas con el SQL
- Desarrollar actividades básicas con vistas y disparadores

---

## 📖 Descripción

Blockbuster LLC, conocida como Blockbuster Video, fue una franquicia estadounidense de videoclubes, especializada en alquiler de películas y videojuegos a través de tiendas físicas, servicios por correo y vídeo bajo demanda. Fue una de las precursoras de plataformas como la actual Netflix. Su modelo de negocios se basaba en el alquiler de DVD de juegos y películas.

Sobre el escenario descrito anteriormente, en esta práctica trabajaremos como una base de datos que típicamente se podría encontrar en un establecimiento en el que los clientes están registrados y pueden alquilar películas con un tiempo máximo de alquiler y su histórico de alquileres. Además, se incluyen datos sobre las películas disponibles, los empleados y las tiendas.

Partiendo de la base de datos alquilerdvd.tar que se encuentra disponible en GitHub.

---

## 🛠️ Tecnologías Utilizadas

- PostgreSQL
- psql
- PL/pgSQL

---

## 📂 Estructura del Repositorio

```
.
├── README.md
├── alquilerdvd.tar
├── backup_final.sql
├── consultas.sql
├── vistas.sql
├── disparadores.sql
└── docs/
    └── informe.pdf
```

---

## 📝 Desarrollo de la Práctica

### 1. Restauración de la Base de Datos

Realice la restauración de la base de datos alquilerdvd.tar. Observe que la base de datos no tiene un formato SQL como el empleado en actividades anteriores.

---

### 2. Identificación de Objetos

Identifique las tablas, vistas y secuencias.

---

### 3. Tablas Principales

Identifique las tablas principales y sus principales elementos.

---

### 4. Consultas SQL

Realice las siguientes consultas.

#### a) Ventas Totales por Categoría

Obtenga las ventas totales por categoría de películas ordenadas descendentemente.

#### b) Ventas Totales por Tienda

Obtenga las ventas totales por tienda, donde se refleje la ciudad, el país (concatenar la ciudad y el país empleando como separador la ","), y el encargado. Pudiera emplear GROUP BY, ORDER BY.

#### c) Lista de Películas Completa

Obtenga una lista de películas, donde se reflejen el identificador, el título, descripción, categoría, el precio, la duración de la película, clasificación, nombre y apellidos de los actores (puede realizar una concatenación de ambos). Pudiera emplear GROUP BY.

#### d) Información de Actores

Obtenga la información de los actores, donde se incluya sus nombres y apellidos, las categorías y sus películas. Los actores deben de estar agrupados y, las categorías y las películas deben estar concatenados por ":".

---

### 5. Creación de Vistas

Realice todas las vistas de las consultas anteriores. Colóqueles el prefijo view_ a su denominación.

---

### 6. Restricciones CHECK

Haga un análisis del modelo e incluya las restricciones CHECK que considere necesarias.

---

### 7. Análisis del Trigger last_updated

Explique la sentencia que aparece en la tabla customer:

```
Triggers:
    last_updated BEFORE UPDATE ON customer
    FOR EACH ROW EXECUTE PROCEDURE last_updated()
```

Identifique alguna tabla donde se utilice una solución similar.

---

### 8. Disparador para Inserciones

Construya un disparador que guarde en una nueva tabla creada por usted la fecha de cuando se insertó un nuevo registro en la tabla film y el identificador del film.

---

### 9. Disparador para Eliminaciones

Construya un disparador que guarde en una nueva tabla creada por usted la fecha de cuando se eliminó un registro en la tabla film y el identificador del film.

---

### 10. Secuencias

Comente el significado y la relevancia de las secuencias.

---

## 📚 Referencias

- [Documentación oficial de PostgreSQL](https://www.postgresql.org/docs/)
- [Tutorial de PL/pgSQL](https://www.postgresql.org/docs/current/plpgsql.html)
- [Guía de Triggers en PostgreSQL](https://www.postgresql.org/docs/current/triggers.html)

---

## 👥 Integrantes

- **Estudiante 1:** [Nombre completo]
- **Estudiante 2:** [Nombre completo] *(si aplica)*

---

## 📅 Fecha de Entrega

[Fecha de entrega]

---

## 📧 Contacto

Para consultas sobre este proyecto: cexposit@ull.edu.es

---

## 📋 Observaciones

- La práctica puede ser realizada por parejas. Si éste es su caso, incluya el nombre de los integrantes de la pareja en la entrega y realicen el envío ambos a través de la actividad habilitada en el campus virtual de la asignatura.
- Si el repositorio de GitHub es privado invite a cexposit@ull.edu.es para poder consultarlo.

---

**Universidad de La Laguna**  
Grado en Ingeniería Informática  
Curso 2025-2026
