import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'app/routes/app_pages.dart';

class FleetApp extends StatefulWidget {
  const FleetApp({super.key});

  @override
  State<FleetApp> createState() => _FleetAppState();
}

class _FleetAppState extends State<FleetApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: _getDesignSize(context),
      builder: (context, child) => child!,
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        title: "Fleet",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
      ),
    );
  }

  Size _getDesignSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 768) {
      return const Size(1440, 900);
    } else {
      return const Size(1440, 900);
    }
  }
}
