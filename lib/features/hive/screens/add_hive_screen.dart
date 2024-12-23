import 'dart:convert';
import 'package:bee_ai/helper/route_helper.dart';
import 'package:bee_ai/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddHiveScreen extends StatefulWidget {
  const AddHiveScreen({super.key});

  @override
  State<AddHiveScreen> createState() => _AddHiveScreenState();
}

class _AddHiveScreenState extends State<AddHiveScreen> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Future<List<Map<String, dynamic>>> hives;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
    hives = fetchHiveData();
  }

  Future<List<Map<String, dynamic>>> fetchHiveData() async {
    final url = Uri.parse('http://192.168.1.3/dados');
    final response = await http.get(url);

    if (response.statusCode == 200) {

      final List<dynamic> data = json.decode(response.body);

      return data.map((item) {

        return {
          'ip': item['ip'].toString(),
          'id': item['id'] ?? 'null',
        };
      }).toList();

    } else {
      throw Exception('Erro ao buscar dados das colmeias');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.primaryColor,
      appBar: AppBar(
        title: const Text('Adicionar Colmeia'),
        backgroundColor: CustomTheme.textColor,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: hives,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * 3.1416,
                    child: child,
                  );
                },
                child: const Icon(
                  Icons.search,
                  size: 100,
                  color: CustomTheme.textColor,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Ocorreu o seguinte erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma colmeia encontrada'));
          } else {
            final hiveData = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: hiveData.length,
              itemBuilder: (context, index) {
                final hive = hiveData[index];
                final hiveId = hive['id'];
                final ip = hive['ip'];

                if (hiveId == 'null') {
                  return const SizedBox();
                }

                return Card(
                  color: CustomTheme.textColor,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: const Text(
                      'Colmeia',
                      style: TextStyle(color: CustomTheme.primaryColor),
                    ),
                    subtitle: Text(hiveId, style: TextStyle(color: CustomTheme.backgroundColor),),
                    onTap: () {
                      // Ação para colmeia com ID
                      Get.toNamed(RouteHelper.getHiveDataScreen(hiveId, ip));
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
