import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:clima_weather_app/services/location.dart';
import 'package:http/http.dart';

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
    print('Latitude : ${loc.latitude}');
    print('Longitude : ${loc.longitude}');
  }

  void getData() async {
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=64.34&lon=10.99&appid=ce45277f8f99845d1d7d85a265be6a95'));

    if (response.statusCode >= 200) {
      String data = response.body;

      var temperature = jsonDecode(data)['main']['temp'];
      var condition = jsonDecode(data)['weather'][0]['id'];
      var cityName = jsonDecode(data)['name'];

    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
