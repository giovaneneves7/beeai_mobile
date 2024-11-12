import 'package:bee_ai/helper/route_helper.dart';
import 'package:bee_ai/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IpLoginScreen extends StatefulWidget {
  @override
  _IpLoginScreenState createState() => _IpLoginScreenState();
}

class _IpLoginScreenState extends State<IpLoginScreen> {
  final TextEditingController _ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login de Rede", style: TextStyle(color: CustomTheme.textColor)),
        backgroundColor: CustomTheme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Digite o Endereço IP",
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
              onPressed: _onLoginPressed,
              child: Text("Entrar"),
            ),
          ],
        ),
      ),
    );
  }

  void _onLoginPressed() {
    final ip = _ipController.text;

    Get.toNamed(RouteHelper.getHomeScreen(ip));
  }
}
