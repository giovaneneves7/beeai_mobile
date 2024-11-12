import 'dart:async';
import 'dart:convert';
import 'package:bee_ai/common/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HiveDataScreen extends StatefulWidget {

  final String hiveId;
  final String ipLogin;

  HiveDataScreen({required this.ipLogin, required this.hiveId});

  @override
  _HiveDataScreenState createState() => _HiveDataScreenState();
}

class _HiveDataScreenState extends State<HiveDataScreen> {

  String weight = "Carregando...";
  String temperature = "Carregando...";
  String latitude = "Carregando...";
  String longitude = "Carregando...";

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Inicializando timer para buscar o peso a cada 2 segundos
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      fetchWeight();
    });
  }

  @override
  void dispose() {

    // Cancelando timer quando o widget é destruído

    _timer?.cancel();
    super.dispose();
  }


  Future<void> fetchWeight() async {
    try {
      print('http://${widget.ipLogin}/colmeias/${widget.hiveId}');

      // Fazendo requisição para o ESP8266
      final response = await http.get(Uri.parse('http://${widget.ipLogin}/colmeias/${widget.hiveId}'));
      if (response.statusCode == 200) {
        // Decodificando a resposta JSON
        Map<String, dynamic> data = jsonDecode(response.body);

        // Extraindo peso e temperatura do JSON
        setState(() {
          weight = "${data['peso']} kg";
          temperature = "${data['temperatura']} °C";
          latitude = "${data['latitude']}";
          longitude = "${data['longitude']}";

        });
      } else {
        setState(() {
          weight = "Erro!";
          temperature = "Erro!";
          latitude = "Erro!";
          longitude = "Erro!";
        });
      }
    } catch (e) {
      setState(() {
        weight = "Erro!";
        temperature = "Erro!"; // Atualizando também a temperatura
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hiveId),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.orange,
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.hive, size: 40, color: Colors.white),
                      SizedBox(height: 8),
                      Text(
                        '${widget.hiveId}\n(Ativa)',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Total de Abelhas:',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '156',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.location_on, size: 24, color: Colors.white),
                      SizedBox(height: 4),
                      Text(
                        'Localização:',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '${latitude}, ${longitude}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dados Da Colmeia',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Temperatura:'),
                          SizedBox(height: 4),
                          Text(
                            temperature,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Peso:'),
                          SizedBox(height: 4),
                          Text(
                            weight,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



