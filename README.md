# Disney Characters API App!

This app displays Disney characters retrieved from [Disney dev API](https://disneyapi.dev).

1. Main Features
- Favorite Character: You can add or remove your favorite character by clicking on the button in the detail page. Your favorites are persiting and you can always see them whenever you return to the app.
- Sorting: Click on the sort button on the top right corner and sort as you wish either the number of short films or films. 

2. Tech Stack
- 100% Swift
- 100% SwiftUI
- Combine for concurrent programming
- MVVM
- Unit testing
- No external libraries in use

3. System Design
Adhering to Clean Architecture, project layers are separated as follows:
- Application: Along with app's entry point as @main App, it has Dependencies too. Dependencies are propagated via EnviromentObject.
- Domain: Defines app's business logic with Entities, RepositoryInterfaces, and UseCases. Each of these are divided into MainPage and DetailPage, adhering their purpose.
- Data: Defines Repository implementations.
- Services: Defines app's data transfer implementations including remote(NetworkService) and local(UserDefaultsStorage).
- Presenters: Contains MainPage and DetailPage, associated with corresponding Views and ViewModels.
- Common: Contains shared files such as extensions, UI components, modifiers, and error.
- Tests: Currently only Unit Tests are included.
