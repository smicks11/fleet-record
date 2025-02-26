import 'package:fleet_app/app/data/data.dart';
import 'package:fleet_app/app/shared/assets.dart';
import 'package:fleet_app/app/shared/colors.dart';
import 'package:fleet_app/app/shared/size.dart';
import 'package:fleet_app/app/shared/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return GetBuilder<HomeController>(
        init: HomeController(),
        initState: (state) {
          controller.initialize();
        },
        builder: (controller) {
          return Scaffold(
              backgroundColor: AppColors.scafoldColor,
              body: ListView(
                children: [
                  S.h(20.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: 'Admin Data',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            // S.h(4),
                            Text(
                              'Overview',
                              style: GoogleFonts.montserrat(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            S.h(4),
                            TextView(
                              text:
                                  'Easily browse, manage, and access fleet vehicles ',
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff6E7C87),
                            ),
                          ],
                        ),
                        S.w(100.w),
                        SizedBox(
                          height: 40,
                          width: 520,
                          child: TextField(
                            controller: searchController,
                            style: GoogleFonts.poppins(
                                color: const Color(0xff5B636A),
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(
                                    SvgAssets.search,
                                    height: 15,
                                    width: 15,
                                  ),
                                ),
                                hintText:
                                    "Search by Vehicle Number, Team or Driver",
                                hintStyle: GoogleFonts.poppins(
                                    color: const Color(0xff9AA6AC),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffDDE2E4), width: 0.8),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffDDE2E4), width: 0.8),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffDDE2E4), width: 0.8),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffDDE2E4), width: 0.8),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffDDE2E4), width: 0.8),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.07)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  S.h(40.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextView(
                          text: 'Vehicles',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff5B636A),
                        ),
                      ),
                      S.h(12.h),
                      (controller.isBusy.value &&
                              controller.vehicleInfographic.value == null)
                          ? SizedBox(
                              height: 150,
                              child: ListView.builder(
                                itemCount: 10,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return shimmerBlock();
                                },
                              ),
                            )
                          : _buildVehicleInfographic(controller),
                      S.h(30.h),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextView(
                          text: 'Drivers',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff5B636A),
                        ),
                      ),
                      S.h(12.h),
                      (controller.isBusy.value &&
                              controller.vehicleInfographic.value == null)
                          ? SizedBox(
                              height: 150,
                              child: ListView.builder(
                                itemCount: 10,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return shimmerBlock();
                                },
                              ),
                            )
                          : _buildVehicleInfographic(controller),
                      S.h(50.h),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 30),
                      //   child: TextView(
                      //     text: 'Recent records',

                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //     color: Color(0xff5B636A),

                      //     // fontSize: 16,
                      //     // color: Color(0xff252C32),
                      //     // fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      // S.h(15.h),
                      // ListView.builder(
                      //     itemCount: 8,
                      //     shrinkWrap: true,
                      //     itemBuilder: (context, index) {
                      //       return recentRecordWidget();
                      //     }),
                    ],
                  )

                  // RecentRecord()
                ],
              ));
        });
  }

  Widget _buildVehicleInfographic(HomeController controller) {
    final data = controller.vehicleInfographic.value?.data;
    if (data == null) return SizedBox();

    final vehicleList = [
      {"status": "Total Vehicles", "count": data.totalVehicles.toString()},
      {
        "status": "Available Vehicles",
        "count": data.availableVehicles.toString()
      },
      {
        "status": "Unavailable Vehicles",
        "count": data.unavailableVehicles.toString()
      },
    ];

    vehicleList.addAll(data.vehiclesByBrand!
        .map((brand) => {
              "status": brand.brand ?? "Unknown",
              "count": (brand.totalVehicles ?? 0).toString(),
            })
        .toList());

    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      AppColors.appRedColor,
      Colors.orange,
      Colors.redAccent,
      Colors.teal,
    ];

    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: vehicleList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return dataBlock(
            status: vehicleList[index]["status"]!,
            color: colors[index % colors.length],
            count: vehicleList[index]["count"]!,
          );
        },
      ),
    );
  }

  Container recentRecordWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 14),
      margin: EdgeInsets.only(left: 30, right: 30, bottom: 12),
      decoration: BoxDecoration(
          color: Color(0xffFAFAFA), borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Flexible(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 0.2, color: Colors.black54),
                      color: Colors.transparent),
                  child: Container(
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor, shape: BoxShape.circle),
                  ),
                ),
                S.w(6),
                TextView(
                  text: 'Toyota Corolla (2020)',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff5B636A),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                SizedBox(
                  height: 15,
                  child: VerticalDivider(
                    width: 2.0,
                    color: Colors.grey,
                  ),
                ),
                S.w(10),
                TextView(
                  text: 'Available',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff5B636A),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                SizedBox(
                  height: 15,
                  child: VerticalDivider(
                    width: 2.0,
                    color: Colors.grey,
                  ),
                ),
                S.w(10),
                TextView(
                  text: 'Sedan',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff5B636A),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                SizedBox(
                  height: 15,
                  child: VerticalDivider(
                    width: 2.0,
                    color: Colors.grey,
                  ),
                ),
                S.w(10),
                TextView(
                  text: 'Gasoline',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff5B636A),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                SizedBox(
                  height: 15,
                  child: VerticalDivider(
                    width: 2.0,
                    color: Colors.grey,
                  ),
                ),
                S.w(10),
                TextView(
                  text: '45,000 km driven',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff5B636A),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container dataBlock(
      {required String status, required Color color, required String count}) {
    return Container(
      height: 150,
      width: 150,
      padding: EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          color: Color(0xffF6F8F9), borderRadius: BorderRadius.circular(22)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 0.2, color: Colors.black54),
                color: Colors.transparent),
            child: Container(
              height: 7,
              width: 7,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
          S.h(12.h),
          TextView(
            text: status,
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          S.h(12.h),
          TextView(
            text: count,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }

  Widget shimmerBlock() {
    return Container(
      height: 150,
      width: 150,
      padding: EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 10,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 18,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
