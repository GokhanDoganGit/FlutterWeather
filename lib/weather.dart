import 'package:yourweather/location.dart';
import 'networking.dart';

const apiKey = 'a4d49b90d1000d706bfb3d77ff805f31';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationZipCode() async {
    Location location = Location();
    var zipCode = await location.getAddressFromLatLng();
    return zipCode;
  }

  Future<dynamic> getLocationZipCodeForCity(double lon, double lat) async {
    Location location = Location();
    var zipCode = await location.getAddressFromLatLngForCity(lon, lat);
    //zipCode = zipCode.substring(0, 2);
    return zipCode;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'Şort ve 👕 Zamanı';
    } else if (temp > 20) {
      return 'Piknik Yapmalık';
    } else if (temp < 10) {
      return '🧣 ve 🧤 Zamanı';
    } else {
      return 'Yanında bulunsun 🧥';
    }
  }
}
