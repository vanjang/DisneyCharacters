# Disney Characters API App!

This app displays Disney characters retrieved from [Disney dev API](https://disneyapi.dev).

1. Main Features
- Favorite Character: You can add or remove your favorite character by clicking on the button in the detail page. Your favorites persist, and you can always see them whenever you return to the app.
- Sorting: Click on the sort button in the top right corner to sort characters by the number of short films or films.
- Pagination: Pages are loaded as you scroll.



2. Tech Stack
- 100% Swift
- 100% SwiftUI
- Combine for concurrent programming
- MVVM
- Unit testing
- No external libraries in use



3. System Design
Adhering to Clean Architecture, project layers are separated as follows:
- Application: Includes the app's entry point as @main App and Dependencies. Dependencies are propagated via EnvironmentObject.
- Domain: Contains Entities, RepositoryInterfaces, and UseCases. Each of these is divided into MainPage and DetailPage, adhering to their respective purposes.
- Data: Defines Repository implementations.
- Services: Defines the app's data transfer implementations including remote(NetworkService) and local(UserDefaultsStorage).
- Presenters: Contains MainPage and DetailPage, associated with corresponding Views and ViewModels.
- Common: Contains shared files such as extensions, UI components, modifiers, and error handling.
- Tests: Currently only Unit Tests are included.
