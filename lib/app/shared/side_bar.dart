import 'package:fleet_app/app/shared/assets.dart';
import 'package:fleet_app/app/shared/colors.dart';
import 'package:fleet_app/app/shared/font_size.dart';
import 'package:fleet_app/app/shared/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Sidebar extends StatelessWidget {
  // final UserProfileData dataProfile;
  final dynamic Function() onProfilePressed;
  final Widget Function(BuildContext context) mainMenuBuilder;

  const Sidebar({
    Key? key,
    // required this.dataProfile,
    required this.onProfilePressed,
    required this.mainMenuBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: MediaQuery.of(context).size.width > 1350 ? 2 : 4,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
              children: [
                Image.asset(
                  ImageAssets.logo,
                  height: 30,
                  width: 30,
                ),
                S.w(3.w),
                const Text(
                  "FleetDB",
                  style: TextStyle(
                      fontSize: FontSize.large, fontWeight: FontWeight.w600),
                ),
              ],
                        ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: mainMenuBuilder(context),
            ),
           
          ],
        ),
      ),
    );
  }
}
