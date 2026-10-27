class StorageKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String onboardingSeen = 'onboarding_seen';
  static const String userName = 'user_name';
  static const String userEmail = 'user_email';
  static const String userPhone = 'user_phone';
  static const String isGuest = 'is_guest';
  static const String isMember = 'is_member';
  static const String isSendMember = 'is_send_member';
  static const String fcmRegistered = 'fcm_registered';
  static const String watchedReelIds = 'watched_reel_ids';

  /// The `latest_version` a user dismissed the optional update prompt for, so
  /// the prompt returns only when a newer version ships.
  static const String dismissedUpdateVersion = 'dismissed_update_version';
}
