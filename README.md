# Weather App

A Flutter weather application that shows current weather and forecast data based on user location or city search.

## Features

- Current weather information
- Location-based weather data
- City search functionality
- Favorite locations
- Dark/Light theme support

## Project Structure

```
lib/
  ├── config/        # App configuration
  ├── cubits/        # State management
  ├── models/        # Data models
  ├── repositories/  # Data layer
  ├── screens/       # UI screens
  ├── services/      # API services
  ├── utils/         # Utility functions
  └── widgets/       # Reusable widgets
```

## Getting Started

1. Clone the repository
2. Copy `.env.example` to `.env` and add your OpenWeatherMap API key
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Generate the required code:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
5. Run the app:
   ```bash
   flutter run
   ```

## Dependencies

- State Management: `flutter_bloc`
- Navigation: `go_router`
- API Communication: `retrofit`, `dio`
- Local Storage: `sqflite`
- Location: `geolocator`
- Code Generation: `freezed`, `json_serializable`
- Dependency Injection: `get_it`

## Environment Setup

Create a `.env` file in the root directory with the following content:
```
OPENWEATHER_API_KEY=your_api_key_here
OPENWEATHER_BASE_URL=https://api.openweathermap.org/data/2.5
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request
