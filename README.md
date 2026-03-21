# Diseños Flutter — Curso Udemy

Proyecto de práctica del curso de diseños UI con Flutter. Contiene widgets personalizados, animaciones y componentes visuales construidos progresivamente a lo largo del curso.

## Contenido

### Widgets

| Widget | Descripción |
|--------|-------------|
| `Slideshow` | Carrusel de slides con indicadores de página (dots) animados, posición configurable (arriba/abajo) y colores personalizables |
| `RadialProgressBar` | Barra de progreso circular dibujada con `CustomPainter`, soporta gradientes y animaciones de transición |
| Headers | Colección de headers con distintas formas: cuadrado, bordes redondeados, diagonal, triangular, pico, curvo y wave |

### Páginas

- **SlideshowPage** — Demo del widget `Slideshow` con SVGs y controles deslizantes para personalizar los dots en tiempo real
- **GraficasCircularesPage** — Demo de `RadialProgressBar` con múltiples instancias
- **AnimacionesPage** — Animaciones encadenadas sobre un cuadrado: rotación, opacidad, traslación y escala
- **HeadersPage** — Galería de los distintos estilos de headers

### Retos

- `CuadradoAnimadoOut` — Variante del cuadrado animado como ejercicio independiente

## Tecnologías

- **Flutter** / Dart 3.11+
- **Provider** — manejo de estado reactivo en el `Slideshow`
- **CustomPainter** — gráficos personalizados para headers y barras de progreso
- **flutter_svg** — renderizado de assets SVG

## Estructura

```
lib/
├── main.dart
└── src/
    ├── pages/          # Pantallas de demostración
    ├── widgets/        # Widgets reutilizables (slideshow, headers, radial progress)
    ├── models/         # Modelos de estado (SliderModel)
    ├── labs/           # Variantes experimentales
    └── retos/          # Ejercicios del curso
assets/
└── svgs/              # Imágenes SVG usadas en el slideshow
```

## Correr el proyecto

```bash
flutter pub get
flutter run
```
