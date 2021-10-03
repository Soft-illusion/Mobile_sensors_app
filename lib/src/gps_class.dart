import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'package:geometry_msgs/msgs.dart';
import 'package:sensor_msgs/msgs.dart';
import 'package:geolocator/geolocator.dart';


class GPS {
  late Position location;
  double Current_Latitude = 0.0 ;
  double Current_Longitude = 0.0 ;
  late StreamSubscription<Position> positionStream;
  LocationPermission permission = LocationPermission.denied;
  bool serviceEnabled = false;
    
  void stream(){
    if (permission != LocationPermission.denied && permission != LocationPermission.deniedForever){
    print("Start streaming");
    positionStream = Geolocator.getPositionStream().listen(
      (Position location) {
          Current_Latitude = location.latitude;
          Current_Longitude = location.longitude;
      });
    }
  }
  
  NavSatFix get_gps_message(){
    return NavSatFix(latitude: Current_Latitude, longitude: Current_Longitude);
  }

  void check_permission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    stream();
  }

  void check_service_enabled() async{
      // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
  }

  Widget permission_text(){
    Widget TextBox;
    if(permission == LocationPermission.denied){
      TextBox = Container(
                  width: 250,
                  child:Text("Location permissions are denied, Check the settings",
                    textAlign:TextAlign.center,
                    style: TextStyle(
                    color: Colors.red,
                    fontSize: 15.0,
                    ),
                  )
                  );
      }
    else if (permission == LocationPermission.deniedForever) {
        TextBox = Container(
                    width: 250,
                    child:Text("Location permissions are denied forever",
                    textAlign:TextAlign.center,
                    style: TextStyle(
                    color: Colors.red,
                    fontSize: 15.0,
                    ),
                  )
                  );
      } 
    else {
      TextBox = Container(
                    width: 250,
                    child:Text("GPS data is Updated",
                    textAlign:TextAlign.center,
                    style: TextStyle(
                    color: Colors.green,
                    fontSize: 15.0,
                    ),
                  )
                  );
      }

    return TextBox;
  }


  Scaffold create_UI(){
      Scaffold UI = Scaffold(
      appBar: AppBar(
        title: const Text("Raw GPS Data"),
        actions: <Widget>[
          ElevatedButton(
          child: Text("Permission"),
          onPressed: check_permission,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Latitude : $Current_Latitude',
                  style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Longitude : $Current_Longitude',
                  style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                permission_text()
              ],
            ),
          ),
        ],
      ),
    );
    return UI;
  }

}