// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qaydlar_uz/main.dart';
import 'package:qaydlar_uz/pages/drawer/info_app_page.dart';
import 'package:qaydlar_uz/services/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool? isDarkMode;
  bool? birinchiIsDarkMode;

  @override
  void initState() {
    super.initState();
    loadDataTheme();
  }

  IconData themeIcon = FontAwesomeIcons.spinner;
  String themeTxt = "yuklanmoqda";

  Widget? saveThemeWidget;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            Center(
              child: Container(
                width: size.width * 0.5,
                height: size.width * 0.5,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: Image.asset(
                    "assets/images/todo-list.png",
                    width: size.width * 0.4,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            ListTile(
              title: Text(
                themeTxt,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: IconButton(
                  onPressed: () => themeChange(),
                  icon: Icon(
                    themeIcon,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  )),
            ),
            saveThemeWidget ?? Container(),
            ListTile(
              onTap: ()=>Navigator.push(context, PageTransition(child: const InfoAppPage(), type: PageTransitionType.rightToLeftWithFade)),
              title: Text(
                "Ilova haqida",
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                FontAwesomeIcons.solidCircleQuestion,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget saveNotNullWidget() => ListTile(
        title: Text(
          "Saqlash",
          style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.w500),
        ),
        onTap: () {
          saveTheme();
        },
        trailing: Icon(
          Icons.check,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      );

  void saveFuncWidgets() async {
    if (birinchiIsDarkMode != isDarkMode) {
      saveThemeWidget = saveNotNullWidget();
    } else if (birinchiIsDarkMode == isDarkMode) {
      saveThemeWidget = null;
    }
    setState(() {});
  }

  void saveTheme() async {
    if (isDarkMode == null) {
      await ThemePrefs.deleteTheme();
    } else {
      await ThemePrefs.saveTheme(isDarkMode!);
    }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
        (route) => false);
  }

  void themeChange() async {
    if (isDarkMode == null) {
      isDarkMode = false;
    } else if (isDarkMode == false) {
      isDarkMode = true;
    } else if (isDarkMode == true) {
      isDarkMode = null;
    }
    saveFuncWidgets();
    isDarkModeFunc();
  }

  void loadDataTheme() async {
    isDarkMode = await ThemePrefs.getTheme();
    birinchiIsDarkMode = await ThemePrefs.getTheme();
    isDarkModeFunc();
    // setState(() {});
  }

  void isDarkModeFunc() {
    if (isDarkMode == false) {
      themeIcon = FontAwesomeIcons.sun;
      themeTxt = "Kunduzgi";
    } else if (isDarkMode == true) {
      themeIcon = FontAwesomeIcons.solidMoon;
      themeTxt = "Tungi";
    } else if (isDarkMode == null) {
      themeIcon = FontAwesomeIcons.circleHalfStroke;
      themeTxt = "Sistema";
      // setState(() {});
    }
    setState(() {});
  }
}
