import 'package:flutter/material.dart';

// import '../../../config/router/app_router_keys.dart';
 // import '../../../modules/auth/otp/model/otp_args.dart';
import '../../../nidaa_khafia_app.dart';
// import '../constant/app_enums.dart';
// import 'router_handler.dart';

/// Any endpoint may answer 403 with this body when the account exists but its
/// phone number was never confirmed:
///
/// ```json
/// {
///   "detail": "رقمك غير موثّق بعد. أدخل الكود الذي أرسلناه لك.",
///   "code": "phone_not_verified",
///   "next_step": "verify_otp",
///   "phone": "+9647001234567",
///   "retry_after": null
/// }
/// ```
///
/// The caller still receives `detail` as its error message; this only takes
/// care of the `next_step` redirect.
const String phoneNotVerifiedCode = 'phone_not_verified';

const String _verifyOtpStep = 'verify_otp';

/// Guards against stacking several OTP screens when a burst of requests all
/// come back with the same 403.
bool _isRedirecting = false;

Future<void> handlePhoneNotVerified(Map<String, dynamic> body) async {
  if (_isRedirecting) return;
  if (body['next_step'] != _verifyOtpStep) return;

  final String phone = body['phone']?.toString() ?? '';
  if (phone.isEmpty) return;

  final BuildContext? context = NidaaKhafiaApp.navigatorKey.currentContext;
  if (context == null || !context.mounted) return;

  // final int? retryAfter = int.tryParse(body['retry_after']?.toString() ?? '');

  _isRedirecting = true;
  try {
    // await RouterHandler.navigate(
    //   context,
    //   AppRouterKeys.otp,
    //   extra: OtpArgs(
    //     type: OtpVerifyType.register,
    //     phone: phone,
    //     resendAfterSeconds: retryAfter,
    //   ),
    // );
  } finally {
    _isRedirecting = false;
  }
}
