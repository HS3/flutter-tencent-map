import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';

import '../utils.dart';

class AddRemoveMarkerPage extends StatefulWidget {
  const AddRemoveMarkerPage({Key? key}) : super(key: key);

  @override
  State<AddRemoveMarkerPage> createState() => _AddRemoveMarkerPageState();
}

class _AddRemoveMarkerPageState extends State<AddRemoveMarkerPage> {
  late TencentMapController controller;
  final markers = <String, Marker>{};

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('动态添加、移除标记')),
      body: TencentMap(
        onTap: (position) => onTap(position),
        onMapCreated: (controller) => this.controller = controller,
        onTapMarker: (markerId) => onTapMarker(markerId),
        onMarkerDragEnd: (markerId, position) =>
            context.alert('${position.latitude}, ${position.longitude}'),
      ),
    );
  }

  void onTap(LatLng position) async {
    final marker = await controller.addMarket(
      MarkerOptions(
        position: position,
        icon: Bitmap(asset: 'images/marker.png'),
        anchor: [0.5, 1],
        draggable: true,
      ),
    );
    markers[marker.id] = marker;
  }

  void onTapMarker(String markerId) {
    markers[markerId]?.remove();
    markers.remove(markerId);
  }
}
