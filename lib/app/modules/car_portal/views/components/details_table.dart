import 'package:fleet_app/app/data/vehicle_payload.dart';
import 'package:fleet_app/app/modules/car_portal/controllers/car_portal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleDetailsTable extends StatelessWidget {
  

  VehicleDetailsTable({super.key, });
  final carController = Get.find<CarPortalController>();

  List<Map<String, String>> get vehicleDetails {
    return [
      {"Feature": "Asset Code", "Detail": carController.vehicleDetail.value?.assetCode ?? "--"},
      {"Feature": "Reg Number", "Detail": carController.vehicleDetail.value?.regNumber ?? "--"},
      {
        "Feature": "Vehicle Category",
        "Detail": carController.vehicleDetail.value?.vehicleCategory ?? "--"
      },
      {
        "Feature": "Date of Purchase",
        "Detail": carController.formatDate(carController.vehicleDetail.value?.dateOfPurchase.toString())
      },
      {
        "Feature": "Cost of Purchase",
        "Detail": carController.vehicleDetail.value?.costOfPurchase.toString() ?? "--"
      },
      {"Feature": "Net Book Value", "Detail": carController.vehicleDetail.value?.netBookValue.toString() ?? "--"},
      {"Feature": "Parking Branch", "Detail": carController.vehicleDetail.value?.parkingBranch ?? ""},
      {"Feature": "Vehicle Brand", "Detail": carController.vehicleDetail.value?.brand?.name ?? ""},
      {"Feature": "Vehicle Model", "Detail": carController.vehicleDetail.value?.vehicleModel ?? ""},
      {"Feature": "Vehicle Type", "Detail": carController.vehicleDetail.value?.vehicleType ?? ""},
      {"Feature": "Tyre Type", "Detail": carController.vehicleDetail.value?.tyreType ?? ""},
      {"Feature": "Battery Type", "Detail": carController.vehicleDetail.value?.batteryType ?? ""},
      {
        "Feature": "Tank Capacity",
        "Detail": carController.vehicleDetail.value?.tankCapacity.toString() ?? "--"
      },
      {"Feature": "Vehicle Status", "Detail": carController.vehicleDetail.value?.vehicleStatus ?? ""},
      {
        "Feature": "Maintenance Garage",
        "Detail": carController.vehicleDetail.value?.maintenanceGarage ?? ""
      },
    ];
  }

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
                      child: Text(item["Detail"]!.capitalizeFirst ?? "",
                          style: _rowStyle())),
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
