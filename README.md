# LEMediaApp

## Description

LEMedia APP es una aplicación que te permite visualizar las películas que se encuentran en tendencia, agrupadas por 3 categorias: Popular, Top Rated y Upcoming. 
Podrás consultar estas categorias y a su vez el detalle de la película de tu preferencia, donde encontrarás información relevante de la pelicula seleccionada, el trailer y otros videos interesantes. 
Si requieres ubicar una película en específico puedes hacer uso de la barra de búsqueda. 

## Technical details 

La aplicación fue desarrollada de acuerdo a las siguientes tecnologías: 
- Swift UI
- CLEAN
- Combine
- URLSession
- Package dependencies
- Realm
- XCTestCase
- xCode 15
- iOS 16 o superior
- Api: https://developer.themoviedb.org/reference/intro/getting-started

## Features

- Al iniciar la aplicación por primera vez se cargarán las películas desde las apis de themoviedb
- La información se almacena de manera local con Realm, por lo que permite seguir haciendo uso del app en modo offline
- Si el poster de la película no se puede cargar se mostrará el logo de la app como imagen por defecto
- La búsqueda de películas funciona de manera local
- Para el preview del trailer y los videos asociados se usa un webview con enlace a Youtube
- Si alguna de las Apis que alimenta las categorias falla, no mostrará películas para esa categoría
- Si el Api de carga de videos falla, igual podrá visualizar la información de la pelicula
- Soporta modo de visualización light y dark 
- Se incluyen pruebas unitarias y de integración con code coverage de 80% 

## Previews

### Home
![IMG_2484](https://github.com/lisbethEslava90/LEMediaApp/assets/865505/6cfbd809-0e9d-4341-8366-53fe5ad49d59) 
### Details
![IMG_2485](https://github.com/lisbethEslava90/LEMediaApp/assets/865505/603ef94f-cb00-4e12-94aa-c0c5072a04b5)
### Search
![IMG_2486](https://github.com/lisbethEslava90/LEMediaApp/assets/865505/5fa7df3a-242d-4d52-a21f-50f5942fd718) 
### No results
![IMG_2487](https://github.com/lisbethEslava90/LEMediaApp/assets/865505/449c9029-b5e5-442c-a338-541851d38fba)
### Offline support 
![IMG_2488](https://github.com/lisbethEslava90/LEMediaApp/assets/865505/4ff0b43d-4158-40e7-8090-1bb578e9c395) 
### Light mode Home
![IMG_2489](https://github.com/lisbethEslava90/LEMediaApp/assets/865505/650da9eb-bbbc-468b-8274-7bbb0dc601a0)
### Light mode Details
![IMG_2490](https://github.com/lisbethEslava90/LEMediaApp/assets/865505/154fe537-adbe-4678-bce0-54cb5521fe77)

### Created by Lisbeth Eslava
Contact: lisbeth.eslava@gmail.com
