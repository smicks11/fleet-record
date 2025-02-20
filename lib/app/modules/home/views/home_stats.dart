import 'package:fleet_app/app/shared/responsive_buidler.dart';
import 'package:flutter/material.dart';

class HomeStats extends StatelessWidget {
  const HomeStats({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobileBuilder: (context, constraints) => buildTable(200, 120),
      tabletBuilder: (context, constraints) => buildTable(250, 140),
      desktopBuilder: (context, constraints) => buildTable(300, 160),
    );
  }

  Widget buildTable(double cellHeight, double cellWidth) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        border: TableBorder.all(
          color: Colors.grey,
          width: 2,
        ),
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
        },
        children: [
          buildRow("Vehicles", 1200, cellHeight, cellWidth),
          buildRow("Drivers", 800, cellHeight, cellWidth),
        ],
      ),
    );
  }

  TableRow buildRow(String label, int count, double height, double width) {
    return TableRow(
      children: [
        buildCell(label, count, height, width),
        buildCell(label, count, height, width),
      ],
    );
  }

  Widget buildCell(String label, int count, double height, double width) {
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          StatColumn(count: count),
        ],
      ),
    );
  }
}

class StatColumn extends StatelessWidget {
  final int count;
  const StatColumn({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Active",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Text(
          "$count",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
