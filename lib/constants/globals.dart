import 'package:flutter/material.dart';

ShapeBorder roundedRadius18 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0));
ShapeBorder roundedRadius25 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0));
ShapeBorder roundedRadius30 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0));

ButtonStyle buttonStyleRounded18BlueWhite = ButtonStyle(
  shape: MaterialStateProperty.all(roundedRadius18),
  backgroundColor: MaterialStateProperty.all(Colors.blue),
  foregroundColor: MaterialStateProperty.all(Colors.white),
);

ButtonStyle buttonStyleWhite = ButtonStyle(
  foregroundColor: MaterialStateProperty.all(Colors.white),
);
ButtonStyle buttonStyleBackgroundWhite = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.white),
);

ButtonStyle buttonStyleRounded18PaddingH50Indigo600White = ButtonStyle(
  shape: MaterialStateProperty.all(roundedRadius18),
  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 50)),
  backgroundColor: MaterialStateProperty.all(Colors.indigo[600]),
  foregroundColor: MaterialStateProperty.all(Colors.white),
);

ButtonStyle buttonStyleStadiumPaddingH50PrimaryWhite(BuildContext context) {
  return ButtonStyle(
    shape: MaterialStateProperty.all(StadiumBorder()),
    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 50)),
    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
    foregroundColor: MaterialStateProperty.all(Colors.white),
  );
}

ButtonStyle foregroundPrimary(BuildContext context) {
  return ButtonStyle(
    foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
  );
}

ButtonStyle getButtonStyleRounded(double radius, Color background, Color foreground) {
  return ButtonStyle(
    shape: MaterialStateProperty.all(roundedRadius18),
    backgroundColor: MaterialStateProperty.all(Colors.blue),
    foregroundColor: MaterialStateProperty.all(Colors.white),
  );
}

ButtonStyle buildButtonStyle({
  ShapeBorder border,
  Color background,
  Color forground,
  double horiztonalPadding,
  double verticalPadding,
  double minWidth,
  double height,
}) {
  return ButtonStyle(
    shape: MaterialStateProperty.all(border),
    foregroundColor: MaterialStateProperty.all(forground),
    backgroundColor: MaterialStateProperty.all(background),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(
        horizontal: horiztonalPadding,
        vertical: verticalPadding,
      ),
    ),
    minimumSize: MaterialStateProperty.all(Size.fromWidth(minWidth)),
    fixedSize: MaterialStateProperty.all(Size.fromHeight(height)),
  );
}

Color getPrimaryColor(BuildContext context) => Theme.of(context).primaryColor;