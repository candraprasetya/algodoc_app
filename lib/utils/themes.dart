part of 'utils.dart';

mixin colors {
  static Color bluePrimary = Color(0xFF4E7ED6);
  static Color blackNatural = Color(0xFF21212C);
  static Color greyNatural = Color(0xFF93939E);
}
mixin textCustom {
  static TextStyle headline = GoogleFonts.montserrat(
      color: colors.blackNatural, fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle content = GoogleFonts.montserrat(
      color: colors.greyNatural, fontSize: 14, fontWeight: FontWeight.w600);
}
