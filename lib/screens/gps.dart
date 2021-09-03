import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class GPS extends StatefulWidget {
  const GPS({ Key? key }) : super(key: key);

  @override
  _GPSState createState() => _GPSState();

}

class _GPSState extends State<GPS> {
  late Position location;
  double Current_Latitude = 0.0 ;
  double Current_Longitude = 0.0 ;
  late StreamSubscription<Position> positionStream;
  LocationPermission permission = LocationPermission.denied;
  bool serviceEnabled = false;

  // @Override
  void initState()
  {
  super.initState();//comes first for initState();
  check_permission();
  check_service_enabled();
  }

  void stream(){
    if (permission != LocationPermission.denied && permission != LocationPermission.deniedForever){
    print("Start streaming");
    positionStream = Geolocator.getPositionStream().listen(
    (Position location) {
        setState(() {
        Current_Latitude = location.latitude;
      });
      setState(() {
        Current_Longitude = location.longitude;
      });
    });
  }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  }

}



