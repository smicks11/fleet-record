import 'package:flutter/material.dart';

class RecentRecord extends StatefulWidget {
  @override
  _RecentRecordState createState() => _RecentRecordState();
}

class _RecentRecordState extends State<RecentRecord> {
  List<Map<String, dynamic>> carList = [
    {
      "name": "Toyota Camry",
      "image": "https://www.toyota.com/imgix/responsive/images/mlp/colorizer/2023/camry/1J6/1.png",
      "availability": "Available",
      "type": "Sedan",
      "fuelType": "Gasoline",
      "mileage": "28 MPG"
    },
    {
      "name": "Tesla Model 3",
      "image": "https://www.tesla.com/sites/default/files/modelsx-new/social/model-3-hero-social.jpg",
      "availability": "Unavailable",
      "type": "Electric",
      "fuelType": "Electric",
      "mileage": "272 miles per charge"
    },
    {
      "name": "Ford F-150",
      "image": "https://www.ford.com/cmslibs/content/dam/brand_ford/en_us/brand/resources/general/f-150-hero.jpg",
      "availability": "Available",
      "type": "Truck",
      "fuelType": "Gasoline",
      "mileage": "22 MPG"
    },
    {
      "name": "Honda CR-V",
      "image": "https://automobiles.honda.com/-/media/Honda-Automobiles/Vehicles/2023/CR-V/Global-Elements/MY23-CR-V-Trims-Page/CR-V-Trims-Sport-Hybrid-Desktop-600x400.png",
      "availability": "Available",
      "type": "SUV",
      "fuelType": "Hybrid",
      "mileage": "40 MPG"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Car List')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 16,
          columns: [
            DataColumn(label: Text('Image')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Availability')),
            DataColumn(label: Text('Type')),
            DataColumn(label: Text('Fuel Type')),
            DataColumn(label: Text('Mileage')),
          ],
          rows: carList.map((car) {
            return DataRow(cells: [
              DataCell(
                Image.network(car['image'], width: 50, height: 50, fit: BoxFit.cover),
              ),
              DataCell(Text(car['name'])),
              DataCell(Text(car['availability'])),
              DataCell(Text(car['type'])),
              DataCell(Text(car['fuelType'])),
              DataCell(Text(car['mileage'])),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
