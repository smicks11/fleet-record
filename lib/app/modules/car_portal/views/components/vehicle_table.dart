// ignore_for_file: library_private_types_in_public_api

import 'package:fleet_app/app/data/vehicle_payload.dart';
import 'package:fleet_app/app/modules/car_portal/controllers/car_portal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class VehicleTable extends StatefulWidget {
  const VehicleTable({super.key});

  @override
  _VehicleTableState createState() => _VehicleTableState();
}

class _VehicleTableState extends State<VehicleTable> {
  final carController = Get.find<CarPortalController>();
  final ScrollController _scrollController = ScrollController();

  int currentPage = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    carController.fetchVehicles(isRefresh: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        carController.fetchVehicles();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarPortalController>(
      init: CarPortalController(),
      initState: (state) {
        carController.initialize();
      },
      builder: (controller) {
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
                    tableHeaderCell('Vehicle Category', flex: 2),
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: Obx(() {
                  if (carController.vehicles.isEmpty &&
                      carController.isLoading.value) {
                    return _buildShimmerEffect();
                  } else {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: carController.vehicles.length +
                          (carController.hasMore.value &&
                                  carController.isLoading.value
                              ? 1
                              : 0),
                      itemBuilder: (context, index) {
                        if (index == carController.vehicles.length) {
                          return Container(
                            height: 30,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        }

                        return tableRow(carController.vehicles[index]);
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                _shimmerCell(flex: 1, width: 30, height: 20),
                const SizedBox(width: 10),
                _shimmerCell(flex: 2, width: 80, height: 20),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      _shimmerBox(width: 30, height: 30, isCircle: true),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _shimmerBox(width: double.infinity, height: 15),
                            const SizedBox(height: 5),
                            _shimmerBox(width: 80, height: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                _shimmerCell(flex: 3, width: 120, height: 20),
                const SizedBox(width: 10),
                _shimmerCell(flex: 2, width: 100, height: 20),
                const SizedBox(width: 10),
                _shimmerCell(flex: 1, width: 30, height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _shimmerCell({required int flex, double? width, double? height}) {
    return Expanded(
      flex: flex,
      child: Align(
        alignment: Alignment.centerLeft,
        child: _shimmerBox(width: width, height: height),
      ),
    );
  }

  Widget _shimmerBox({double? width, double? height, bool isCircle = false}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isCircle ? null : BorderRadius.circular(5),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
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

  Widget tableRow(Vehicle vehicle) {
    return InkWell(
      onTap: () {
        Get.toNamed('/car_portal/car_detail', id: 1);
        carController.currentVehicleId.value = vehicle.id ?? "";
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
              tableCell(
                  '${vehicle.brand?.name ?? ""} (${vehicle.vehicleModel})'
                          .capitalizeFirst ??
                      "--",
                  isLeading: true,
                  flex: 2),
              tableCell(
                  vehicle.available == true ? 'Available' : 'Not Available'),
              tableCell(vehicle.vehicleType?.capitalizeFirst ?? '--'),
              tableCell(vehicle.fuelType?.capitalizeFirst ?? '--'),
              tableCell(vehicle.vehicleCategory?.capitalizeFirst ?? "",
                  flex: 2),
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
