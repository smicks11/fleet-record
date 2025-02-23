import 'package:fleet_app/app/shared/colors.dart';
import 'package:flutter/material.dart';

class Stat {
  final Color color;
  final String status;
  final String count;

  Stat({required this.color, required this.status, required this.count});
}

List<Stat> vehicleList = [
  Stat(color: Colors.green, status: 'Active', count: '6426'),
  Stat(color: AppColors.appRedColor, status: 'Inactive', count: '4409'),
  Stat(color: AppColors.appRedColor, status: 'Grounded', count: '500'),
  Stat(color: Colors.redAccent, status: 'Sedan', count: '12'),
  Stat(color: Colors.red, status: 'Bus', count: '90'),
  Stat(color: Colors.blue, status: 'Hilux', count: '20'),
  Stat(color: Colors.green, status: 'Hilux', count: '20'),
];
List<Stat> driverList = [
  Stat(color: Colors.green, status: 'Active', count: '6426'),
  Stat(color: AppColors.appRedColor, status: 'Inactive', count: '4409'),
  Stat(color: AppColors.appRedColor, status: 'Lagos', count: '170'),
  Stat(color: Colors.redAccent, status: 'South West', count: '240'),
  Stat(color: Colors.red, status: 'East', count: '320'),
  Stat(color: Colors.blue, status: 'North/Abuja', count: '198'),
  Stat(color: Colors.pink, status: 'North/Abuja', count: '198'),
];