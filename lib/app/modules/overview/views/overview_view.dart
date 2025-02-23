import 'package:fleet_app/app/routes/app_pages.dart';
import 'package:fleet_app/app/shared/colors.dart';
import 'package:fleet_app/app/shared/main_menu.dart';
import 'package:fleet_app/app/shared/responsive_buidler.dart';
import 'package:fleet_app/app/shared/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/overview_controller.dart';

class OverviewView extends GetView<OverviewController> {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final scafoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scafoldKey,
      backgroundColor: AppColors.scafoldColor,
      drawer: ResponsiveBuilder.isDesktop(context)
          ? null
          : Drawer(child: buildSidebar()),
      body: SafeArea(
        child: ResponsiveBuilder(
          mobileBuilder: (context, constraints) => const SizedBox(),
          tabletBuilder: (context, constraints) => const SizedBox(),
          desktopBuilder: (context, constraints) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSidebar(),
              VerticalDivider(
                thickness: 1.9,
                color: Colors.grey.withOpacity(0.06),
              ),
              Expanded(
                flex: constraints.maxWidth > 1350 ? 16 : 15,
                child: Navigator(
                  key: Get.nestedKey(1),
                  initialRoute: Routes.HOME,
                  onGenerateRoute: (settings) => GetPageRoute(
                    settings: settings,
                    page: () => controller.getPage(settings.name),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSidebar() {
    return Sidebar(
      onProfilePressed: controller.onPressedProfile,
      mainMenuBuilder: (context) => MainMenu(
        onSelected: (index, value) => controller.navigateTo(getRoute(index)),
      ),
    );
  }

  String getRoute(int index) {
    switch (index) {
      case 0:
        return Routes.HOME;
      case 1:
        return Routes.CAR_PORTAL;
      case 2:
        return Routes.SETTINGS;
      default:
        return Routes.HOME;
    }
  }
}
