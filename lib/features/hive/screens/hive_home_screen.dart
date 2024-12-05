import 'package:bee_ai/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class HiveHomeScreen extends StatefulWidget {
  const HiveHomeScreen({super.key});

  @override
  State<HiveHomeScreen> createState() => _HiveHomeScreenState();
}

class _HiveHomeScreenState extends State<HiveHomeScreen> {
  final List<Map<String, dynamic>> hives = [
    {
      'name': 'Colmeia 1',
      'location': 'Local A',
      'status': 'Ativa',
      'temperature': '35°C',
      'humidity': '60%'
    },
    // Adicione mais colmeias conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.primaryColor,
      appBar: AppBar(
        title: const Text(
            'Colmeias',

        ),
        backgroundColor: CustomTheme.textColor,

      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: hives.length,
        itemBuilder: (context, index) {
          final hive = hives[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.orange[100],
            child: ListTile(
              leading: Icon(Icons.hive_outlined, color: Colors.orange[700]),
              title: Text(
                  hive['name'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomTheme.textColor
                  )
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Local: ${hive['location']}'),
                  Text('Status: ${hive['status']}'),
                  Text('Temperatura: ${hive['temperature']}'),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange[700]),
              onTap: () {
                // Ação ao clicar no card
              },
            ),
          );
        },
      ),
    );
  }
}
