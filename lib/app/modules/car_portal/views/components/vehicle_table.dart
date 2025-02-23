import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleTable extends StatelessWidget {
  final List<Map<String, String>> vehicleData = List.generate(30, (index) {
    return {
      'modelYear': 'Toyota Corolla (${2020 + (index % 3)})',
      'availability': index % 2 == 0 ? 'Available' : 'Unavailable',
      'vehicleType': 'Sedan',
      'fuelType': 'Gasoline',
      'mileage': '${(40000 + (index * 1000))} km driven',
    };
  });

  VehicleTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                tableHeaderCell('Model & Year', flex: 2),
                tableHeaderCell('Availability'),
                tableHeaderCell('Vehicle Type'),
                tableHeaderCell('Fuel Type'),
                tableHeaderCell('Mileage', flex: 2),
              ],
            ),
          ),
          // Table Rows
          Column(
            children: vehicleData.map((vehicle) => tableRow(vehicle)).toList(),
          ),
        ],
      ),
    );
  }

  Widget tableHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xff5B636A),
          ),
        ),
      ),
    );
  }

  Widget tableRow(Map<String, String> vehicle) {
    return InkWell(
      onTap: (){
        Get.toNamed('/car_portal/car_detail', id: 1);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          decoration: BoxDecoration(
            color: Color(0xffFAFAFA),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              tableCell(vehicle['modelYear']!, isLeading: true, flex: 2),
              tableCell(vehicle['availability']!),
              tableCell(vehicle['vehicleType']!),
              tableCell(vehicle['fuelType']!),
              tableCell(vehicle['mileage']!, flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget tableCell(String text, {bool isLeading = false, int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (isLeading)
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 0.2, color: Colors.black54),
              ),
              child: Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          if (isLeading) SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xff5B636A),
            ),
          ),
        ],
      ),
    );
  }
}
