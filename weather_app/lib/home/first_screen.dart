import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class first_screen extends StatefulWidget {
  @override
  State<first_screen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<first_screen> {
  void _searchCountry(String country) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        );
      },
    );

    fetchWeatherData(country).then((data) {
      setState(() {
        currentWeather = data['weather'][0]['main'];
        Temperature = data['main']['temp'];
        Wind = data['wind']['speed'];
        humidity = data['main']['humidity'];
      });

      // Hide the loading indicator
      Navigator.of(context).pop();
    }).catchError((error) {
      // Hide the loading indicator
      Navigator.of(context).pop();
      print('Error fetching weather data: $error');
    });
  }

  Future<Map<String, dynamic>> fetchWeatherData(String country) async {
    final String apiKey = "efbc715439910b329ffe2914199552df";
    final String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$country&units=metric&appid=$apiKey';

    final http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  String currentWeather = '';
  int humidity = 0;
  double Temperature = 0.0;
  double Wind = 0.0;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Padding(padding: EdgeInsets.all(39)),
      Container(
        margin: EdgeInsets.only(right: 20, left: 20),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 219, 218, 218),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.black),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                String searchCountry = _controller.text;
                _searchCountry(searchCountry);
              },
              child: Icon(Icons.arrow_forward, color: Colors.black),
            ),
          ],
        ),
      ),
      Row(
        children: [
          Padding(padding: EdgeInsets.only(top: 90, left: 230)),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            label: const Text(
              'Location',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 132, 196, 248),
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        padding: EdgeInsets.all(25),
        color: Colors.grey[200],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Current Weather : ',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '$currentWeather',
              style: TextStyle(
                color: Colors.green,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Container(
        padding: EdgeInsets.all(25),
        color: Colors.grey[200],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Temperature : ',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '${Temperature.toStringAsFixed(2)}°C',
              style: TextStyle(
                color: Colors.green,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Container(
        padding: EdgeInsets.all(25),
        color: Colors.grey[200],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Wind Speed : ',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '${Wind.toStringAsFixed(2)} m/s ',
              style: TextStyle(
                color: Colors.green,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        padding: EdgeInsets.all(25),
        color: Colors.grey[200],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 70),
              child: Text(
                'Humidity : ',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '$humidity%',
              style: TextStyle(
                color: Colors.green,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ])));
  }
}
