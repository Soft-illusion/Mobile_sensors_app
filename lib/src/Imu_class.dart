import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'package:geometry_msgs/msgs.dart';
import 'package:sensor_msgs/msgs.dart';

class IMU{
    double ax = 9.0;
    List<double>? _accelerometerValues;
    List<double>? _magnetometerValues;
    List<double>? _gyroscopeValues;
    List<StreamSubscription<dynamic>> _streamSubscriptions = <StreamSubscription<dynamic>>[];
    List<String>? accelerometer;
    List<String>? gyroscope;
    List<String>? mag;
    Vector3? acc_data;
    Vector3? gyro_data;
    Vector3? mag_data;
    

    List<StreamSubscription<dynamic>> get_stream(){
      return _streamSubscriptions;
    }

    Imu get_imu_message(){
      acc_data = Vector3(x: _accelerometerValues![0] , y: _accelerometerValues![1] , z: _accelerometerValues![2] );
      gyro_data = Vector3(x: _gyroscopeValues![0] , y: _gyroscopeValues![1] , z: _gyroscopeValues![2] );
      return Imu(angular_velocity: gyro_data ,linear_acceleration: acc_data);
    }

    MagneticField get_mag_message(){
      mag_data = Vector3(x: _magnetometerValues![0] , y: _magnetometerValues![1] , z: _magnetometerValues![2] );
      return MagneticField(magnetic_field: mag_data);
    }
   
    void convert_to_str(){
      accelerometer =_accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
      gyroscope =_gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
      mag =_magnetometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    }
    
    void list_subscriber(){
     _streamSubscriptions.add(accelerometerEvents.listen((AccelerometerEvent event){}));
     _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {}));
     _streamSubscriptions.add(magnetometerEvents.listen((MagnetometerEvent event) {}));
    }

    void update(){
        accelerometerEvents.listen((AccelerometerEvent event) {
        _accelerometerValues = <double>[event.x, event.y, event.z];
        });

        gyroscopeEvents.listen((GyroscopeEvent event) {
          _gyroscopeValues = <double>[event.x, event.y, event.z];
        });

        magnetometerEvents.listen((MagnetometerEvent event) {
          _magnetometerValues = <double>[event.x, event.y, event.z];
        });
    }

    Scaffold create_UI(){
      convert_to_str();
      Scaffold UI = Scaffold(
        appBar: AppBar(
          title: const Text("Raw IMU Data"),
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
                    'Accelerometer : $accelerometer',
                    style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
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
                  Text('Gyroscope : $gyroscope',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
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
                  Text('Magnetometer : $mag',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ); 
      return UI;
    }
}