import 'package:fleet_app/app/modules/car_portal/controllers/car_portal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamDetailsTable extends StatelessWidget {
  final carController = Get.find<CarPortalController>();

  TeamDetailsTable({super.key});
  List<Map<String, String>> get teamDetails {
    return [
      {
        "Feature": "Class",
        "Detail": carController.vehicleDetail.value?.team?.className ?? ""
      },
      {
        "Feature": "Division",
        "Detail": carController.vehicleDetail.value?.team?.division ?? ""
      },
      {
        "Feature": "Group",
        "Detail": carController.vehicleDetail.value?.team?.group ?? ""
      },
      {
        "Feature": "Unit",
        "Detail": carController.vehicleDetail.value?.team?.unit ?? ""
      },
      {
        "Feature": "Team Branch",
        "Detail": carController.vehicleDetail.value?.team?.teamBranch ?? ""
      },
      {
        "Feature": "PC Code",
        "Detail": carController.vehicleDetail.value?.team?.pcCode ?? ""
      },
      {
        "Feature": "Region",
        "Detail": carController.vehicleDetail.value?.team?.region ?? ""
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xffF6F8F9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Team Details",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xff5B636A),
            ),
          ),
        ),
        SizedBox(height: 4),
        // SizedBox(height: 8),
        Column(
          children: List.generate(teamDetails.length, (index) {
            final item = teamDetails[index];
            return Container(
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
                      child: Text(item["Detail"]!.capitalizeFirst ?? "", style: _rowStyle())),
                ],
              ),
            );
          }),
        ),
      ],
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
