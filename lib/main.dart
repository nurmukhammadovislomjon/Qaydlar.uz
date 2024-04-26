import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:qaydlar_uz/database/notes_database.dart';
import 'package:qaydlar_uz/pages/home_page.dart';
import 'package:qaydlar_uz/services/shared_preferences.dart';
import 'package:qaydlar_uz/theme/dark_theme.dart';
import 'package:qaydlar_uz/theme/light_theme.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // print(ThemePrefs.getIsDarkMode());
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await NotesDatabase.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => NotesDatabase(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isDarkMode;

  @override
  void initState() {
    super.initState();

    loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDarkMode != null
          ? isDarkMode!
              ? ThemeMode.dark
              : ThemeMode.light
          : ThemeMode.system 
    );
  }

  void loadTheme() async {
    isDarkMode = await ThemePrefs.getTheme();

    setState(() {});

    FlutterNativeSplash.remove();
  }
}
