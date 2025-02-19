class Constants {
  //local
  // static const String baseUrl = "http://192.168.88.112:8080/";
  //production
  // static const String baseUrl = "https://marketawy.cyparta.com/";



  static const String token = 'access_token';
  static const String refresh_token = 'refresh_token';
  static const String authorization = 'Authorization';
  static const String onboarding = 'onboarding';
  static const String acceptLanguage = 'accept_language';

  static const String baseUrl = "https://marketawy.cyparta.com/";
  static const String login = "core/login/";

  static const String register = "core/register/";
  static const String resetPassword = "core/reset-password/";
  static const String refreshToken = "api/token/refresh/";
  static const String changePassword = "core/change_password/";
  static const String forgetPassword = "core/change-email/";
  static const String verifyOtp = "core/verify-otp/";
  static const String categories = "core/category/";
  static const String sendOtp = "core/send-otp/";
  static const String tasks = "task/tasks/";
  static const String confirmTask = "task/tasks/approve/";
  static const String approveTask = "task/tasks/approve/";
  static const String ads = "core/ads/";
  static const String profile = "core/user/";
  static const String editProfile = "core/user/";
  static const String deleteAccount = "core/user/";
  static const String logOut = "core/logout/";
  static const String registerFcm = "core/register-fcm-device/";
  static const String notifications = "core/notification/";
  static  String organizationReview(int organization ) => "core/$organization/review/";
  static const String review = "core/review/";
  static const String company = "core/company-account/";
  static const String transactions = "core/transaction/";



  static const String notificationChannelId = 'notificationChannelId';
  static const String notificationChannelName = 'notificationChannelName';

  // static const String token = "token";
  // static const String refresh_token  = "refresh";

  static const String en = 'en';
  static const String ar = 'ar';
  // static const String authorization = 'Authorization';
  // static const String acceptLanguage = 'Accept Language';
}