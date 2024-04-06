# mapbox_flutter_app

A new Flutter project.

## Crear cuenta en Mapbox

- Entrar a **https://www.mapbox.com**
- Crear una cuenta o iniciar sessión
- En el apartado de **Tokens**, crear un **token público** para la aplicación, y un **token privado** (este último debe tener un ámbito secreto del tipo **DOWNLOADS:READ**)

## Asociar Mapbox al proyecto Flutter

- Descargar el plugin oficial de Mapbox desde repositorio de paquetes de Dart: **https://pub.dev/packages/mapbox_gl**
- Seguir las instrucciones del proovedor del paquete (tanto para Android como para iOS)
- Para proyectos en producción, se recomienda no publicar los TOKENS en repositorios de como Github. Para ello es importante verificar como podemos declararlos desde llamdas a archivos de variables de entorno
- Ver ejemplos de implementación en **https://github.com/flutter-mapbox-gl/maps/tree/master/example/lib**
