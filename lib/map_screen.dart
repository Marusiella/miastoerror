import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:miastoerror/provider.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapController controller;
  @override
  void initState() {
    controller = MapController();
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      Provider.of<MyProvider>(context, listen: false).posts.forEach((element) {
        controller.addMarker(
            GeoPoint(latitude: element.latitude, longitude: element.longitude));
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OSMFlutter(
        controller: controller,
        trackMyPosition: true,
        onGeoPointClicked: (GeoPoint point) {},
      ),
    );
  }
}
