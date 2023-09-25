import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class loadingScreen extends StatefulWidget {
  const loadingScreen({super.key});

  @override
  State<loadingScreen> createState() => _loadingScreenState();
}

// ignore: camel_case_types
class _loadingScreenState extends State<loadingScreen> {
  @override
  void initState() {
    super.initState();

    getLocation();
  }

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}


      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       getLocation();
      //     },
      //     child: const Text('Get Location'),
      //   ),
      // ),