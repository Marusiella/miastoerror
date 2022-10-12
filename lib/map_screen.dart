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
    controller = MapController(
      initPosition: GeoPoint(
        latitude: 52.13290489856395,
        longitude: 19.15959937693299,
      ),
    );
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Provider.of<MyProvider>(context, listen: false).posts.forEach((element) {
        controller.addMarker(
            GeoPoint(latitude: element.latitude, longitude: element.longitude));
      });
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final args = ModalRoute.of(context)!.settings.arguments as List<double>;
        // zoom to point
        controller
            .changeLocation(GeoPoint(latitude: args[0], longitude: args[1]));
        controller.setZoom(zoomLevel: 15);
      }
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
        initZoom: 12,
        stepZoom: 1.0,
        controller: controller,
        trackMyPosition: true,
        onGeoPointClicked: (GeoPoint point) {
          Provider.of<MyProvider>(context, listen: false)
              .posts
              .forEach((element) {
            if (element.latitude == point.latitude &&
                element.longitude == point.longitude) {
              Navigator.pushNamed(context, '/info', arguments: element);
            }
          });
        },
      ),
    );
  }
}
