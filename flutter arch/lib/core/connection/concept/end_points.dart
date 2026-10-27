class EndPoints {
  static const String baseUrl = 'https://backapi.gwscegypt.com/';
  static const String refreshTokenApi = 'api/v1/auth/token/refresh/';
  static const String activities = 'api/v1/content/activities/';
  static const String events = 'api/v1/content/events/';
  static const String facilities = 'api/v1/content/facilities/';
  static const String register = 'api/v1/auth/mobile/register/';
  static const String login = 'api/v1/auth/mobile/login/';
  static const String profile = 'api/v1/auth/me/';
  static const String changePassword = 'api/v1/auth/change-password/';
  static const String news = 'api/v1/content/news/';
  static const String boardMembers = 'api/v1/content/board-members/';
  static const String reels = 'api/v1/reels/';
  static const String membershipInfo = '/api/v1/billing/my-membership-renewal/';
  static const String issueMembershipRenewal =
      'api/v1/billing/my-membership-renewal/issue/';
  static const String payMembershipRenewalStripe =
      'api/v1/billing/my-membership-renewal/pay/stripe/';
  static const String stripeConfirmSession =
      'api/v1/payment/stripe/confirm-session/';
  static const String payEstablishmentAidStripe =
      'api/v1/billing/my-establishment-aid/pay/stripe/';
  static const String myEstablishmentAid =
      'api/v1/billing/my-establishment-aid/';
  static const String payActivationInvoiceStripe =
      'api/v1/billing/my-activation-invoice/pay/stripe/';
  static const String myActivationInvoice =
      'api/v1/billing/my-activation-invoice/';
  static const String verifyOtp = 'api/v1/auth/mobile/register/verify-otp/';
  static const String sendOtp = 'api/v1/auth/mobile/register/send-otp/';
  static const String forgotPasswordSendOtp =
      'api/v1/auth/forgot-password/send-otp/';
  static const String forgotPasswordVerifyOtp =
      'api/v1/auth/forgot-password/verify-otp/';
  static const String forgotPasswordReset =
      'api/v1/auth/forgot-password/reset/';
  static const String membershipRequests = 'api/v1/membership-requests/';
  static const String membershipTypes = 'api/v1/membership-types/';
  static const String jobs = 'api/v1/jobs/';
  static const String qualifications = 'api/v1/qualifications/';
  static const String myInvoices = 'api/v1/billing/my-invoices/';
  static const String billingPreview = 'api/v1/billing/preview/';
  static const String notifications = 'api/v1/notifications/';
  static const String readAllNotifications = 'api/v1/notifications/read-all/';
  static const String registerDevice = 'api/v1/notifications/devices/register/';
  static const String unregisterDevice =
      'api/v1/notifications/devices/unregister/';
  // Marketplace (المتاجر) — see MOBILE_MARKETPLACE_API.md
  static const String _marketplace = 'api/v1/marketplace/';
  static const String vendorCategories = '${_marketplace}vendor-categories/';
  static const String vendors = '${_marketplace}vendors/';
  static const String products = '${_marketplace}products/';
  static const String cart = '${_marketplace}cart/';
  static const String cartItems = '${_marketplace}cart/items/';
  static const String checkout = '${_marketplace}checkout/';
  static const String orders = '${_marketplace}orders/';
  static const String cartSummary = '${_marketplace}cart/summary/';
  static const String deliveryLocations = '${_marketplace}delivery-locations/';

  static String vendorById(int id) => '$vendors$id/';
  static String vendorSections(int id) => '$vendors$id/categories/';
  static String vendorReviews(int id) => '$vendors$id/reviews/';
  static String vendorFavorite(int id) => '$vendors$id/favorite/';
  static String productById(int id) => '$products$id/';
  static String cartItemById(int id) => '$cartItems$id/';
  static String orderById(int id) => '$orders$id/';
  static String orderPaySdk(int id) => '$orders$id/pay/sdk/';
  static String orderPayStripe(int id) => '$orders$id/pay/stripe/';
  static String orderCancel(int id) => '$orders$id/cancel/';
  static String orderReview(int id) => '$orders$id/review/';
  static String orderReorder(int id) => '$orders$id/reorder/';

  static String membershipRequestById(String id) =>
      'api/v1/membership-requests/by-request-id/$id/';
  static String membershipPayApplicationFee(String id) =>
      'api/v1/membership-requests/by-request-id/$id/application-fee/pay/sdk/';

  static String membershipPayApplicationFeeStripe(String id) =>
      'api/v1/membership-requests/by-request-id/$id/application-fee/pay/stripe/';

  static String membershipPayApplicationFeeStripeLoggedIn(String id) =>
      'api/v1/membership-requests/$id/application-fee/pay/stripe/';

  static String myInvoiceById(String id) => 'api/v1/billing/my-invoices/$id/';

  static String payInvoiceStripe(String id) =>
      'api/v1/billing/invoices/$id/pay/stripe/';

  static const String relationshipTypes = 'api/v1/relationship-types/';
  static const String areas = 'api/v1/areas/';
  static const String addDependent = 'api/v1/dependent-member-requests/';
}
