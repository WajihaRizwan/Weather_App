import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/modal/modal_weather.dart';
import 'package:weatherapp/services/weather_api.dart';
import 'package:weatherapp/weather_3.dart';

class Weather1 extends StatefulWidget {
  const Weather1({super.key});

  @override
  State<Weather1> createState() => _Weather1State();
}

class _Weather1State extends State<Weather1> {
  TextEditingController textEditingController = TextEditingController(text: "karachi");
  bool isLoading = false;
  late WeatherData weatherInfo;

  void myWeather(String city) async {
    setState(() {
      isLoading = true;
    });
    try {
      WeatherData? weatherData = await WeatherServices().fetchWeather(city);
      if (weatherData != null) {
        setState(() {
          weatherInfo = weatherData;
        });
      }
    } catch (error) {
      // Handle API call error here if needed
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    weatherInfo = WeatherData(
      name: '',
      temperature: Temperature(current: 0.0),
      humidity: 0,
      wind: Wind(speed: 0),
      maxTemperature: 0,
      minTemperature: 0,
      pressure: 0,
      seaLevel: 0,
      weather: [],
    );
    super.initState();
    myWeather(textEditingController.text); // Call to get initial weather data
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEEE d, MMMM yyyy').format(DateTime.now());
    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
               'assests/homeBG.png', // Corrected the path here
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weatherInfo.name,
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${weatherInfo.temperature.current.toStringAsFixed(2)}°C",
                          style: const TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Mostly Clear',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      formattedTime,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Hourly Forecast',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          WeatherCard(time: formattedTime, temp: '26°C', chance: '30%'),
                          const WeatherCard(time: '1 AM', temp: '26°C', chance: '80%'),
                          const WeatherCard(time: '2 AM', temp: '26°C', chance: '30%'),
                          const WeatherCard(time: '3 AM', temp: '26°C', chance: '50%'),
                          const WeatherCard(time: '4 AM', temp: '26°C', chance: '40%'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Positioned icons and buttons
          Positioned(
            bottom: 20,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.location_pin, color: Colors.white),
              onPressed: () {
                
            
              },
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
               Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Weather3()),
                );
              },
            ),
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: FloatingActionButton(
              onPressed: () {
                // Handle add button press
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final String time;
  final String temp;
  final String chance;

  const WeatherCard({super.key, required this.time, required this.temp, required this.chance});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Icon(Icons.cloud, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            temp,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            '$chance rain',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
