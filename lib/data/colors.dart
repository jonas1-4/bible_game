import 'dart:ui';

//Dont using colortheme of Materialapp since it doesnt color things as I would
//prefer and im more creative if i have to color everything myself;

class Colorthemes {
  static const List<Color> foreground =       [Color(0xFFFEFAE0), Color(0xFFFFFFFF),];
  static const List<Color> background =       [Color(0xFF283618), Color(0xFF000000),];
  static const List<Color> backgroundlight =  [Color(0xFF606C38), Color(0xFF000000),];
  static const List<Color> accent =           [Color(0xFFBC6C25), Color(0xFF000000),];
  static const List<Color> accentlight =      [Color(0xFFDDA15E), Color(0xFF000000),];

  
  Color darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
        (c.blue * f).round());
  }
  
  Color brighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
        c.alpha,
        c.red + ((255 - c.red) * p).round(),
        c.green + ((255 - c.green) * p).round(),
        c.blue + ((255 - c.blue) * p).round());
  }
}
