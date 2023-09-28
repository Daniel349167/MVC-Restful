## MVC, RESTful Routes y CRUD en Sinatra

### Parte 1: Creación del Modelo
Vamos a crear un modelo para manejar nuestras tareas pendientes (Todos). Utilizaremos ActiveRecord con una base de datos SQLite.

#### Operaciones CRUD aplicables:
- **Index**: Mostrar todas las tareas.
- **Create**: Añadir una nueva tarea.
- **Read**: Leer una tarea específica.
- **Update**: Actualizar una tarea existente.
- **Destroy**: Eliminar una tarea.

---

### Parte 2: Rutas y URL

#### Desglosando la URL de ejemplo:
- `https://`: Protocolo
- `etsy`: Dominio
- `443`: Puerto (implícito)
- `/search`: Ruta
- `q=test`: Query (Parámetro)
- `copy`: Fragmento

#### Acciones RESTful en Sinatra:
- **Index**: GET `/todos`
- **Create**: POST `/todos`
- **Read**: GET `/todos/:id`
- **Update**: PUT `/todos/:id`
- **Destroy**: DELETE `/todos/:id`

---

### Parte 3: Respuestas y Vistas

En un protocolo RESTful como HTTP, cada solicitud debe ser seguida por una respuesta. Utilizaremos JSON para nuestras respuestas.

#### Dirección de la Respuesta:
Las respuestas irán directamente al cliente que hizo la solicitud. Podemos devolver una vista JSON o redirigir la solicitud según sea necesario.

