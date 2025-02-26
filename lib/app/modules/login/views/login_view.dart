import 'package:fleet_app/app/shared/assets.dart';
import 'package:fleet_app/app/shared/button.dart';
import 'package:fleet_app/app/shared/colors.dart';
import 'package:fleet_app/app/shared/font_size.dart';
import 'package:fleet_app/app/shared/form_validators.dart';
import 'package:fleet_app/app/shared/size.dart';
import 'package:fleet_app/app/shared/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final signInFormKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100.w),
                  child: Center(
                    child: SizedBox(
                      width: 450,
                      child: Form(
                        key: signInFormKey,
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            S.h(100),
                            Center(
                              child: Image.asset(
                                ImageAssets.logo,
                                height: 40,
                              ),
                            ),
                            S.h(30),
                            Center(
                              child: Text(
                                'Login to your Account',
                                style: GoogleFonts.montserrat(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff252C32),
                                ),
                              ),
                            ),
                            S.h(50.h),
                            TextView(
                              text: 'Email Address',
                              color: const Color(0xff6E7C87),
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize.small,
                            ),
                            S.h(9),
                            TextFormField(
                              controller: emailController,
                              validator: MyFormValidator.emailValidator.call,
                              style:
                                  GoogleFonts.poppins(fontSize: FontSize.small),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 12),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffDDE2E4), width: 0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.disabledTextColor,
                                        width: 0.4),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.disabledTextColor,
                                        width: 0.4),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.02)),
                            ),
                            const SizedBox(height: 24),
                            TextView(
                              text: 'Password',
                              color: const Color(0xff6E7C87),
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize.small,
                            ),
                            S.h(9),
                            Obx(() => TextFormField(
                                  controller: passwordController,
                                  obscureText:
                                      !controller.isPasswordVisible.value,
                                  validator:
                                      MyFormValidator.passwordValidator.call,
                                  style: GoogleFonts.poppins(
                                      fontSize: FontSize.small),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 12),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffDDE2E4), width: 0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.disabledTextColor,
                                          width: 0.4),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.disabledTextColor,
                                          width: 0.4),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.02),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.isPasswordVisible.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      onPressed:
                                          controller.togglePasswordVisibility,
                                    ),
                                  ),
                                )),
                            // S.h(6.h),
                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: MyButton.fill(
                            //     context: context,
                            //     textColor: AppColors.primaryColor,
                            //     fontWeight: FontWeight.w500,
                            //     backgroundColor: Colors.transparent,
                            //     text: 'Forgot password?',
                            //     fontSize: FontSize.medium,
                            //     isTextButton: true,
                            //     onPressed: () {},
                            //   ),
                            // ),
                            S.h(50.h),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: Obx(() => MyButton.fill(
                                    context: context,
                                    loading: controller.isBusy.value,
                                    borderRadius: BorderRadius.circular(12),
                                    text: 'Login',
                                    fontWeight: FontWeight.w500,
                                    onPressed: () async {
                                      if (signInFormKey.currentState!
                                          .validate()) {
                                        await controller.signIn(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim(),
                                            );
                                      }
                                    },
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageAssets.loginBg),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
