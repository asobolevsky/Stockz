# Stockz - iOS Stock Portfolio App

A test iOS stock portfolio management app built with SwiftUI and MVVM architecture. Stockz lets you browse stocks, manage a portfolio, and manage account.

## Thought process

### 1. Defining the Problem and Goals

The initial requirements were to create a simple one-screen app that would display the stock list from an API. I expanded the original single-screen app to include portfolio and account views. Throughout development, I used Cursor for code suggestions and ChatGPT for UI design inspiration and asset generation.

### 2. Planning the Architecture

I went with a modular setup so each feature stays decoupled and easy to test. I broke down the app into modules such as Stocks, Holdings, and Account, each with its own ViewModels, Views, and Models.

I decided on the MVVM pattern because it fits naturally with SwiftUI, allowing for clear separation between UI and business logic, and I'm more familiar with this approach.

### 3. Designing the Data Flow

I mapped out how data would flow through the app using a centralized AppState approach. The AppStateStore serves as the single source of truth for all application data, including user information, portfolio details, and transaction history. Services like PortfolioService and NetworkManager interact with this centralized state to perform business logic operations. ViewModels observe and update the AppState, then expose relevant state to the Views. AppState keeps data in sync while Views stay purely declarative.

### 4. Implementing the UI

I created a separate Theme system to ensure consistent styling across the app.


## Stack
- Swift, SwiftUI, Combine, XCTest
- Xcode, Cursor

## Architecture & Design

### Project Structure

This project follows a **modular architecture** pattern, organizing code into distinct modules for maintainability, testability, and scalability.

```
Stockz/
├── App/                    # Application entry point
├── Common/                 # Shared components and utilities
│   ├── Extensions/         # Swift extensions
│   ├── UI/                # Reusable UI components
│   │   ├── Theme/         # App theming system
│   │   ├── ViewModels/    # Base view model classes
│   │   └── Views/         # Common UI views
├── Modules/               # Feature modules
│   ├── Core/              # Core app functionality
│   ├── Stocks/            # Stock listing and details
│   ├── Holdings/          # Portfolio management
│   └── Account/           # User account management
├── Services/              # Business logic services
│   └── Networking/        # Network layer
└── Resources/             # Assets and resources
```

## Building the Project

1. Clone the repository
2. Open `Stockz.xcodeproj` in Xcode
3. Select target device/simulator
4. Build and run (⌘+R)

## Next steps I’d like to tackle

1. **Real-time Updates**: WebSocket integration for live pricing
2. **Portfolio Analytics**: Charts and performance metrics
3. **Stock Search**: Enhanced search and filtering
4. **Offline Support**: Core Data integration for offline access
5. **Push Notifications**: Price alerts and news notifications
6. **Watch App**: Apple Watch companion app
7. **Widgets**: iOS home screen widgets for quick portfolio overview