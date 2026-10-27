/// Corner radii.
///
/// A small, fixed set — mixing arbitrary radii is the fastest way to make a
/// screen look assembled rather than designed.
class AppRadius {
  /// Compact list cards — the brand and order-again rails.
  static const double xs = 6;

  /// Chips, small badges, image thumbnails in rows.
  static const double sm = 8;

  /// Buttons, input fields, small cards.
  static const double md = 10;

  /// Store card images, banners, tiles — the workhorse radius.
  static const double lg = 12;

  /// Bottom sheets, modal surfaces, hero images.
  static const double xl = 16;

  /// Large modal surfaces and the top of a dragged sheet.
  static const double xxl = 20;

  /// Fully rounded: overlay pills, category circles, counters.
  static const double pill = 100;
}
