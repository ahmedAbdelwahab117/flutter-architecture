/// Spacing scale, tuned to the Bolt Food layout language.
///
/// A literal padding in a widget is how a screen drifts out of the system, so
/// everything visual pulls its gaps from here.
class AppSpacing {
  /// Horizontal gutter for every screen body. Cards bleed to this edge.
  static const double screen = 16;

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  /// Vertical gap between two major sections of a screen.
  static const double section = 28;

  /// Gap between a section header and the content it labels.
  static const double headerGap = 12;

  /// Gap between sibling cards in a vertical feed.
  static const double cardGap = 20;
}
