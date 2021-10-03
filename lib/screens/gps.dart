import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_sensors/src/gps_class.dart';

class GPSScreen extends StatefulWidget {
  const GPSScreen({ Key? key }) : super(key: key);

  @override
  _GPSState createState() => _GPSState();

}

class _GPSState extends State<GPSScreen> {
  var GPS_obj = new GPS();


  // @Override
  void initState()
  {
  super.initState();//comes first for initState();
  GPS_obj.check_service_enabled();
  Geolocator.getPositionStream().listen(
    (Position location) {
      setState(() {
        GPS_obj.check_permission();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GPS_obj.create_UI();
  }

}



