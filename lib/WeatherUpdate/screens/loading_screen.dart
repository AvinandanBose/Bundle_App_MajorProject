import 'package:flashchatapplication_new/WeatherUpdate/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashchatapplication_new/WeatherUpdate/services/location.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:flashchatapplication_new/WeatherUpdate/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


const openMapUrl = 'https://api.openweathermap.org/data/2.5/weather';
const apiKey = 'f4d059d24fb160404187289d9b3c50d4';
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);


  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // double? latitude;
  // double? longitude;
  @override
  void initState(){
    super.initState();
    getLocation();
  }



  Future<dynamic> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    // latitude = location.latitude;
    // longitude = location.longitude;
    NetworkHelper networkHelper = NetworkHelper('$openMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var  weatherData = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(
      builder: (context){
        return LocationScreen(locationWeather:weatherData,);
    },
    ),
    );
  }



    @override
    Widget build(BuildContext context) {
      return const Scaffold(
        body: Center(

          child: SpinKitDoubleBounce(

            color: Colors.white,
            size: 100.0,
          ),
        ),
      );
    }
  }




// Future<Position> determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;
//
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     return Future.error('Location services  are disabled.');
//   }
//
//   permission = await Geolocator.checkPermission();
//   permission = await Geolocator.requestPermission();
//
//   if (permission == LocationPermission.denied) {
//     return Future.error('Location permissions are denied');
//   }
//
//
//   if (permission == LocationPermission.deniedForever) {
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }
//   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
//   print(position);
//
//   return await Geolocator.getCurrentPosition();
// }

// 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'
// dynamic decodeData = jsonDecode(data);
// double temperature = decodeData['main']['temp'];
// int condition = decodeData['weather'][0]['id'];
// String  cityName = decodeData['name'];
// print(temperature);
// print(condition);
// print(cityName);