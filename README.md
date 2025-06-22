# Stockz - iOS Stock Portfolio App

## Architecture & Design

### Project structure

This project follows a **modular architecture** pattern, organizing code into distinct modules. It might look like over engineering for this demo app, but it provides some benefits: it makes the codebase more maintainable, testable, and easier to understand for a new developer.

```
Stockz/
├── App/                # Application related files
├── Common/             # Shared components
├── Modules/            # Feature modules
├── Services/           # Business logic related services
└── Resources/          # Assets and resources
```

### Key Design Decisions

#### 1. **MVVM Pattern with SwiftUI**
- **ViewModel**: manages business logic and state
- **View**: SwiftUI views for presentation layer
- **Model**: data models
- **Service Layer**: handles data manipulations

**Note**: Since services can be reused in other modules, the `Services/` folder is extracted to the root level.


#### 2. **State Management**
The app uses a **finite state machine** approach with clear state transitions:

```swift
enum ViewModelState: Equatable {
    case idle
    case loading
    case loaded(T)
    case failed(String)
}
```


#### 3. **Dependency Injection**
- Services are injected through protocols
- Enables easy testing and modularity
- Default implementations provided for production use

**Note**: For future development, a global Context or scaffolding object can be introduced for handling all dependencies centrally, providing a more structured approach to dependency management across the entire application.


### Potential Features
1. **Real-time Updates**: WebSocket integration for live pricing
2. **Portfolio Analytics**: Charts and performance metrics
3. **Stock Search**: Add/remove stocks functionality
4. **Offline Support**: Core Data integration
5. **Push Notifications**: Price alerts and news


### Requirements
- Xcode 14.0+
- iOS 16.0+
- Swift 5.7+


### Building the Project
1. Clone the repository
2. Open `Stockz.xcodeproj` in Xcode
3. Select target device/simulator
4. Build and run (⌘+R)