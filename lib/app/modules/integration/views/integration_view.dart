import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/integration_controller.dart';

class IntegrationView extends GetView<IntegrationController> {
  const IntegrationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IntegrationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'IntegrationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
