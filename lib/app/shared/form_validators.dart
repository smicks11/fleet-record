import 'package:form_field_validator/form_field_validator.dart';

class MyFormValidator {
  static final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 characters'),
    // PatternValidator(r'(?=.*?[#?!|@+"_;$~%^&*\-(),[/])',
    //     errorText: 'Passwords must have at least one special character')
  ]);

  static final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Email must be a valid email address'),
  ]);

  static final contentValidator = MultiValidator([
    RequiredValidator(errorText: 'Content is required'),
    MinLengthValidator(1, errorText: 'Content must be at least 1 character'),
  ]);

  static final noValidator = MultiValidator([
    // RequiredValidator(errorText: 'Content is required'),
    // MinLengthValidator(1, errorText: 'Content must be at least 1 character'),
  ]);
  static final phoneNumberValidator = MultiValidator([
    RequiredValidator(errorText: 'Phone number is required'),
    MinLengthValidator(
      10,
      errorText: 'Phone number must be at least 10 digits',
    ),
    MaxLengthValidator(10, errorText: 'Phone number must be at most 10 digits'),
  ]);
  static final otpValidator = MultiValidator([
    RequiredValidator(errorText: 'Pin field cannot be empty'),
    MinLengthValidator(
      6,
      errorText: 'Pin is incorrect',
      //
    ),
    MaxLengthValidator(6, errorText: 'Pin is incorrect'),
  ]);

  static String? isValidName({required String? value, String? error}) {
    final nameRegExp = RegExp("\b([A-ZÀ-ÿ][-,a-z])+");
    // "/^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+\$/u");
    if (value?.isEmpty ?? true) {
      return 'Required';
    }
    if (nameRegExp.hasMatch(value ?? "")) {
      return error ?? 'Name is invalid';
    } else {
      return null;
    }
  }
}
