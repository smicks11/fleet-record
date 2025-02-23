import 'package:flutter/material.dart';

class TeamDetailsTable extends StatelessWidget {
  final List<Map<String, String>> teamDetails = [
    {"Feature": "Class", "Detail": "090"},
    {"Feature": "Division", "Detail": "First"},
    {"Feature": "Group", "Detail": "06"},
    {"Feature": "Unit", "Detail": "2-30"},
    {"Feature": "Team Branch", "Detail": "North West"},
    {"Feature": "PC Code", "Detail": "3Q79580-4"},
    {"Feature": "Region", "Detail": "Lagos"},
  ];

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
                      child: Text(item["Detail"]!, style: _rowStyle())),
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
