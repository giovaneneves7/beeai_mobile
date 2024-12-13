import 'dart:convert';
import 'package:bee_ai/util/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> _markers = [];
  final PopupController _popupController = PopupController();
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _initializeMarkers();
  }

  void _initializeMarkers() {
    // Adiciona os marcadores com dados fictícios de umidade e temperatura
    _markers = [
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(-11.326527, -41.864056),
        child: Image.asset(
          Images.marker,
          width: 20.0,
          height: 20.0,
        ),
        key: const ValueKey('marker1'), // Chave única para o popup
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(-11.327527, -41.865056),
        child: Image.asset(
          Images.marker,
          width: 20.0,
          height: 20.0,
        ),
        key: const ValueKey('marker2'),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(-11.328027, -41.864556),
        child: Image.asset(
          Images.marker,
          width: 20.0,
          height: 20.0,
        ),
        key: const ValueKey('marker3'),
      ),
    ];
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

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
        onTap: (_, __) => _popupController.hideAllPopups(),
      ),
      children: [
        TileLayer(
          urlTemplate:
          "https://api.mapbox.com/styles/v1/mapbox/satellite-v9/tiles/256/{z}/{x}/{y}@2x?access_token=sk.eyJ1IjoicHV0aWZlcm8iLCJhIjoiY20zZzZmZXdsMDE4MjJpb2diZWVvY3F5YSJ9.TBGisV6dvu7uPxP2g9aF7w",
        ),
        PopupMarkerLayer(
          options: PopupMarkerLayerOptions(
            markers: _markers,
            popupController: _popupController,
            popupDisplayOptions: PopupDisplayOptions(
              builder: (BuildContext context, Marker marker) {
                // Dados fictícios para cada marcador
                final Map<String, dynamic> fakeData = {
                  'marker1': {'umidade': 75, 'temperatura': 30},
                  'marker2': {'umidade': 60, 'temperatura': 28},
                  'marker3': {'umidade': 80, 'temperatura': 29},
                };

                // Determina os dados do marcador atual
                final data = fakeData[marker.key.toString()] ??
                    {'umidade': '39', 'temperatura': '24', 'peso' : '65kg'};

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Umidade: ${data['umidade']}%",
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Temperatura: ${data['temperatura']}°C",
                          textAlign: TextAlign.center,
                        ),
                        Text("Peso: ${data['peso']}"),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}