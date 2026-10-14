# RecetarioApp

Aplicación iOS personal de recetas peruanas, creada con SwiftUI. Permite explorar preparaciones culinarias, consultar sus ingredientes y pasos, buscar recetas, filtrarlas por categoría y marcarlas como favoritas durante la sesión.

## Funcionalidades

- Catálogo principal en cuadrícula adaptable de tarjetas.
- Búsqueda por nombre de receta.
- Vista de destacados con paginación horizontal y secciones por categoría.
- Lista alternativa con filtros por categoría y opción de mostrar solo favoritos.
- Pantalla de detalle con imagen, porción, categoría, ingredientes y preparación.
- Marcado y desmarcado de favoritos en memoria.
- Categorías disponibles: desayuno, almuerzo, cena y especería.

## Tecnologías

- Swift
- SwiftUI
- Observation (`@Observable`, `@Environment` y `@Bindable`)
- Foundation y `Codable` para la carga de datos locales JSON
- UIKit, mediante representables, para el componente de páginas destacado

No se utilizan dependencias externas.

## Arquitectura

La aplicación sigue una organización sencilla por capas:

```
RecetarioApp/
├── Model/
│   ├── Recetario.swift       # Entidad de dominio y categorías
│   └── ModelData.swift       # Estado observable y carga de datos
├── Resources/
│   └── Recetas.json          # Catálogo local de recetas
├── Views/
│   ├── Categorias/           # Destacados y filas por categoría
│   ├── Helpers/              # Componentes visuales reutilizables
│   ├── PageView/             # Paginación basada en UIPageViewController
│   └── Recetario/            # Catálogo, lista, tarjetas y detalle
└── RecetarioAppApp.swift     # Punto de entrada y composición del entorno
```

`RecetarioAppApp` crea una única instancia de `ModelData` y la inyecta en el entorno. Las vistas la consumen mediante `@Environment(ModelData.self)`; de esta forma, el cambio de favorito se refleja automáticamente en las pantallas que dependen de esos datos.

## Navegación

La interfaz utiliza un `TabView` con tres pestañas:

| Pestaña | Vista | Propósito |
|---|---|---|
| Principal | `RecetarioCardList` | Explora todas las recetas como tarjetas y busca por nombre. |
| Destacado | `CategoriaHome` | Muestra recetas destacadas paginadas y grupos por categoría. |
| Lista | `RecetarioList` | Consulta las recetas en lista, con búsqueda y filtros. |

Cada receta abre `RecetarioDetail`, desde donde puede marcarse o desmarcarse como favorita.

## Datos

Las recetas se incluyen dentro del paquete de la aplicación en `Resources/Recetas.json` y se decodifican al iniciar mediante la función genérica `load<T: Decodable>(_)`.

Cada elemento debe cumplir el siguiente esquema:

```json
{
  "id": 1001,
  "name": "Nombre de la receta",
  "porcion": "Para 4 personas",
  "ingredientes": "- Ingrediente 1\\n- Ingrediente 2",
  "preparacion": "1. Primer paso\\n2. Segundo paso",
  "isFavorite": false,
  "isFeatured": false,
  "category": "Almuerzo",
  "imageName": "NombreDelAsset"
}
```

`category` debe coincidir con uno de los valores definidos en `Recetario.Category`: `Desayuno`, `Almuerzo`, `Cena` o `Especeria`. El valor de `imageName` debe corresponder a una imagen incluida en `Assets.xcassets`. Para una receta destacada, también se espera el recurso `<imageName>_feature`.

> Los favoritos se mantienen únicamente en memoria: se restablecen al cerrar o reiniciar la aplicación.

## Ejecución

1. Abra `RecetarioApp.xcodeproj` en Xcode.
2. Seleccione un simulador o dispositivo iOS compatible.
3. Ejecute el esquema **RecetarioApp** con **Run** (`⌘R`).

## Extender el catálogo

Para añadir una receta:

1. Añada sus imágenes al catálogo de assets con el nombre indicado en `imageName`.
2. Si será destacada, añada también la imagen terminada en `_feature`.
3. Incorpore un objeto con el esquema anterior a `Recetas.json`, usando un `id` único.
4. Compile y ejecute la aplicación para comprobar la decodificación y la presentación.

## Limitaciones actuales

- El catálogo se distribuye como un JSON local; no hay sincronización remota.
- Los cambios de favoritos no se persisten entre ejecuciones.
- Un error de recurso o de formato en `Recetas.json` detiene la carga al iniciar, para exponer el problema durante desarrollo.
