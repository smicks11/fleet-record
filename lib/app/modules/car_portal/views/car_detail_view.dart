import 'package:fleet_app/app/modules/car_portal/views/components/details_table.dart';
import 'package:fleet_app/app/modules/car_portal/views/components/team_details_tabel.dart';
import 'package:fleet_app/app/shared/assets.dart';
import 'package:fleet_app/app/shared/colors.dart';
import 'package:fleet_app/app/shared/size.dart';
import 'package:fleet_app/app/shared/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CarDetailView extends GetView {
  const CarDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final vehicleName = 'T, Corolla';
    final plateNumber = 'EPE745DL';
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
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'All Vehicles > ',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff6E7C87),
                              ),
                            ),
                            TextSpan(
                              text: '$vehicleName/$plateNumber',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700, // Bold
                                color: Color(0xff6E7C87),
                              ),
                            ),
                          ],
                        ),
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
                      InkResponse(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.02),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color(0xffDDE2E4), width: 0.8)),
                          child: Row(
                            children: [
                              SvgPicture.asset(SvgAssets.filter, height: 10),
                              S.w(4.w),
                              TextView(
                                text: 'Filter',
                                color: Color(0xff9AA6AC),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
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
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          SvgAssets.edit,
                          height: 14,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Edit Record",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            S.h(40.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: 'Driver Profile',
                    fontSize: 14,
                    color: Color(0xff5B636A),
                    fontWeight: FontWeight.w600,
                  ),
                  TextView(
                    text: 'Last updated 30 days ago',
                    fontSize: 12,
                    color: Color(0xff5B636A),
                  )
                ],
              ),
            ),
            S.h(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2)
                      ),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Image.asset(
                      ImageAssets.user,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                  S.w(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profileData(
                        title: 'Name',
                        value: 'BRAIN JAMES',
                        context: context
                      ),
                      S.h(12),
                      profileData(
                        title: 'ID',
                        value: 'TB/PILOT/P/102',
                        context: context
                      ),
                      S.h(12),
                      profileData(
                        title: 'Phone Number',
                        value: '09179873535',
                        context: context
                      ),
                      S.h(12),
                      profileData(
                        title: 'Date Employed',
                        value: '2ND FEB 2024',
                        context: context
                      ),
                      S.h(12),
                      profileData(
                        title: 'Level',
                        value: '03',
                        context: context
                      ),
                      S.h(12),
                      profileData(
                        title: 'Service Provider',
                        value: 'Taxi',
                        context: context
                      ),
                      S.h(12),
                    ],
                  )
                ],
              ),
            ),
            S.h(40.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextView(
                text: 'Toyota Corolla 2020',
                color: Color(0xff5B636A),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            S.h(12.h),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 8,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    width: 200,
                    margin:
                        EdgeInsets.only(left: index == 0 ? 0 : 25, right: 25),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xffF6F8F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(ImageAssets.car),
                  );
                },
              ),
            ),

            S.h(40.h),
            VehicleDetailsTable(),
            S.h(40.h),
            TeamDetailsTable()
          ],
        ));
  }

  SizedBox profileData({required String title, required String value, required BuildContext context}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextView(
            text: title,
            color: Color(0xff252C32),
            fontSize: 12,
          ),
          TextView(
            text: value,
            color: Color(0xff252C32),
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
