# SOS Button App

![SOS Button App]

## Overview

The SOS Button App is a Flutter application that showcases the practical use of the Flutter Location package to provide location-based emergency assistance. The app includes an SOS button feature that enables users to quickly share their current location using Google Maps in case of emergencies.

## Features

- **SOS Button:** Allows users to trigger an emergency alert.
- **Location Services:** Utilizes the Flutter Location package to access and display the user's current location on Google Maps.
- **Google Maps Integration:** Opens Google Maps with a pin at the user's location for easy navigation and sharing.

## How It Works

1. **SOS Button Activation:**
   - When the user taps the SOS button in the app, it initiates an emergency alert.

2. **Location Retrieval:**
   - The app uses the Flutter Location package to retrieve the user's current location using GPS.

3. **Google Maps Display:**
   - After obtaining the location, the app opens Google Maps with a pin at the user's location, making it easy for others to locate them.

4. **Technical Details:**
   - In the background, the app collects technical data about the location, including accuracy, altitude, speed, etc.

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/321dhruuv0037/MAD_PWA_Assignment1.git

2. Navigate to the project directory:
    ```bash
    cd sos_button_app

3. Install dependencies:
    ```bash
    flutter pub get

4. Run the app:
    ```bash
    flutter run

## Requirements

- Flutter SDK
- Dart SDK
- Android Studio / VScode 
- Internet connection (for Google Maps functionality)

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests to improve the app.

## Credits

- **Flutter Location Package:** [https://pub.dev/packages/location](https://pub.dev/packages/location)
- **Url Launcher Package:** [https://pub.dev/packages/url_launcher](https://pub.dev/packages/url_launcher)

