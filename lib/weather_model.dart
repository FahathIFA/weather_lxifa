class Weather {
  String? temp;
  String? wind;
  String? desc;
  List<Forecast>? forecast;

  Weather({this.temp, this.wind, this.desc, this.forecast});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        temp: json['temperature'],
        wind: json['wind'],
        desc: json['description'],
        forecast: List<Forecast>.from(
            json['forecast'].map((item) => Forecast.fromJson(item))),
      );
}

class Forecast {
  String? day;
  String? temp;
  String? wind;

  Forecast({this.day, this.temp, this.wind});

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        day: json['day'],
        temp: json['temperature'],
        wind: json['wind'],
      );
}
