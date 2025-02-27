import 'package:fleet_app/app/modules/car_portal/controllers/car_portal_controller.dart';
import 'package:fleet_app/app/modules/car_portal/views/components/vehicle_table.dart';
import 'package:fleet_app/app/shared/assets.dart';
import 'package:fleet_app/app/shared/colors.dart';
import 'package:fleet_app/app/shared/size.dart';
import 'package:fleet_app/app/shared/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/add_car.dart';

class CarPortalView extends GetView<CarPortalController> {
  const CarPortalView({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
        backgroundColor: AppColors.scafoldColor,
        body: ListView(
          children: [
            S.h(20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        'Car Portal',
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
                  Row(
                    children: [
                      SizedBox(
                        height: 31,
                        width: 520,
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              controller.fetchVehicles(isRefresh: true);
                            } else {
                              controller.fetchVehicles(
                                  isRefresh: true, searchQuery: value);
                            }
                          },
                          style: GoogleFonts.poppins(
                              color: const Color(0xff5B636A),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 8),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                  fontSize: 12),
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
                              fillColor: Colors.grey.withOpacity(0.02)),
                        ),
                      ),
                      S.w(8),
                      // InkResponse(
                      //   child: Container(
                      //     padding:
                      //         EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      //     decoration: BoxDecoration(
                      //         color: Colors.grey.withOpacity(0.02),
                      //         borderRadius: BorderRadius.circular(30),
                      //         border: Border.all(
                      //             color: Color(0xffDDE2E4), width: 0.8)),
                      //     child: Row(
                      //       children: [
                      //         SvgPicture.asset(SvgAssets.filter, height: 10),
                      //         S.w(4.w),
                      //         TextView(
                      //           text: 'Filter',
                      //           color: Color(0xff9AA6AC),
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      // InkResponse(
                      //   child: Container(
                      //     padding:
                      //         EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      //     decoration: BoxDecoration(
                      //         color: Colors.grey.withOpacity(0.02),
                      //         borderRadius: BorderRadius.circular(30),
                      //         border: Border.all(
                      //             color: Color(0xffDDE2E4), width: 0.8)),
                      //     child: Row(
                      //       children: [
                      //         TextView(
                      //           text: 'Edit',
                      //           color: Color(0xff9AA6AC),
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //         S.w(4.w),
                      //         SvgPicture.asset(SvgAssets.edit, height: 14),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // S.w(5.w),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                              color: Color(0xFFFFA726),
                              width: 1.5,
                            ),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AddCarDialog(),
                          );
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          "Add Record",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            S.h(40.h),
            VehicleTable()
          ],
        ));
  }
}
