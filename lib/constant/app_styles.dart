import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'color_constant.dart';

/// A class that holds all the icon sizes used throughout
/// the entire app.
@immutable
class IconSizes {
  const IconSizes._privateConstructor();

  static const double sm19 = 19;
  static const double med22 = 22;
  static const double lg27 = 27;
}

/// A class that holds the height and width
/// throughout the entire app by things such as getting height, width, divider etc.
@immutable
class UiUtils {
  const UiUtils._privateConstructor();

  static disableKeyboard(context) => FocusScope.of(context).requestFocus(FocusNode());

  static Divider getDivider({double height = 1}) => Divider(thickness: 1, height: height);

  static Size getScreenSize(context) => MediaQuery.of(context).size;

  static double getScreenWidth(context) => MediaQuery.of(context).size.width;

  static double getScreenHeight(context) => MediaQuery.of(context).size.height;

  static Future<bool> checkInternet() async {
    return await InternetConnectionChecker().hasConnection;
  }
}

/// A class that holds all the gaps and insets used
/// throughout the entire app by things such as padding, sizedbox etc.
@immutable
class Insets {
  const Insets._privateConstructor();

  static const double formHzPadding = 15;

  static const double homeHzPadding = 28;

  static const double sectionTitleVTPadding = 14;

  /// [SizedBox] of height **3**.
  static const gapH3 = SizedBox(height: 3);

  /// [SizedBox] of height **4**.
  static const gapH4 = SizedBox(height: 4);

  /// [SizedBox] of height **8**.
  static const gapH8 = SizedBox(height: 8);

  /// [SizedBox] of width **3**.
  static const gapW3 = SizedBox(width: 3);

  /// [SizedBox] of height **5**.
  static const gapH5 = SizedBox(height: 5);

  /// [SizedBox] of width **5**.
  static const gapW5 = SizedBox(width: 5);

  /// [SizedBox] of height **10**.
  static const gapH10 = SizedBox(height: 10);

  /// [SizedBox] of width **10**
  static const gapW10 = SizedBox(width: 10);

  /// [SizedBox] of width **15**
  static const gapW15 = SizedBox(width: 15);

  /// [SizedBox] of width **20**
  static const gapW20 = SizedBox(width: 20);

  /// [SizedBox] of height **15**
  static const gapH15 = SizedBox(height: 15);

  /// [SizedBox] of height **20**
  static const gapH20 = SizedBox(height: 20);

  /// [SizedBox] of height **25**
  static const gapH25 = SizedBox(height: 25);

  /// [SizedBox] of height **25**
  static const gapH40 = SizedBox(height: 40);

  /// [Spacer] for adding infinite gaps, as much as the constraints
  /// allow.
  static const expand = Spacer();

  /// The value for bottom padding of buttons in the app.
  /// It is measured from the bottom of the screen, that is
  /// behind the android system navigation.
  /// Used to prevent overlapping of android navigation with the button.
  static const bottomInsets = SizedBox(height: 38);

  /// The value for a smaller bottom padding of buttons in the app.
  /// It is measured from the bottom of the screen, that is
  /// behind the android system navigation.
  /// Used to prevent overlapping of android navigation with the button.
  static const bottomInsetsLow = SizedBox(height: 20);
}

/// A class that holds all the border radiuses used throughout
/// the entire app by things such as container, card etc.
///
@immutable
class Corners {
  const Corners._();

  /// [BorderRadius] rounded on all corners by **4**
  static const BorderRadius rounded4 = BorderRadius.all(Radius.circular(4));

  static const BorderRadius rounded5 = BorderRadius.all(Radius.circular(5));

  static const BorderRadius rounded10 = BorderRadius.all(Radius.circular(10));

  static const BorderRadius rounded15 = BorderRadius.all(Radius.circular(15));
}

/// A class that holds all the shadows used throughout
/// the entire app by things such as animations, tickers etc.
///
/// This class has no constructor and all variables are `static`.
@immutable
class Shadows {
  const Shadows._();

  static const List<BoxShadow> universal = [
    BoxShadow(
      color: Color.fromRGBO(51, 51, 51, 0.15),
      blurRadius: 10,
    ),
  ];

  static const elevated = <BoxShadow>[
    BoxShadow(
      color: Color.fromARGB(76, 158, 158, 158),
      blurRadius: 3,
      spreadRadius: -0.2,
      offset: Offset(2, 0),
    ),
    BoxShadow(
      color: Color.fromARGB(76, 158, 158, 158),
      blurRadius: 3,
      spreadRadius: -0.2,
      offset: Offset(-2, 0),
    ),
  ];

  static const List<BoxShadow> small = [
    BoxShadow(
      color: Color.fromRGBO(51, 51, 51, .15),
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
  ];
}

/// A class that holds all the text specific styles used throughout
/// the entire app by things such as heading, description, input field, etc
///
/// This class has no constructor and all variables are `static`.
@immutable
class Textify {
  const Textify._();

  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.48,
    color: AppColors.APP_PRIMARY_COLOR,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.APP_PRIMARY_COLOR,
  );

  static const TextStyle heading4 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.APP_PRIMARY_COLOR,
  );

  static const TextStyle paragraph1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    letterSpacing: 0.28,
  );

  static const TextStyle paragraph2 = TextStyle(
    fontSize: 12,
    color: AppColors.APP_PRIMARY_COLOR
  );

  static const TextStyle paragraph3 = TextStyle(
      fontSize: 10,
      color: AppColors.APP_PRIMARY_COLOR
  );

  static const TextStyle hint = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle title1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle title2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
}