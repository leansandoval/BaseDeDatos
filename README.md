<div align="center">
  <h1>🛢️ Bases de Datos</h1>
  <p><em>Guía práctica con ejercicios resueltos de SQL de la materia Bases de Datos (3636) - 2C 2022 - UNLaM.</em></p>

  <!-- Badges -->
  <img src="https://img.shields.io/badge/Universidad-UNLaM-1F4F90?style=for-the-badge&logo=google-scholar&logoColor=white" alt="UNLaM" />
  <img src="https://img.shields.io/badge/Año-2022-2EA043?style=for-the-badge" alt="2022" />
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
  <img src="https://wrmartineza.github.io/Administracion-de-base-de-datos/html5-imagenes/manejadores%20de%20base%20de%20datos.jpg" alt="Sistema Gestor de Base de Datos" width="550" />
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
  <img src="https://imgv2-2-f.scribdassets.com/img/document/477615112/original/34eb783418/1?v=1" alt="Tipos de Modelos de Datos" width="550" />
  <br>
  <sup><em>Evolución de los Modelos de Datos</em></sup>
</div>
<br>

<div align="center">
  <img src="https://instagram.faep28-2.fna.fbcdn.net/v/t39.30808-6/778972654_1336772775146063_7018399656362643174_n.jpg?stp=dst-jpg_e35_tt6&_nc_cat=102&_nc_map=urlgen_bucketless&ig_cache_key=Mzk2ODE3NDAxMjc5NDQxNjgxOA%3D%3D.3-ccb7-5&ccb=7-5&_nc_sid=58cdad&efg=eyJ2ZW5jb2RlX3RhZyI6IkZFRUQueHBpZHMuMTI4MC5zZHIucmVndWxhcl9waG90by5DMiJ9&_nc_ohc=LKKnGsxONywQ7kNvwEQx89p&_nc_oc=AdpsjYsSSEyHa_zvLYF6RLkpv9-6p0DdhKjJEMWXTyTDnpevOQcjJ5hTXdTEQV1Fpnifu_a4Z8P7u2DuT5RltcLV&_nc_ad=z-m&_nc_cid=0&_nc_zt=23&_nc_ht=instagram.faep28-2.fna&_nc_gid=RHPF_4wU8jFO0Qpy0Vma_A&_nc_ss=7a22e&oh=00_AQRXQ_Z-nuDAiW8oMz2piPLlJzrp41UU-lLb47WaVVZX2A&oe=6AFC43B3" alt="Relacionales vs No Relacionales" width="550" />
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
  <img src="https://image.slidesharecdn.com/ismael-151104011739-lva1-app6892/75/Dependencias-Funcionales-1-2048.jpg" alt="Dependencias Funcionales" width="550" />
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
  <img src="https://instagram.fepa1-1.fna.fbcdn.net/v/t39.30808-6/808221793_1357106096446064_1937817300902927630_n.jpg?stp=dst-jpg_e35_tt6&_nc_cat=106&_nc_map=urlgen_bucketless&ig_cache_key=Mzk4NjE4MjA1NTYzNDEyOTYyNw%3D%3D.3-ccb7-5&ccb=7-5&_nc_sid=58cdad&efg=eyJ2ZW5jb2RlX3RhZyI6IkZFRUQueHBpZHMuMTE5Ni5zZHIucmVndWxhcl9waG90by5DMiJ9&_nc_ohc=peDPcrdrU9MQ7kNvwEyTvRo&_nc_oc=AdoV5ap0xasYsjoVoVP-gZOZUd-ybt34os6FRkX86wLUjO2Lf66e04nlXtnEeCKee69EHFtYAuk81iSzymVs4yTb&_nc_ad=z-m&_nc_cid=0&_nc_zt=23&_nc_ht=instagram.fepa1-1.fna&_nc_gid=xMyLgPr-Rb8xSJr007SL-g&_nc_ss=7a22e&oh=00_AQRRNDN7uIbARzJ6l2DVgvl6ei29Nnksj-JnHpP-Qi9duw&oe=6AFC4B73" alt="Tipos de Normalizacion" width="550" />
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
  <img src="https://scontent.faep28-2.fna.fbcdn.net/v/t39.30808-6/241003893_4319332088162645_7347060820080772127_n.png?stp=dst-jpg_tt6&cstp=mx2048x2048&ctp=s2048x2048&_nc_cat=102&_nc_map=urlgen_bucketless&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFjLP0An8gv_g8-7KyCnOxnNSWprKhjUNU1JamsqGNQ1dI2iJ-7V_dpO1TROayaHEu45h7IRPxGncsZnY8pskma&_nc_ohc=s2l-X54CEMsQ7kNvwERhxI8&_nc_oc=AdoekDDvCN6CHnLwIhOHTHhayppdK4vlGrk4PHitqF8JnQ2GzTTmcX-Dz4FLDK8QLxXI1r1QTlsthrzWAZKaTraa&_nc_zt=23&_nc_ht=scontent.faep28-2.fna&_nc_gid=G2vGSDOxUpDsCQSgGrnhjw&_nc_ss=7b2a8&oh=00_AQR9DMF7alYMXhzmItzp02MMxr2sIPIiZipBOB1QSfvgcA&oe=6AF86BF2" alt="Sentencias DDL" width="450" />
  <br>
  <sup><em>Data Definition Language (DDL)</em></sup>
</div>
<br>

* Creación de una Base de Datos y de tablas.
* Modificación y eliminación de estructuras.

### Consultas
<div align="center">
  <img src="https://media.licdn.com/dms/image/v2/C4D22AQGC-XsJjhyGMw/feedshare-shrink_800/feedshare-shrink_800/0/1613678407615?e=2147483647&v=beta&t=_Hv6PmFGIvAjZ_fdobmEljArBQAcmxFFTsqgMH0CzaE" alt="Consultas SQL" width="550" />
  <br>
  <sup><em>Estructura de consultas SQL</em></sup>
</div>
<br>

* Consultas simples y condiciones de búsqueda.
* Consultas multitablas y sumarias.

### Subconsultas
<div align="center">
  <img src="https://scontent.faep28-2.fna.fbcdn.net/v/t39.30808-6/706202814_1444183997725075_1684298045250782611_n.jpg?stp=dst-jpg_tt6&cstp=mx1024x1536&ctp=s1024x1536&_nc_cat=100&_nc_map=urlgen_bucketless&ccb=1-7&_nc_sid=aa7b47&_nc_eui2=AeEC6Q48auNIFPFClh6rupOxDcqhk0waX-QNyqGTTBpf5ByFize_pPCs9DI25uwGglEL3KQdu0s3xckhlQ-Vsfxp&_nc_ohc=TF2TjLZ6e0cQ7kNvwGW1OD_&_nc_oc=Adq1PNK42jsQhaikGLdIRQNOVM6tLEW_dW8V9CRj-xSb4aDigLGldJpND-STS5se0JU235Fl6celTZr9Le7N9h3C&_nc_zt=23&_nc_ht=scontent.faep28-2.fna&_nc_gid=DXF2Z6pojx4lS_s8CbJ-QQ&_nc_ss=7b2a8&oh=00_AQRx26laEfpZZqrIAQbcPnZvYbwmwHx9ac_PPhWo5eXQYA&oe=6AF895BB" alt="Subconsultas" width="350" />
  <br>
  <sup><em>Ejemplo de subconsultas anidadas</em></sup>
</div>
<br>

* Aplicación práctica y condiciones de búsqueda avanzadas.

### Manipulación de datos (DML)
<div align="center">
  <img src="https://scontent.fepa2-1.fna.fbcdn.net/v/t39.30808-6/240973792_4319332068162647_1212454391036143238_n.png?stp=dst-jpg_tt6&cstp=mx2048x2048&ctp=s2048x2048&_nc_cat=101&_nc_map=urlgen_bucketless&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGXkhuMtDi37w5ufsODmMRsahMK5FHLAHFqEwrkUcsAcesarZSVjoMYxcM2HfU18tPU3ShxO-u6Ya72TEOVw8m9&_nc_ohc=Hpbq9XxCYxIQ7kNvwFFfF_I&_nc_oc=Ado3OhMSR7-u9jwoM52z9Xo66xTflaSctvDBg7LNuXFR34sIcsEQi9jt6ggZL-kJpFuHlLtk2GoK5ltYy7sh2b_L&_nc_zt=23&_nc_ht=scontent.fepa2-1.fna&_nc_gid=JG7rYThEtJysnrFNWgK3mQ&_nc_ss=7b2a8&oh=00_AQTV6nPSfezpNNZHLqL7WRnQ1nfyFQqNcgwPnMjnSAc5KA&oe=6AF89274" alt="Sentencias DML" width="450" />
  <br>
  <sup><em>Data Manipulation Language (DML)</em></sup>
</div>
<br>

* Inserción multifila, actualización y eliminación de filas.

### Temas Adicionales de la Unidad
* **Integridad de Datos:** Posibles problemas, reglas de eliminación y actualización.
* **Disparadores (Triggers) e Integridad.**
* **Procedimientos Almacenados (Stored Procedures).**
* **Funciones recursivas:** Implementadas con algoritmos iterativos o usando Common Table Expressions (CTE).
* **Creación y eliminación de índices.**
* **Seguridad:** Concepto, asignación y retiro de privilegios.
* **Catálogo de sistema:** Contenido y obtención de información.

### Procesamiento de Transacciones
<div align="center">
  <img src="https://scontent.faep28-2.fna.fbcdn.net/v/t39.99422-6/735222803_1031400872722762_4435234212974793794_n.png?stp=dst-jpg_tt6&cstp=mx1024x1536&ctp=s1024x1536&_nc_cat=107&_nc_map=urlgen_bucketless&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeG2Ujodx5GaM5Xkj66fg5MCCZ6-3psZ9uUJnr7emxn25VCnoykTwvSj5Q1lR-2jBgwH8Tunz-E4IKk-km6lnKBv&_nc_ohc=nOUrJ7OjYEcQ7kNvwHon35T&_nc_oc=AdpchmrZ2vzV_uCQhsWNZrds18Ye1C0OpF2HBrE-A4EcE32zlXDlgZ7ycG5MGLmME6-_dW_k-t-F7YAo65sumJCo&_nc_zt=14&_nc_ht=scontent.faep28-2.fna&_nc_gid=81IPWmjGc-UWtuzQwLkvIg&_nc_ss=7b2a8&oh=00_AQTxWj45vF_na48IbmAaZZmF5faeb813VTLrcY0zoR0tjQ&oe=6AF88FDF" alt="Transacciones" width="350" />
  <br>
  <sup><em>Ciclo de vida de una transacción</em></sup>
</div>
<br>

* Concepto, puntos de guarda y tratamiento de procesamiento multiusuario.
* Interbloqueos y técnicas de cerramiento (explícito, niveles y parámetros de cierre).

### Vistas
<div align="center">
  <img src="https://scontent.fepa1-1.fna.fbcdn.net/v/t39.30808-6/480741654_613163444912518_5324162054683845899_n.jpg?stp=dst-jpg_tt6&cstp=mx1782x2048&ctp=s1782x2048&_nc_cat=108&_nc_map=urlgen_bucketless&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEacyydnZbP4JFBpMse60Cpbdoca7hBOiBt2hxruEE6IEoqN0jMfheBixkUZUxU7rf8KGJLIFjHCyt9JHnwQGdK&_nc_ohc=S79PiS8hyuMQ7kNvwHII99Z&_nc_oc=Adrq_hu1f079jUXEx8Ayk2IbqU_g5-yb21NwOFWWJzkizQyDEoc50u0AXmZDO3LsJdPvEKXnK9WHJygk6Ag0--dp&_nc_zt=23&_nc_ht=scontent.fepa1-1.fna&_nc_gid=czhKCrDlh6_IMwMz5sTJKw&_nc_ss=7b2a8&oh=00_AQQdO8zoQmH3Yoj6RGZd4iCForJrCLuomgcJTrWUftrSDg&oe=6AF86AEF" alt="Vistas SQL" width="550" />
  <br>
  <sup><em>Abstracción de datos mediante vistas</em></sup>
</div>
<br>

* Concepto, ventajas, desventajas, sentencias de creación y actualización.

---

<a id="unidad-6"></a>
## Unidad Temática N.º 6 - Procesamiento y Optimización de Consultas

<div align="center">
  <img src="https://scontent.faep28-1.fna.fbcdn.net/v/t39.30808-6/490152007_1230345149091347_2128454070160642628_n.jpg?stp=dst-jpg_tt6&cstp=mx1200x2000&ctp=s1200x2000&_nc_cat=100&_nc_map=urlgen_bucketless&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEo79K43Q2U8RjXqMq9wVn-W-m3eZgBX3Vb6bd5mAFfdbOCLNcO8uhHJPZRJ-uHiBls5KhUdCpe8n60RKdL2KZq&_nc_ohc=QyrtYaGZMSsQ7kNvwGp5_oq&_nc_oc=AdpF-cWWuHz1FyY2OTfmAT3x6oleuPe2OkZw8ghJF3IV5BcXHBzfcGkFEPXu_xi-cheKvZQJQsMOhHQMGuKBZQrb&_nc_zt=23&_nc_ht=scontent.faep28-1.fna&_nc_gid=KtKoEUkvieBqy9oN3aJxsg&_nc_ss=7b2a8&oh=00_AQRzOK2JnlYXSIymMoVx9RLakibTEB0p2ognSsM0_SP1HQ&oe=6AFC3F88" alt="Estrategias para Optimizar Consultas SQL" width="350" />
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
  <img src="https://instagram.faep28-2.fna.fbcdn.net/v/t39.30808-6/715910533_122281530692189612_4279460914672464774_n.jpg?stp=dst-jpg_e35_tt6&_nc_cat=102&_nc_map=urlgen_bucketless&ig_cache_key=MzkxNDM1OTQ1NzIyNDU4NTExMQ%3D%3D.3-ccb7-5&ccb=7-5&_nc_sid=58cdad&efg=eyJ2ZW5jb2RlX3RhZyI6IkZFRUQueHBpZHMuMTI1NC5zZHIucmVndWxhcl9waG90by5DMiJ9&_nc_ohc=Nh7HW8lAT1sQ7kNvwFoUpiA&_nc_oc=AdolP58WI_C56ycTCuoIx3YHWUhwKFCL3cXxq95KLjD4Y3FkK-vS70UYC8-gHL9bqJUG8bIYKD8LNQyAzbz_cotF&_nc_ad=z-m&_nc_cid=0&_nc_zt=23&_nc_ht=instagram.faep28-2.fna&_nc_gid=VA2ACOLFLvgnU43c-V4Ovg&_nc_ss=7a22e&oh=00_AQQeLgLz6miQsZN6Sn2IptYi9zMqKw9Gw9uWzcqQfTAe8A&oe=6AFC3497" alt="Locking en Bases de Datos" width="550" />
  <br>
  <sup><em>Mecanismos de bloqueo y concurrencia</em></sup>
</div>
<br>

* Concepto de transacciones y Propiedades ACID.
* Procesamiento y estados de las transacciones.
* Recuperación del sistema, puntos de verificación y planes de recuperación.
* Problemas de concurrencia, tipos de bloqueos y resolución del bloqueo mortal.
* Pruebas de seriabilidad y Protocolo de dos fases.
* Control de concurrencia basado en ordenamientos por marcas de tiempo.
* Técnicas de validación, granularidad múltiple y esquemas multiversión.

---

<a id="unidad-8"></a>
## Unidad Temática N.º 8 - Seguridad e Integridad de las Bases de Datos

<div align="center">
  <img src="https://notasinformaticas.com/wp-content/uploads/2018/04/Infografia_seguridad_base_datos.png" alt="Seguridad de Bases de Datos" width="550" />
  <br>
  <sup><em>Gestión de seguridad y control de acceso</em></sup>
</div>
<br>

* Tipos de seguridad y la seguridad específica de las Bases de Datos.
* Tipos de fallas y planes de contingencia.
* Técnicas de control de acceso y uso indiscriminado de la información.
* Privilegios, autorizaciones, vistas y cifrado de datos.

---

<a id="unidad-9"></a>
## Unidad Temática N.º 9 - Sistemas de Bases de Datos Distribuidas

<div align="center">
  <img src="https://instagram.faep28-2.fna.fbcdn.net/v/t39.30808-6/778985268_1340771434746197_1413887008391237872_n.jpg?stp=dst-jpg_e35_tt6&_nc_cat=106&_nc_map=urlgen_bucketless&ig_cache_key=Mzk3MTY4NzAzOTIwMTQwNTg2MA%3D%3D.3-ccb7-5&ccb=7-5&_nc_sid=58cdad&efg=eyJ2ZW5jb2RlX3RhZyI6IkZFRUQueHBpZHMuMTI4MC5zZHIucmVndWxhcl9waG90by5DMiJ9&_nc_ohc=TsgjQ8o_WqcQ7kNvwGpolFv&_nc_oc=Adof2-RkYZ8KuIfBCUk4YxSrynPDBOyNS_VwiyrZtJRs6TVWJ0wXHulw31D7XySU3ELm8Q7dKYl1SixwKCVsI03E&_nc_ad=z-m&_nc_cid=0&_nc_zt=23&_nc_ht=instagram.faep28-2.fna&_nc_gid=CfRHU2dNkrF1EcVIEsavvw&_nc_ss=7a22e&oh=00_AQRHjRN4USpQcZobnhdc_tpO8NB7NNdLJeiFbBbiUsSrOw&oe=6AFC45B5" alt="Sistemas de Bases de Datos Distribuidas" width="550" />
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
  <img src="https://instagram.fepa2-1.fna.fbcdn.net/v/t51.82787-15/585223136_17849432763600313_2431177948249366623_n.jpg?stp=dst-jpg_e35_tt6&_nc_cat=103&_nc_map=urlgen_bucketless&ig_cache_key=Mzc3NTk4NTEwNDc5NTUxODc0MA%3D%3D.3-ccb7-5&ccb=7-5&_nc_sid=58cdad&efg=eyJ2ZW5jb2RlX3RhZyI6IkZFRUQueHBpZHMuMTQ0MC5zZHIucmVndWxhcl9waG90by5DMiJ9&_nc_ohc=FA-AsenfjR0Q7kNvwGHeuKp&_nc_oc=AdqdDUqGx8McFMvFRBJfsKSOx9SivGiexJmEIAn9bXif6LAN3U-93uQpSkhzk1-oJEwIHahNxOPtoaff6ohbgn9a&_nc_zt=23&_nc_ht=instagram.fepa2-1.fna&_nc_gid=ucNc5pR77HhmNi7tgd4Bdw&_nc_ss=7b6a8&oh=00_AQSdVtihlO7RQUXmAF3TIvCnLZNoQNPv3JJ9IhZ6_O4ecg&oe=6AFC5E58" alt="Tipos de Bases de Datos" width="550" />
  <br>
  <sup><em>Ecosistema de Bases de Datos Modernas</em></sup>
</div>
<br>

<div align="center">
  <img src="https://image.slidesharecdn.com/infografabasesdedatosespaciales-231010042821-ab5d3714/75/Infografia-bases-de-datos-espaciales-pdf-1-2048.jpg" alt="Bases de Datos Espaciales" width="550" />
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
