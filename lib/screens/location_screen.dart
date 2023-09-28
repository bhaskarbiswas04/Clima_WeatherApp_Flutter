import 'package:clima_weather_app/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima_weather_app/constants.dart';
import 'package:clima_weather_app/services/weather.dart';

class locationScreen extends StatefulWidget {
  const locationScreen({super.key, this.locationWeather});

  final dynamic locationWeather;

  @override
  State<locationScreen> createState() => _locationScreenState();
}

class _locationScreenState extends State<locationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  String? weatherIcon;
  String? cityName;
  String? weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUI(weatherData: widget.locationWeather);
  }

  //Following function update the UI according to real time data.
  void updateUI({dynamic weatherData}) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherMessage = 'Can\'t fetch the weather';
        weatherIcon = null;
      } else {
        double temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        weatherMessage = weather.getMessage(temperature);

        var condition = weatherData['weather'][0]['id'];
        weatherIcon = weather.getWeatherIcon(condition);

        cityName = weatherData['name'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData: weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return cityScreen();
                      }));

                      if (typedName != null) {
                        var weatherData = await weather.weatherByCityName(
                            cityName: typedName);
                        updateUI(weatherData: weatherData);
                      }

                      // print(typedName);
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    //Temperature update
                    Text(
                      '${temperature}°C',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
