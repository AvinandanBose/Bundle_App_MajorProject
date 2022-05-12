import 'package:geolocator/geolocator.dart';
class Location{
  double? latitude;
  double? longitude;
  Future<dynamic> getCurrentLocation()async{
    LocationPermission permission ;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);//LocationAccuracy.high but avoid LocationAccuracy.low
      latitude = position.latitude;
      longitude = position.longitude;

    }catch(e){
      print(e);
    }
  }
}