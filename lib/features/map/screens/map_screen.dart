import 'package:bee_ai/util/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se o serviço de localização está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Serviço de localização não está habilitado
      return;
    }

    // Solicita permissão para localização
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissão negada pelo usuário
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissão negada para sempre
      return;
    }

    // Obtém a posição atual do dispositivo
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: _currentPosition ?? LatLng(-11.327027, -41.864856),
        initialZoom: 17,
        cameraConstraint: CameraConstraint.contain(
          bounds: LatLngBounds(
            const LatLng(-90, -180),
            const LatLng(90, 180),
          ),
        ),
      ),
      children: [
        TileLayer(
          urlTemplate:
          "https://api.mapbox.com/styles/v1/mapbox/satellite-v9/tiles/256/{z}/{x}/{y}@2x?access_token=sk.eyJ1IjoicHV0aWZlcm8iLCJhIjoiY20zZzZmZXdsMDE4MjJpb2diZWVvY3F5YSJ9.TBGisV6dvu7uPxP2g9aF7w",
          additionalOptions: {
            'accessToken':
            'sk.eyJ1IjoicHV0aWZlcm8iLCJhIjoiY20zZzZmZXdsMDE4MjJpb2diZWVvY3F5YSJ9.TBGisV6dvu7uPxP2g9aF7w',
          },
        ),
        if (_currentPosition != null)
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: _currentPosition!,
                child: Image.asset(
                  Images.marker,
                  width: 20.0,
                  height: 20.0,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
