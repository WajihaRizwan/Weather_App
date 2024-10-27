import 'package:flutter/material.dart';
import 'package:weatherapp/modal/modal_weather.dart';
import 'package:weatherapp/services/weather_api.dart';

class Weather3 extends StatefulWidget {
  const Weather3({super.key});

  @override
  State<Weather3> createState() => _Weather3State();
}

class _Weather3State extends State<Weather3> {
  TextEditingController textEditingController =
      TextEditingController(text: "karachi");
  bool isLoading = false;
  late WeatherData weatherInfo;
  final List<WeatherData> citiesWeather = [];

  void myWeather(String city) async {
    isLoading = true;
    setState(() {});
    try {
      WeatherData? weatherData = await WeatherServices().fetchWeather(city);
      if (weatherData != null) {
        setState(() {
          weatherInfo = weatherData;
          print(weatherInfo.temperature.current.toStringAsFixed(2));
        });
      } else {
        // Handle no data received
      }
    } catch (error) {
      // Handle API call error
    } finally {
      isLoading = false;
      setState(() {});
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
    myWeather(textEditingController.text); // Fetch initial weather data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF362A84),
      appBar: AppBar(
        backgroundColor:const Color(0xFF362A84),
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios),
      
        title: const Text('Weather', style: TextStyle(fontSize: 24)),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.lock_clock),
            color:Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10),
                width: 290,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                  
                    hintText: 'Search for a city or an airport',
                    hintStyle: const TextStyle(fontSize: 16),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  ),
                
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 25,),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    citiesWeather.add(weatherInfo);
                    myWeather(textEditingController.text);

                    textEditingController.clear();
                  });
                },
                child: const Text("Add"),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: citiesWeather.length,
              itemBuilder: (context, index) {
                WeatherData cityWeather = citiesWeather[index];
                return WeatherCard(
                  city: cityWeather.name,
                  temp:
                      "${cityWeather.temperature.current.toStringAsFixed(2)} °C",
                  condition: "${cityWeather.wind.speed.toString()} km/h",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final String city;
  final String temp;
  final String condition;

  const WeatherCard({super.key, 
    required this.city,
    required this.temp,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 19, 14, 49),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                temp,
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                city,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(Icons.wb_sunny,
                  color: Colors.yellow,
                  size: 30), // Change icon based on condition
              Text(
                condition,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
