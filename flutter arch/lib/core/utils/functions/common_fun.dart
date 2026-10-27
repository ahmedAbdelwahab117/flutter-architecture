import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constant/app_colors.dart';
import '../constant/app_enums.dart'; 
import 'responsive.dart';

void unFocus(BuildContext context) => FocusScope.of(context).unfocus();

void showAppDialog({
  required BuildContext context,
  required String title,
  required String content,
  required Widget actions,
}) {
  showDialog(
    context: context,
    useRootNavigator: true,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.fontSize,
          fontWeight: FontWeight.w700,
          color: AppColors.titleTextColor,
        ),
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.fontSize,
          color: AppColors.bodyTextColor,
          height: 1.4,
        ),
      ),
      actions: [actions],
    ),
  );
}
void showToast( String msg,{
  ToastStates? state,
  Color? textColor,
  Color? backgroundColor,
}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor:
        backgroundColor ?? chooseToastColor(state ?? ToastStates.info),
    textColor: textColor ?? AppColors.whiteColor,
  );
}

Color chooseToastColor(ToastStates state) {
  Color color = AppColors.hintColor.withValues(alpha: 0.2);
  switch (state) {
    case ToastStates.success:
      color = AppColors.successColor;
      break;
    case ToastStates.warning:
      color = AppColors.warningColor;
      break;
    case ToastStates.error:
      color = AppColors.errorColor;
      break;
    case ToastStates.info:
      color = AppColors.infoColor;
      break;
  }
  return color;
}

String formatCountdownSeconds(int seconds) {
  final m = (seconds ~/ 60).toString().padLeft(2, '0');
  final s = (seconds % 60).toString().padLeft(2, '0');
  return '$m:$s';
}
      String formatDate(DateTime d) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${weekdays[d.weekday - 1]}, ${months[d.month - 1]} ${d.day}';
  }

    String formatTime(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

String formatPhoneNumber(String phone) {
  phone = phone.trim();
  if (phone.startsWith('0')) {
    return '+2$phone';
  } else if (phone.startsWith('1')) {
    return '+20$phone';
  }
  return phone;
}