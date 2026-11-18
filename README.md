<div align="center">
  <h1>🛢️ Bases de Datos</h1>
  <p><em>Guía práctica con ejercicios resueltos de SQL de la materia Bases de Datos (3636) - 2C 2022 - UNLaM.</em></p>

  <!-- Badges -->
  <img src="https://img.shields.io/badge/Universidad-UNLaM-1F4F90?style=for-the-badge&logo=google-scholar&logoColor=white" alt="UNLaM" />
  <img src="https://img.shields.io/badge/Año-2022-2EA043?style=for-the-badge" alt="2022" />
  <img src="https://img.shields.io/badge/Lenguaje-SQL-0078D4?style=for-the-badge&logo=sqlite&logoColor=white" alt="SQL" />
  <img src="https://img.shields.io/badge/Estado-Completado-blue?style=for-the-badge" alt="Completado" />
</div>

<br>

## 📑 Índice
- [Información de la Asignatura](#informacion-de-la-asignatura)
- [Trayecto - Infraestructura](#trayecto)
- [Docentes](#docentes)
- [Unidad Temática N.º 1 - Sistemas de Gestión de Bases de Datos](#unidad-1)
- [Unidad Temática N.º 2 - Modelos de Datos](#unidad-2)
- [Unidad Temática N.º 3 - Teoría de las Dependencias Funcionales](#unidad-3)
- [Unidad Temática N.º 4 - Diseño de Bases de Datos](#unidad-4)
- [Unidad Temática N.º 5 - Lenguaje de Consulta de Datos](#unidad-5)
- [Unidad Temática N.º 6 - Procesamiento y Optimización de Consultas](#unidad-6)
- [Unidad Temática N.º 7 - Transacciones y Control de Concurrencia](#unidad-7)
- [Unidad Temática N.º 8 - Seguridad e Integridad de las Bases de Datos](#unidad-8)
- [Unidad Temática N.º 9 - Sistemas de Bases de Datos Distribuidas](#unidad-9)
- [Unidad Temática N.º 10 - Bases de Datos Avanzadas](#unidad-10)
- [Herramientas Utilizadas](#herramientas-utilizadas)
- [Estructura del Proyecto](#estructura-del-proyecto)

---

<a id="informacion-de-la-asignatura"></a>
## ℹ️ Información de la Asignatura
* **Carrera**: Ingeniería en Informática
* **Materia**: Bases de Datos (3636)
* **Cuatrimestre**: Segundo Cuatrimestre
* **Año**: 2022

<a id="trayecto"></a>
## 💻 Trayecto - Programación
* **Año Académico**: Segundo Año - Primer Cuatrimestre
* **Responsable / Jefe de cátedra**: Ichazo, Veronica
* **Carga Horaria Semanal**: 4 hs
* **Carga Horaria Total**: 64 hs
* **Modalidad**: Virtual
* **Correlativas anteriores**:
  * Matemática Discreta (3621)
  * Programación Estructurada Básica (3629)

<a id="docentes"></a>
## 👨‍🏫 Docentes
* Halil, Hernan
* Palomares, Alfonso
* Ybarra, Fernando

---

<a id="unidad-1"></a>
## Unidad Temática N.º 1 - Sistemas de Gestión de Bases de Datos

<div align="center">
  <img width="700" alt="Sistema Gestor de Base de Datos" src="https://github.com/user-attachments/assets/154bd619-c99d-496c-b882-8f40ffe69690" />
  <br>
  <sup><em>Esquema de un Sistema Gestor de Bases de Datos (SGBD)</em></sup>
</div>
<br>

* **Sistemas tradicionales de archivos:** Características, desventajas y diferencias con las bases de datos.
* **Introducción a las Bases de Datos:** Conceptos, características, ventajas y mercado actual.
* **Sistema de base de datos:**
  * Componentes y estructura de datos relacional.
  * Conceptos básicos: Atributos, Tuplas, Claves, Relaciones.
* **Usuarios de DBMS:** Roles y funciones.
* **Administrador de Bases de Datos:** Funciones principales.
* **Arquitectura de los DBMS:** Nivel externo, conceptual e interno.
* **Estructura global de un DBMS:** Componentes, secciones posteriores y frontales.
* **Instancias y Esquemas:**
  * Independencia de Datos: Concepto y clasificación.
* **Nivel Interno:**
  * Acceso a la base de datos y administración de páginas.
  * Indexación: Concepto, formas de utilización y clasificación.
  * Árboles B y B+.
* **Lenguajes:**
  * Lenguaje de Definición de Datos (DDL).
  * Lenguaje de Manipulación de Datos (DML).
  * Aplicación práctica.
* **DBMS Distribuidos:** Concepto, topologías, ventajas, desventajas y diseño.

---

<a id="unidad-2"></a>
## Unidad Temática N.º 2 - Modelos de Datos

<div align="center">
  <img width="700" alt="Tipos de Modelos de Datos" src="https://github.com/user-attachments/assets/a0d14bb5-4c37-4d87-9abe-281cb04022e7" />
  <br>
  <sup><em>Evolución de los Modelos de Datos</em></sup>
</div>
<br>

<div align="center">
  <img width="700" alt="Relacionales vs No Relacionales" src="https://github.com/user-attachments/assets/7978265a-2f95-4873-a799-0c9d40ff61f2" />
  <br>
  <sup><em>Bases de Datos Relacionales vs No Relacionales</em></sup>
</div>
<br>

* **Introducción:** Modelo de datos, paradigmas y proceso de diseño de una base de datos.
* **Diseño conceptual:** Recolección y definición de los requerimientos de datos.
* **Calidad del esquema actual:** Criterios y cómo lograrla. Abstracciones, clasificación, agregación y generalización.
* **Modelos Lógicos basados en Registros:** Conceptos, características, Modelo Jerárquico, de Red y Relacional. Ventajas y desventajas.
* **Modelos Lógicos basados en Objetos:** Características, ventajas y desventajas.
* **Modelo Entidad-Relación y Modelo Orientado a Objetos.**
* **Modelo Relacional:**
  * Estructura de datos relacional, dominios y relaciones.
  * Reglas de Integridad: Específicas de las Entidades y Referencial.
  * Modelo lógico: Datalog, evaluación de consultas, funciones recursivas y no recursivas.
* **Álgebra relacional:** Operaciones tradicionales de conjuntos y operaciones relacionales especiales.
* **Cálculo Relacional.**
* **Bases de datos en Internet y Tendencias Actuales.** 

---

<a id="unidad-3"></a>
## Unidad Temática N.º 3 - Teoría de las Dependencias Funcionales

<div align="center">
  <img width="700" alt="Dependencias Funcionales" src="https://github.com/user-attachments/assets/e7a5f5b4-2994-4344-aff1-d0d7c49582c1" />
  <br>
  <sup><em>Concepto de Dependencias Funcionales</em></sup>
</div>
<br>

* Información redundante en las tuplas y anomalías de actualización.
* Valores nulos en las tuplas y generación de tuplas espurias.
* **Dependencias funcionales:** Definición de dependencia funcional.
* Reglas de inferencia para las dependencias funcionales (Axiomas de Armstrong y reglas adicionales).
* Clausuras de un conjunto de atributos X+
* Tipos de Dependencias y Claves Candidatas.
* Equivalencia y conjuntos mínimos de dependencias funcionales.

---

<a id="unidad-4"></a>
## Unidad Temática N.º 4 - Diseño de Bases de Datos

<div align="center">
  <img width="700" alt="Tipos de Normalización" src="https://github.com/user-attachments/assets/62c313b0-334b-4872-b75d-6ae97328b616" />
  <br>
  <sup><em>Proceso de Normalización</em></sup>
</div>
<br>

* **Introducción a la Normalización:** Concepto y finalidad.
* **Descomposición:** Pérdida de información, algoritmos de verificación y pérdida de dependencias funcionales.
* **Formas Normales:**
  * 1º Forma Normal (1FN).
  * 2º Forma Normal (2FN).
  * 3º Forma Normal (3FN).
* Conceptos de Formas Normales de Boyce/Codd (BCNF), Cuarta (4FN) y Quinta (5FN). 

---

<a id="unidad-5"></a>
## Unidad Temática N.º 5 - Lenguaje de Consulta de Datos

### Estructura (DDL)
<div align="center">
  <img width="700" alt="Sentencias DDL" src="https://github.com/user-attachments/assets/c0ba65cb-4358-4a13-9a12-da83759ee3a6" />
  <br>
  <sup><em>Data Definition Language (DDL)</em></sup>
</div>
<br>

* Creación
    * Base de Datos
    * Tablas.
* Modificación y eliminación de estructuras.

### Consultas
<div align="center">
  <img width="700" alt="Consultas SQL" src="https://github.com/user-attachments/assets/84f31137-a6d0-4adc-8ab3-aaa34059fee2" />
  <br>
  <sup><em>Estructura de consultas SQL</em></sup>
</div>
<br>

* Consultas simples
* Condiciones de búsqueda.
* Consultas multitablas y sumarias.

### Subconsultas
<div align="center">
  <img  width="700" alt="Subconsultas" src="https://scontent.faep28-2.fna.fbcdn.net/v/t39.30808-6/706202814_1444183997725075_1684298045250782611_n.jpg?stp=dst-jpg_tt6&cstp=mx1024x1536&ctp=s1024x1536&_nc_cat=100&_nc_map=urlgen_bucketless&ccb=1-7&_nc_sid=aa7b47&_nc_eui2=AeEC6Q48auNIFPFClh6rupOxDcqhk0waX-QNyqGTTBpf5ByFize_pPCs9DI25uwGglEL3KQdu0s3xckhlQ-Vsfxp&_nc_ohc=TF2TjLZ6e0cQ7kNvwGW1OD_&_nc_oc=Adq1PNK42jsQhaikGLdIRQNOVM6tLEW_dW8V9CRj-xSb4aDigLGldJpND-STS5se0JU235Fl6celTZr9Le7N9h3C&_nc_zt=23&_nc_ht=scontent.faep28-2.fna&_nc_gid=DXF2Z6pojx4lS_s8CbJ-QQ&_nc_ss=7b2a8&oh=00_AQRx26laEfpZZqrIAQbcPnZvYbwmwHx9ac_PPhWo5eXQYA&oe=6AF895BB" />
  <br>
  <sup><em>Ejemplo de subconsultas anidadas</em></sup>
</div>
<br>

* Aplicación práctica
* Condiciones de búsqueda avanzadas.

### Manipulación de datos (DML)
<div align="center">
  <img width="700" alt="Sentencias DML" src="https://github.com/user-attachments/assets/08679903-840e-408e-b860-97d814b80355" />
  <br>
  <sup><em>Data Manipulation Language (DML)</em></sup>
</div>
<br>

* Inserción multifila
* Actualización de filas.
* Eliminación de filas.

### Temas Adicionales de la Unidad

<div align="center">
  <img width="700" alt="Cascade vs Restrict" src="https://github.com/user-attachments/assets/05308c31-354a-4e0a-b4e1-2435db806082" />
  <br>
  <sup><em>Cascade vs Restrict</em></sup>
</div>
<br>

<div align="center">
  <img width="700" alt="Triggers" src="https://github.com/user-attachments/assets/3d902d8f-5293-4e83-999a-df2d87513376" />
  <br>
  <sup><em>Triggers en SQL</em></sup>
</div>
<br>

<div align="center">
  <img width="700" alt="Stored Procedures" src="https://github.com/user-attachments/assets/e1aae655-49c5-4769-9ce2-9e1e1e8beafa" />
  <br>
  <sup><em>Stored Procedures en SQL</em></sup>
</div>
<br>

<div align="center">
  <img width="700" alt="CTE vs Subconsultas" src="https://github.com/user-attachments/assets/43820f30-6d79-49e2-8926-bedd9c924789" />
  <br>
  <sup><em>CTE vs Subconsultas</em></sup>
</div>
<br>

<div align="center">
  <img width="700" alt="Índices" src="https://github.com/user-attachments/assets/81546999-db1a-49f9-b8c0-a206b71a5e88" />
  <br>
  <sup><em>Índices en SQL</em></sup>
</div>
<br>

* **Integridad de Datos:** Posibles problemas, reglas de eliminación y actualización.
* **Disparadores (Triggers) e Integridad.**
* **Procedimientos Almacenados (Stored Procedures).**
* **Funciones recursivas:** Implementadas con algoritmos iterativos o usando Common Table Expressions (CTE).
* **Creación y eliminación de índices.**
* **Catálogo de sistema:** Contenido y obtención de información.

### Vistas
<div align="center">
  <img width="700" alt="Vistas SQL" src="https://github.com/user-attachments/assets/5928892d-4809-4e3e-a13c-c8e0dc28cf9c" />
  <br>
  <sup><em>Abstracción de datos mediante vistas</em></sup>
</div>
<br>

* Concepto.
* Ventajas
* Desventajas
* Sentencias
    * Creación.
    * Actualización.

---

<a id="unidad-6"></a>
## Unidad Temática N.º 6 - Procesamiento y Optimización de Consultas

<div align="center">
  <img width="700" alt="Estrategias para Optimizar Consultas SQL" src="https://github.com/user-attachments/assets/3b21ba4c-f158-474d-a79c-d10776c20e00" />
  <br>
  <sup><em>Proceso de Optimización de Consultas</em></sup>
</div>
<br>

* **Optimización de consultas:**
  * Etapas en el procesamiento de consultas y Leyes de Transformación.
  * Estrategia de descomposición y procesamiento de consultas.
  * Componentes del costo de ejecución de una consulta.
* **Catálogo de las Bases de datos:** Su importancia en la optimización de consultas.
  * Análisis de un plan de ejecución de un Motor de Base Datos Comercial.
  * Ajustes del Rendimiento y Estrategias de Optimización para la reducción de costos.

---

<a id="unidad-7"></a>
## Unidad Temática N.º 7 - Transacciones y Control de Concurrencia

<div align="center">
  <img width="700" alt="Transacciones" src="https://github.com/user-attachments/assets/d0e58794-5a59-4d15-8020-d71d93faaf93" />
  <br>
  <sup><em>Ciclo de vida de una transacción</em></sup>
</div>
<br>

<div align="center">
  <img width="700" alt="Locking en Bases de Datos" src="https://github.com/user-attachments/assets/92af2fb0-856c-4658-9ff8-8d14af54b2ec" />
  <br>
  <sup><em>Mecanismos de bloqueo y concurrencia</em></sup>
</div>
<br>

* Concepto de transacciones y Propiedades ACID.
* Procesamiento y estados de las transacciones.
* Puntos de guarda.
* Recuperación del sistema, puntos de verificación y planes de recuperación.
* Problemas de concurrencia, tipos de bloqueos y resolución del bloqueo mortal.
* Pruebas de seriabilidad y Protocolo de dos fases.
* Tratamiento de procesamiento multiusuario.
* Control de concurrencia basado en ordenamientos por marcas de tiempo.
* Técnicas de validación, granularidad múltiple y esquemas multiversión.
* Interbloqueos y técnicas de cerramiento
    * Explícito.
    * Niveles.
    * Parámetros de cierre.

---

<a id="unidad-8"></a>
## Unidad Temática N.º 8 - Seguridad e Integridad de las Bases de Datos

<div align="center">
  <img width="700" alt="Seguridad de Bases de Datos" src="https://github.com/user-attachments/assets/af6707a7-4650-4688-92e6-f9e1f21e403c" />
  <br>
  <sup><em>Gestión de seguridad y control de acceso</em></sup>
</div>
<br>

<div align="center">
  <img width="700" height="1050" alt="DCL" src="https://github.com/user-attachments/assets/1e41932e-ad86-4457-95ed-513ecc2c82de" />
  <br>
  <sup><em>DCL - Data Control Language</em></sup>
</div>
<br>

<div align="center">
  <img width="700" alt="DCL Ejemplos" src="https://github.com/user-attachments/assets/6fba79e0-c4a4-42b0-8576-d4dd953918f0" />
  <br>
  <sup><em>DCL - Ejemplos</em></sup>
</div>
<br>

* Concepto
* Tipos de seguridad y la seguridad específica de las Bases de Datos.
* Tipos de fallas y planes de contingencia.
* Técnicas de control de acceso y uso indiscriminado de la información.
* Privilegios, autorizaciones, vistas y cifrado de datos.
* Asignación y retiro de privilegios.

---

<a id="unidad-9"></a>
## Unidad Temática N.º 9 - Sistemas de Bases de Datos Distribuidas

<div align="center">
  <img width="700" alt="Sistemas de Bases de Datos Distribuidas" src="https://github.com/user-attachments/assets/d41fc462-709b-4420-9e9e-809ff5abbe42" />
  <br>
  <sup><em>Arquitectura de un entorno distribuido</em></sup>
</div>
<br>

* Estructuras y consideraciones al distribuir una Base de Datos.
* Transparencia y autonomía.
* Técnicas de fragmentación, réplica y asignación de datos.
* Procesamiento distribuido de consultas y recuperación en sistemas distribuidos.
* Protocolos de compromiso y relación con la arquitectura cliente servidor.

---

<a id="unidad-10"></a>
## Unidad Temática N.º 10 - Bases de Datos Avanzadas

<div align="center">
  <img width="700" alt="Tipos de Bases de Datos" src="https://github.com/user-attachments/assets/1df75c80-5516-4c76-aaee-1f6cd5bdff7a" />
  <br>
  <sup><em>Ecosistema de Bases de Datos Modernas</em></sup>
</div>
<br>

<div align="center">
  <img width="700" alt="Bases de Datos Espaciales" src="https://github.com/user-attachments/assets/31d6868d-d4ac-4b96-9fa5-aa3a3d0dd7f7" />
  <br>
  <sup><em>Conceptos de Bases de Datos Espaciales</em></sup>
</div>
<br>

* **Modelo Semiestructurado y XML:** Cultura Web vs Cultura de Base de Datos.
* **Representación de los datos mediante grafos:**
  * Datalog y problemas del HTML.
  * Sintaxis Básica del XML, uso de los DTD (Data Type Definition) y contribuciones a la WEB.
* **Base de Datos Temporales:** Marcas de Tiempo y Relación Temporal.
* **Base de Datos Espaciales:** Puntos, Líneas, Regiones y Operaciones Espaciales.
* **Bases de Datos móviles:** Soluciones Actuales.

---

<a id="herramientas-utilizadas"></a>
## 🛠️ Herramientas Utilizadas
* **Draw.io**: Utilizado para el modelado conceptual, diagramas de Entidad-Relación y diseño de esquemas relacionales.
* **Álgebra Relacional RelaX**: Entorno web interactivo para ejecutar y evaluar expresiones de álgebra relacional.
* **SQL Server Management Studio (SSMS)**: IDE principal para la administración de la base de datos y ejecución de scripts T-SQL.

---

<a id="estructura-del-proyecto"></a>
## 📁 Estructura del Proyecto
```text
📦 Bases de Datos
 ┣ 📂 DER
 ┃ ┣ 📜 Ejercicios.drawio
 ┃ ┗ 📜 Enunciados.pdf
 ┣ 📂 Algebra
 ┃ ┣ 📜 Ejercicios.txt
 ┃ ┗ 📜 Enunciados.pdf
 ┣ 📂 SQL
 ┃ ┣ 📜 Ejercicios.sql
 ┃ ┗ 📜 Enunciados.pdf
 ┗ 📜 README.md
```
