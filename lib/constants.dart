import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

const primaryColor = Color(0xFF44bd32);
const textColor = Color(0xFF35364F);
const backgroundColor = Color(0xFFE6EFF9);
const redColor = Color(0xFFE85050);

const defaultPadding = 16.0;

OutlineInputBorder textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor.withOpacity(0.1),
  ),
);

// I will explain it later

const emailError = 'Enter a valid email address';
const requiredField = "This field is required";

final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ],
);


const kLightTextColor = Color(0xffB5C8E7);
const kHardTextColor = Color(0xff586191);


const kPrimaryDarkColor = Color(0xFF44bd32);
const kPrimarylightColor = Color(0xFF44bd32);
const kBackgroundColor = Color(0xffEFF2F7);

const List<Color> kCategoriesPrimaryColor = [
  Color(0xffFFCA8C),
  Color(0xFF44bd32),
  Color(0xFF44bd32),
  Color(0xffB8ACFF)

];

const List<Color> kCategoriesSecondryColor = [
  Color(0xffFEA741),
  Color(0xff31DFB5),
  Color(0xff45BAFB),
  Color(0xff9182F9)
];


