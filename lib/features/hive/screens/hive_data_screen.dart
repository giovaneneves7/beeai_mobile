import 'dart:async';
import 'dart:convert';
import 'package:bee_ai/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class HiveDataScreen extends StatefulWidget {
  final String hiveId;
  final String ipLogin;

  HiveDataScreen({required this.ipLogin, required this.hiveId});

  @override
  _HiveDataScreenState createState() => _HiveDataScreenState();
}

class _HiveDataScreenState extends State<HiveDataScreen> {
  String weight = "...";
  String temperature = "Carregando...";
  String latitude = "Carregando...";
  String longitude = "Carregando...";
  String humidity = "Carregando...";

  double? lat;
  double? lng;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      fetchData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://${widget.ipLogin}/colmeias/${widget.hiveId}'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          weight = "${data['peso']} kg";
          temperature = "${data['temperatura']} °C";
          latitude = "${data['latitude']}";
          longitude = "${data['longitude']}";
          humidity = "${data['umidade']}%";
          lat = double.tryParse(latitude);
          lng = double.tryParse(longitude);
        });
      } else {
        setState(() {
          weight = "Erro!";
          temperature = "Erro!";
          latitude = "Erro!";
          longitude = "Erro!";
          humidity = "Error!";
        });
      }
    } catch (e) {
      setState(() {
        weight = "Erro!";
        temperature = "Erro!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.primaryColor,
      appBar: AppBar(
        backgroundColor: CustomTheme.textColor,
        title: Text(widget.hiveId),

      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'Peso:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [CustomTheme.textColor, Colors.orangeAccent],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      weight,
                      style: TextStyle(
                        fontSize: 28,
                        color: CustomTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                child: Card(
                  color: CustomTheme.textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: Text('Temperatura'),
                    subtitle: Text(
                      temperature,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 150,
                child: Card(
                  color: CustomTheme.textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: Text('Umidade'),
                    subtitle: Text(
                      humidity,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Minimapa
          Container(
            height: 200,
            margin: EdgeInsets.only(top: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: (lat != null && lng != null) ? LatLng(lat!, lng!) : LatLng(-11.327027, -41.864856),
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
                        'accessToken': 'sk.eyJ1IjoicHV0aWZlcm8iLCJhIjoiY20zZzZmZXdsMDE4MjJpb2diZWVvY3F5YSJ9.TBGisV6dvu7uPxP2g9aF7w',
                      },
                    ),
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
