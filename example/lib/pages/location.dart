import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  double? latitude = 39.909;
  double? longitude = 116.397;

  @override
  void initState() {
    super.initState();
    Permission.location.request();
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('定位')),
      body: TencentMap(
        mapType: context.isDark ? MapType.dark : MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        scaleControlsEnabled: true,
        myLocationStyle: MyLocationStyle(
          myLocationType: MyLocationType.locationRotate,
        ),
        onLocation: (location) {
          print('经纬度1=${location.latitude}, ${location.longitude}');
          latitude = location.latitude;
          longitude = location.longitude;
        },
        onMapCreated: (controller) async {
          print('经纬度2=onMapCreated');
        },
        onCameraIdle: (value) {
          print(
              '经纬度3=地图视野结束改变事件回调函数=${value.target?.latitude},${value.target?.longitude}');
        },
      ),
    );
  }
}
