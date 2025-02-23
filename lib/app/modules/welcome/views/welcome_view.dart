import 'package:fleet_app/app/routes/app_pages.dart';
import 'package:fleet_app/app/shared/assets.dart';
import 'package:fleet_app/app/shared/colors.dart';
import 'package:fleet_app/app/shared/font_size.dart';
import 'package:fleet_app/app/shared/size.dart';
import 'package:fleet_app/app/shared/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    searchController.addListener(() {
      controller.showResults.value = searchController.text.isNotEmpty;
    });
    return Scaffold(
      backgroundColor: AppColors.scafoldColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 1.0,
        width: MediaQuery.of(context).size.width * 1.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.48,
                width: MediaQuery.of(context).size.width * 1.0,
                // padding: EdgeInsets.only(bottom: 50),
                decoration: BoxDecoration(
                  color: Color(0xffFAFAFA),
                ),
                child: Column(
                  children: [
                    S.h(20.h),
                    _buildNavBar(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Fleet Management Database",
                            style: GoogleFonts.montserrat(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          S.h(10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Easily browse and access fleet management records with a\nstreamlined search experience",
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9AA6AC)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          S.h(40),
                          SizedBox(
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
                                      color: AppColors.disabledTextColor,
                                      width: 0.4),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.disabledTextColor,
                                      width: 0.4),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.disabledTextColor,
                                      width: 0.4),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.disabledTextColor,
                                      width: 0.4),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.disabledTextColor,
                                      width: 0.4),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          S.h(30.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.24,
                left: 0,
                right: 0,
                child: Center(
                  child: Obx(() => controller.showResults.value
                      ? searchResultComponent()
                      : SizedBox.shrink()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container searchResultComponent() {
    return Container(
      width: 600,
      decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: Colors.grey, width: 0.4),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: 'Results',
                    color: AppColors.disabledTextColor,
                    fontSize: FontSize.medium,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "View all",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
            S.h(20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: List.generate(5, (index) => resultWidget()),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container resultWidget() {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 0.4, color: Colors.black54),
                color: Colors.transparent),
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor, shape: BoxShape.circle),
            ),
          ),
          S.w(10.w),
          TextView(
            text: 'T.HILUX/MUS 373 AA',
            fontSize: FontSize.medium,
            fontWeight: FontWeight.w500,
            color: Color(0xff5B636A),
          ),
          S.w(15.w),
          SizedBox(
            height: 15,
            child: VerticalDivider(
              width: 2.0,
              color: Colors.grey,
            ),
          ),
          S.w(15.w),
          TextView(
            text: 'CBG ALLEN',
            fontSize: FontSize.medium,
            fontWeight: FontWeight.w500,
            color: Color(0xff5B636A),
          ),
          S.w(15.w),
          SizedBox(
            height: 15,
            child: VerticalDivider(
              width: 2.0,
              color: Colors.grey,
            ),
          ),
          S.w(15.w),
          TextView(
            text: 'Damilare Kazeem',
            fontSize: FontSize.medium,
            fontWeight: FontWeight.w500,
            color: Color(0xff5B636A),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                ImageAssets.logo,
                height: 40,
              ),
              S.w(4.w),
              const Text(
                "FleetDB",
                style: TextStyle(
                    fontSize: FontSize.large, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(width: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(
                  color: Color(0xFFFFA726),
                  width: 1.5,
                ),
              ),
            ),
            onPressed: () {
              Get.toNamed(Routes.LOGIN);
            },
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}




// Container(
          //   decoration: const BoxDecoration(
          //     color: Colors.white,
          //   ),
          // ),
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     height: 500,
          //     decoration: BoxDecoration(
          //       gradient: RadialGradient(
          //         colors: [Color.fromARGB(255, 255, 203, 157), Colors.white],
          //         center: Alignment(0, -0.09),
          //         radius: 0.9,
          //       ),
          //     ),
          //   ),
          // ),