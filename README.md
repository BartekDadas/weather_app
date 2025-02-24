# Weather App

A Flutter weather application that shows current weather and forecast data based on user location or city search.

# Images

### IOS

<img
     src="https://drive.google.com/uc?export=view&id=1CMpA5-rcCtErGZna5akYzL_ju0rwtzjc" 
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 15%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)"/>
<img
     src="https://drive.google.com/uc?export=view&id=1V47d0_RnQAeXHLd1lnTYCaKRw6yekgJo" 
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 15%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)"/>
<img
     src="https://drive.google.com/uc?export=view&id=1I743hWmNRiJc8KiUKMRX-XUJ4bh_K7N3" 
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 15%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)"/>
<img
     src="https://drive.google.com/uc?export=view&id=1jxAmfP663ujNr3qJ9EFKzFu4DNIUzPru" 
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 15%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)"/>

### Android

<img
     src="https://drive.google.com/uc?export=view&id=1Al0GWPAKzoDtRxH94BtQhOg-aEhFQkzZ" 
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 15%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)"/>
<img
     src="https://drive.google.com/uc?export=view&id=1V-Yi4eg_X-xG1Of_p5xyMs22y0ZmiDzL" 
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 15%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)"/>
<img
     src="https://drive.google.com/uc?export=view&id=1XCw0bu6deIU94OYWMVH_-MDkUco5SUAa" 
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 15%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)"/>
<img
     src="https://drive.google.com/uc?export=view&id=1VqNqe_RYW574EuTQfB5PQ985om9sfxPk" 
     alt="sample image"
     style="display: block; margin-right: auto; margin-left: auto; width: 15%;
     box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)"/>
     
[Video](https://drive.google.com/file/d/1eQgcXbj-mt7O2dBwEeAnY55OeHRzb73F/view)
<video width="640" height="360" controls>
  <source src="https://drive.google.com/uc?id=1eQgcXbj-mt7O2dBwEeAnY55OeHRzb73F" type="video/mp4">
  Your browser does not support the video tag.
</video>

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
