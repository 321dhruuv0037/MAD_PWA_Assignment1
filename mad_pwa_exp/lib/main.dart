import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOS Button',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _getMapsLink() async {
    try {
      Location location = new Location();
      bool _serviceEnabled;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _locationData = await location.getLocation();
      print("Accuracy:" +
          _locationData.accuracy.toString() +
          "\nAltitude:" +
          _locationData.altitude.toString() +
          "\nSpeed:" +
          _locationData.speed.toString() +
          "\nHeading:" +
          _locationData.heading.toString() +
          "\nLatitude:" +
          _locationData.latitude.toString() +
          "\nLogitude:" +
          _locationData.longitude.toString() +
          "\nTime:" +
          _locationData.time.toString() +
          "\nSpeed Accuracy:" +
          _locationData.speedAccuracy.toString() +
          "\nHeading Accuracy:" +
          _locationData.headingAccuracy.toString());

      Uri mapsLink = Uri.parse(
          "https://www.google.com/maps?q=${_locationData.latitude},${_locationData.longitude}");
      // print("Returning link");
      return mapsLink;
    } catch (e) {
      print("Error obtaining location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonsize = screenHeight * 0.2;
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS Button'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _sendSOS(),
          child: Icon(Icons.add_alert, size: buttonsize * 0.5),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade900,
            foregroundColor: Colors.white,
            fixedSize: Size.square(buttonsize),
            shape: CircleBorder(),
            padding: EdgeInsets.all(24),
          ),
        ),
      ),
    );
  }

  Future<void> _sendSOS() async {
    var status = await Permission.location.status;
    if (status.isDenied || status.isRestricted) {
      // Location permission is denied or restricted, request permission from the user
      status = await Permission.location.request();
      if (status.isDenied || status.isRestricted) {
        // Permission still not granted, show a message to the user
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Permission Required"),
              content:
                  Text("Location permission is required to use this feature."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
        return; // Exit the method
      }
    }
    // Get device's current location
    try {
      Uri mapsLink = await _getMapsLink();
      // print("Hello");
      print(mapsLink);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              "Location Information",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "View Location on Google Maps",
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    // Open the Google Maps link using the url_launcher package
                    try {
                      await launchUrl(mapsLink);
                    } catch (e) {
                      print("Could not launch Google Maps link" + e.toString());
                    }
                  },
                  child: const Text(
                    "Open in Google Maps",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            actionsPadding: const EdgeInsets.all(24),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print("Error obtaining location: $e");
      // Handle location retrieval error
    }
  }
}
