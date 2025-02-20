import 'package:fleet_app/app/modules/home/views/home_stats.dart';
import 'package:fleet_app/app/modules/home/views/recent_record.dart';
import 'package:fleet_app/app/shared/assets.dart';
import 'package:fleet_app/app/shared/colors.dart';
import 'package:fleet_app/app/shared/size.dart';
import 'package:fleet_app/app/shared/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
        backgroundColor: Color(0xffF6F8F9),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          SvgAssets.menu,
                          height: 20,
                          width: 20,
                        ),
                        S.w(10.w),
                        TextView(
                          text: 'GTWorld Bank',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    SvgAssets.notif,
                    height: 20,
                    width: 20,
                  ),
                  S.w(10.w),
                  SvgPicture.asset(
                    SvgAssets.user,
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
            ),
            S.h(20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
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
                          style: GoogleFonts.roboto(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        S.h(4),
                        TextView(
                          text: 'Updated 30 mins ago',
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff6E7C87),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 520,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            SvgAssets.search,
                            height: 15,
                            width: 15,
                          ),
                        ),
                        hintText: "Search by Vehicle Number, Team or Driver",
                        hintStyle: GoogleFonts.inter(
                          color: const Color(0xff9AA6AC),
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.disabledTextColor),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.disabledTextColor),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.disabledTextColor),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.disabledTextColor),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.disabledTextColor),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.1),
                                width: 0.7)),
                        child: Row(
                          children: [
                            TextView(
                              text: 'Edit',
                              fontSize: 12,
                            ),
                            SvgPicture.asset(SvgAssets.reload)
                          ],
                        ),
                      ),
                      S.w(20.w),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.1),
                                width: 0.7)),
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            TextView(
                              text: 'Add new car',
                              fontSize: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            S.h(20.h),
            Divider(
              color: Colors.grey.withOpacity(0.15),
            ),
            HomeStats(),
            S.h(30.h),
            RecentRecord()
            
          ],
        ));
  }
}
