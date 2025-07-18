# 📚 QuickQuotes - Aplicación de Citas Inspiradoras

QuickQuotes es una aplicación móvil desarrollada en Flutter que permite visualizar, guardar y explorar citas inspiradoras. Utiliza la API pública de [ZenQuotes](https://zenquotes.io) para obtener contenido motivacional, y ofrece funcionalidades para compartir, guardar historial, y explorar autores destacados.

---

## 🚀 Características

- ✅ Visualiza la **cita del día** (`/today`)
- ✅ Obtén una **cita aleatoria** (`/random`)
- ✅ Muestra una **lista de citas**
- ✅ Guarda el historial de citas con **SQLite + Provider**
- ✅ Funciona en **modo sin conexión**
- ✅ Personaliza preferencias: idioma, recordatorio, sonido
- ✅ Comparte citas con otras apps
- ✅ Explora una pantalla de **autores destacados**
- ✅ Diseño visual clásico con fondo tipo pergamino
- ✅ Soporte multilenguaje (español / inglés)

---

## 🖼️ Capturas de Pantalla

![Foto1](/foto1.png)
![Foto2](/foto2.png)
![Foto3](/foto3.png)
---

## 📁 Estructura del Proyecto

```
lib/
├── main.dart
├── db/
│   └── quote_database_helper.dart
├── models/
│   └── quote_model.dart
├── providers/
│   └── quote_provider.dart
├── screens/
│   ├── home_screen.dart
│   ├── preferences_screen.dart
│   ├── about_screen.dart
│   ├── quotes_library_screen.dart
│   ├── quote_history_screen.dart
│   ├── authors_screen.dart
│   └── author_quotes_screen.dart
├── services/
│   └── quote_service.dart
├── theme/
│   └── app_theme.dart
└── widgets/
    └── app_drawer.dart
```

---

## 🧠 Tecnologías Utilizadas

- Flutter 3.x
- Provider
- SharedPreferences
- SQLite (sqflite)
- HTTP Client
- Google Fonts
- share_plus

---

## 🔗 API Utilizada

- [ZenQuotes.io](https://zenquotes.io/)
  - `/today` → Cita del día
  - `/random` → Cita aleatoria
  - `/quotes/author/{name}` → Requiere API Key PRO

---

## 📌 Consideraciones

- La búsqueda por autor requiere el plan PRO de la API.
- Si no hay conexión, la app ofrece un **modo sin conexión** con la última cita cargada.
- El historial de citas se guarda localmente usando SQLite y puede consultarse offline.
- Si se realizan más de 5 peticiones a la API en menos de 30 segundos, no se mostrarán más citas debido a las limitaciones de la cuenta gratuita
---

## 👤 Autor

**Felipe Pérez**  
Estudiante de Ingeniería en Desarrollo de Videojuegos y Realidad Virtual  
Universidad de Talca — Curso PDSO-2501

---

## 🎬 Video de Presentación

****  
