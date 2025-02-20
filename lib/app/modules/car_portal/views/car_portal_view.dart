import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/car_portal_controller.dart';

class CarPortalView extends GetView<CarPortalController> {
  const CarPortalView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CarPortalView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CarPortalView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
