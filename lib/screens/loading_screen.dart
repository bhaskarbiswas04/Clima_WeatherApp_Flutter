import 'package:flutter/material.dart';
import 'package:clima_weather_app/services/location.dart';

class loadingScreen extends StatefulWidget {
  const loadingScreen({super.key});

  @override
  State<loadingScreen> createState() => _loadingScreenState();
}

// ignore: camel_case_types
class _loadingScreenState extends State<loadingScreen> {

  @override
  //initState is a LifeCycle Method.
  void initState() {
    super.initState(); //This will call the method before the widget is build.
    getLocation();
  }

  void getLocation() async {
    Location loc = Location();
    await loc.getCurrentLocation();
    print(loc.latitude);
    print(loc.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
