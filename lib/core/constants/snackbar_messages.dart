import 'package:flutter/cupertino.dart';
import 'package:bluetrack/core/components/hex_color.dart';
import 'package:flutter/material.dart';

class SnackBarMessages {
  static final SnackBarMessages instance = SnackBarMessages._internal();

  SnackBarMessages._internal();

  final loginSuccessfully = 'login_successfully';
  final loginFaild = 'faild_login';
  final registerSuccessfully = 'register_successfully';
  final registerFaild = 'faild_register';
  final unknownError = 'unknown_error';
  final tokenRefreshMessage = '401_status_code_error';
  final otpFaild = 'faild_otp';
  final otpResendFaild = 'faild_resend_otp';
  final changeLocalFaild = 'faild_change_local';
  final changeCurrencyFaild = 'faild_change_currency';
  final changeLocalSuccessfully = 'change_local_successfully';
  final otpResendSuccessfully = 'resend_otp_successfully';
  final otpSuccessfully = 'enter_otp_successfully';
  final logoutSuccessfully = 'logout_successfully';
  final logoutFaild = 'faild_logout';
  final addeddSuccess = 'added_successfully';
  final changedSuccess = 'changed_successfully';
  final removeSuccess = 'removed_successfully';
  final somethingWrong = 'something_went_wrong';
  final differentVendor = 'different_vendor';
  final notStockAvailable = 'not_enough_stock_available';
  final phoneNumberRequired = 'phone_number_required';
  final addressRequired = 'address_required';
  final orderPriceChangedMessage = 'price_changed_message';
  final differentVendorKey = 'different_vendor';
  final orderPriceChangedKey = 'price_changed';
}
