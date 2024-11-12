import 'package:bee_ai/features/hive/controllers/hive_controller.dart';
import 'package:bee_ai/helper/route_helper.dart';
import 'package:bee_ai/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  final HiveController hiveController = HiveController();
  final TextEditingController _ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Configurações"),
          backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: CustomTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Endereço Atual: ${hiveController.hive?.ip ?? ''}\nConfigurar Endereço IP",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _ipController,
              decoration: InputDecoration(
                labelText: "Endereço IP",
                prefixIcon: Icon(Icons.wifi, color: CustomTheme.primaryColor),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _onConfigPressed,
              child: Text("Configurar"),
            ),
          ],
        ),
      ),
    );
  }

  void _onConfigPressed() {
    final ip = _ipController.text;

    hiveController.setHiveIp(ip);
  }
}
