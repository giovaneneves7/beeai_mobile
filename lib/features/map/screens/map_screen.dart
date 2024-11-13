import 'dart:convert';
import 'package:bee_ai/util/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  List<LatLng> _hiveLocations = [];
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _fetchHiveData();
  }

  Future<void> _fetchHiveData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.3/dados'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _hiveLocations = data
              .where((hive) => hive['latitude'] != 'null' && hive['longitude'] != 'null')
              .map((hive) => LatLng(
            double.parse(hive['latitude']),
            double.parse(hive['longitude']),
          ))
              .toList();
        });
      } else {
        print("Erro: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao buscar dados das colmeias: $e");
    }
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
        MarkerLayer(
          markers: [
            // Marker para a posição atual
            if (_currentPosition != null)
              Marker(
                width: 80.0,
                height: 80.0,
                point: _currentPosition!,
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 30.0,
                ),
              ),
            // Markers para cada colmeia na lista _hiveLocations
            ..._hiveLocations.map(
                  (location) => Marker(
                width: 80.0,
                height: 80.0,
                point: location,
                child: Image.asset(
                  Images.marker,
                  width: 20.0,
                  height: 20.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

}
