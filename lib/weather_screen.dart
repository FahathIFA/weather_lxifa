import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_lxifa/error_page.dart';

import 'package:weather_lxifa/weather_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key, required this.text}) : super(key: key);
  final text;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Screen'),
      ),
      body: FutureBuilder<Weather>(
          future: httpRequest(widget.text),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  children: [
                    _builtText(widget.text, 50.0, Colors.black, true),
                    _builtText('Today', 40.0, Colors.grey, true),
                    _builtText(snapshot.data!.desc.toString(), 20.0,
                        Colors.black, false),
                    SizedBox(
                      height: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildDisplayCard(Icons.thermostat,
                              snapshot.data!.temp.toString(), Colors.red),
                          _buildDisplayCard(Icons.air,
                              snapshot.data!.wind.toString(), Colors.blue),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Card(
                        color: Colors.cyan,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              FittedBox(
                                child: _builtText('Forcast for Tommarrow ', 20,
                                    Colors.black, true),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.thermostat,
                                      size: 30,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: _builtText(
                                        snapshot.data!.forecast!.first.temp
                                            .toString(),
                                        20,
                                        Colors.white,
                                        true),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.air,
                                      size: 30,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: _builtText(
                                        snapshot.data!.forecast!.first.wind
                                            .toString(),
                                        20,
                                        Colors.white,
                                        true),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const ErrorPage();
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Container _buildDisplayCard(IconData icon, String result, Color iconColor) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.cyan[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Icon(
                icon,
                size: 40,
                color: iconColor,
              ),
              const SizedBox(
                height: 10.0,
              ),
              FittedBox(
                child: Text(
                  result,
                  style: const TextStyle(fontSize: 40.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _builtText(String text, double size, Color color, bool bold) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: TextStyle(
            fontSize: size,
            fontWeight: bold ? FontWeight.bold : null,
            color: color),
      ),
    );
  }
}

Future<Weather> httpRequest(String city) async {
  var dio = Dio();

  var responce = await dio.get('https://goweather.herokuapp.com/weather/$city');

  var _weather = Weather.fromJson(responce.data);

  return _weather;
}
