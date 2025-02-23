import 'package:flutter/material.dart';

class VehicleDetailsTable extends StatelessWidget {
  final List<Map<String, String>> vehicleDetails = [
    {"Feature": "Asset Code", "Detail": "AC-12345"},
    {"Feature": "Reg Number", "Detail": "EPE 745 DL"},
    {"Feature": "Category", "Detail": "Sedan"},
    {"Feature": "Model", "Detail": "Toyota Corolla"},
    {"Feature": "Year", "Detail": "2020"},
    {"Feature": "Fuel Type", "Detail": "Gasoline"},
    {"Feature": "Mileage", "Detail": "45,000 km"},
    {"Feature": "Transmission", "Detail": "Automatic"},
    {"Feature": "Engine Capacity", "Detail": "1.8L"},
    {"Feature": "Color", "Detail": "Silver"},
    {"Feature": "Chassis Number", "Detail": "XYZ123456789"},
    {"Feature": "Owner", "Detail": "FleetCorp Ltd."},
    {"Feature": "Last Service Date", "Detail": "10th July 2024"},
    {"Feature": "Next Service Due", "Detail": "10th Jan 2025"},
    {"Feature": "Insurance Expiry", "Detail": "15th Dec 2024"},
    {"Feature": "Tire Condition", "Detail": "Good"},
    {"Feature": "Battery Health", "Detail": "Optimal"},
    {"Feature": "GPS Installed", "Detail": "Yes"},
    {"Feature": "Fuel Consumption", "Detail": "6.5L/100km"},
    {"Feature": "Seats", "Detail": "5"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xffF6F8F9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(flex: 2, child: Text("Feature", style: _headerStyle())),
              Expanded(flex: 3, child: Text("Detail", style: _headerStyle())),
            ],
          ),
        ),
        SizedBox(height: 4),
        Column(
          children: List.generate(vehicleDetails.length, (index) {
            final item = vehicleDetails[index];
            return Container(
              // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              width: double.infinity,
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                  width: 0.5,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(item["Feature"]!, style: _rowStyle())),
                  Expanded(
                      flex: 3,
                      child: Text(item["Detail"]!, style: _rowStyle())),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  TextStyle _headerStyle() {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Color(0xff5B636A),
    );
  }

  TextStyle _rowStyle() {
    return TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: Color(0xff5B636A),
    );
  }
}
