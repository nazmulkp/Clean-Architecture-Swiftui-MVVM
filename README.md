# Clean Architecture and SwiftUI Modular Project

## Overview

ExampleMVVM is an iOS application designed with Clean Architecture principles and SwiftUI modularity. This project demonstrates a scalable, maintainable, and testable architecture, leveraging dependency injection, protocol-oriented programming, and clear separation of concerns.

## Project Structure

The project is organized into distinct layers, each responsible for specific concerns:

- **App**: Entry point and application lifecycle management.
- **Presentation**: UI components and view models.
- **Domain**: Business logic and use cases.
- **Data**: Data sources and repositories.
- **Infrastructure**: Configuration, network, and utilities.

### Directory Layout
<img width="440" alt="Screenshot 2024-06-20 at 9 59 02 AM" src="https://github.com/nazmulkp/Clean-Architecture-Swiftui-MVVM/assets/8841075/39b2f3db-8d7a-4df9-a3db-1a4f382b82a7">


## Layer Responsibilities

### App

**ExampleMVVMApp.swift**: Entry point of the application, responsible for setting up the main window and initializing the dependency injection.

### Presentation

**View**: Contains SwiftUI views responsible for the UI layout and presentation.

- **WeatherView.swift**: Main view displaying weather information.
- **WeatherRowView.swift**: Subview displaying individual weather data items.

**ViewModel**: Contains view models that manage UI state and interact with the domain layer.

- **WeatherViewModel.swift**: View model for managing weather data presentation logic.

### Domain

**Interfaces**: Defines protocols for repositories and data sources, ensuring a clear contract between layers.

- **WeatherDataSource.swift**: Protocol for weather data sources.
- **WeatherRepository.swift**: Protocol for weather repositories.

**UseCases**: Contains business logic and application-specific rules.

- **FetchWeatherUseCase.swift**: Use case for fetching weather data.

**Entities**: Contains business models representing core domain objects.

- **Weather.swift**, **City.swift**, **Temperature.swift**: Domain models for weather data.

### Data

**Remote**: Contains data sources for fetching data from remote APIs.

- **RemoteWeatherDataSource.swift**: Implementation of weather data source using remote APIs.

**Local**: Contains data sources for fetching data from local files.

- **LocalWeatherDataSource.swift**: Implementation of weather data source using local JSON files.

**Repositories**: Coordinates between data sources and domain layer, transforming data as needed.

- **WeatherRepositoryImpl.swift**: Implementation of weather repository.

### Infrastructure

**Network**: Manages network communication details.

- **APIClient.swift**: Handles HTTP requests and responses.
- **HTTPMethod.swift**: Enum for HTTP methods.
- **WeatherAPIConfiguration.swift**: Constructs URLs for API endpoints.

**Configuration**: Manages application configurations.

- **AppConfiguration.swift**: Implementation of configuration protocol.

**Utilities**: Contains shared utilities and helpers.

- **JSONLoader.swift**: Utility for loading JSON from local files.

**Interfaces**: Defines protocols for infrastructure components.

- **JSONLoaderProtocol.swift**: Protocol for JSON loader.
- **APIClientProtocol.swift**: Protocol for API client.
- **ConfigurationProtocol.swift**: Protocol for configuration.

## Dependency Injection

The project leverages dependency injection to manage dependencies between layers. This ensures loose coupling and enhances testability. Dependencies are injected through initializers, allowing for easy substitution of implementations during testing.

### Example Initialization

```swift
import SwiftUI

@main
struct ExampleMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            let apiClient = APIClient()
            let appConfiguration = AppConfiguration()
            let apiConfiguration = WeatherAPIConfiguration(configuration: appConfiguration)
            let remoteDataSource = RemoteWeatherDataSource(apiClient: apiClient, apiConfiguration: apiConfiguration)
            
            let jsonLoader = JSONLoader()
            let localDataSource = LocalWeatherDataSource(jsonLoader: jsonLoader, configuration: appConfiguration)
            
            let useLocalData = false // Change this to true to use local data
            let dataSource: WeatherDataSource = useLocalData ? localDataSource : remoteDataSource
            
            let repository = WeatherRepositoryImpl(dataSource: dataSource)
            let fetchWeatherUseCase = FetchWeatherUseCase(repository: repository)
            let viewModel = WeatherViewModel(fetchWeatherUseCase: fetchWeatherUseCase)
            
            WeatherView(viewModel: viewModel)
        }
    }
}
```

# 🚀 Swift: Async/Await vs GCD vs Completion Handler (coming soon)

This guide shows a **side-by-side comparison** of three ways to handle asynchronous tasks in Swift:
- ✅ Async/Await (Modern Style)
- ⚠️ GCD (Grand Central Dispatch - Middle Style)
- ❌ Completion Handler (Old Style)

---

## 🛠 Example Side-by-Side

### 🔸 Completion Handler (Old Style)
```swift
func loadData(completion: (String) -> Void) {
    // Fake network delay
    completion("Data Loaded")
}

loadData { result in
    print(result) // Must write all code here
}
```

- ❌ Hard to read if there are many steps
- ❌ Must pass closures everywhere
- ❌ Error handling is manual

### 🔸 GCD (Middle Style)
```swift
DispatchQueue.global().async {
    let data = "Data Loaded"
    DispatchQueue.main.async {
        print(data) // Switch back to main thread
    }
}
```

- ⚠️ Better but you must manually handle queues
- ⚠️ Still a bit messy
- ⚠️ You must remember to come back to the main thread

### 🔸 Async/Await (Modern Style)
```swift
func loadData() async -> String {
    return "Data Loaded"
}

Task {
    let data = await loadData()
    print(data) // Looks like simple step-by-step code
}
```

- ✅ Super clean
- ✅ No need to manage threads
- ✅ Swift pauses and resumes automatically
- ✅ Easier error handling with try / catch

<img width="740" alt="Screenshot 2025-06-23 at 11 45 40 PM" src="https://github.com/user-attachments/assets/8b705328-9558-41b7-8dc6-e97d8c6bc67d" />


