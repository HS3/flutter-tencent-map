import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';

class MoveCameraPage extends StatefulWidget {
  const MoveCameraPage({Key? key}) : super(key: key);

  @override
  createState() => _State();
}

class _State extends State<MoveCameraPage> {
  late TencentMapController controller;
  var animated = false;
  static final position1 = CameraPosition(
    target: LatLng(latitude: 39.97837, longitude: 116.31363),
    zoom: 19,
    bearing: 45,
    tilt: 45,
  );
  static final position2 = CameraPosition(
    target: LatLng(latitude: 39.90864, longitude: 116.39745),
    zoom: 10,
    bearing: 0,
    tilt: 0,
  );

  @override
  build(context) {
    final duration = animated ? const Duration(seconds: 2) : null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('地图视角移动'),
        actions: [
          Row(children: [
            const Text('动画'),
            Switch(
              value: animated,
              onChanged: (value) => setState(() => animated = value),
            ),
          ]),
        ],
      ),
      body: Stack(children: [
        TencentMap(onMapCreated: (c) => controller = c),
        Positioned(
          top: 20,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: const Text('Position 1'),
                onPressed: () => controller.moveCamera(position1, duration),
              ),
              ElevatedButton(
                child: const Text('Position 2'),
                onPressed: () => controller.moveCamera(position2, duration),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}