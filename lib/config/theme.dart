import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view.dart';

ThemeData theme() => ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: Colors.transparent,
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        color: menuColor,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
      listTileTheme: ListTileThemeData(
        visualDensity: const VisualDensity(vertical: -1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        // style: ,
        tileColor: Colors.grey[700],
        subtitleTextStyle: const TextStyle(
          color: textAndIconColor,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        titleTextStyle: const TextStyle(
          color: textAndIconColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        leadingAndTrailingTextStyle: const TextStyle(color: textAndIconColor),
        iconColor: textAndIconColor,
        textColor: textAndIconColor,
      ),
      iconTheme: const IconThemeData(
        color: textAndIconColor,
        size: 26,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80,
      ),
      textTheme: GoogleFonts.robotoTextTheme(
        const TextTheme(
          displaySmall: TextStyle(
            color: textAndIconColor,
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
          labelMedium: TextStyle(
            color: textAndIconColor,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          labelLarge: TextStyle(
            color: textAndIconColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          // Alert dialog title
          titleMedium: TextStyle(
            color: textAndIconColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          titleSmall: TextStyle(
            color: textAndIconColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            color: textAndIconColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          )
        ),
      ),
    );
