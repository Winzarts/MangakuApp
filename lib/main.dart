import 'package:flutter/material.dart';
import 'package:mangaku/databases/appDB.dart';
import 'package:mangaku/providers/activityProviders.dart';
import 'package:mangaku/providers/detailProvider.dart';
import 'package:mangaku/providers/homeProvider.dart';
import 'package:mangaku/providers/libraryProvider.dart';
import 'package:mangaku/providers/readProvider.dart';
import 'package:mangaku/providers/searchProvider.dart';
import 'package:provider/provider.dart';
import 'package:mangaku/providers/themeProvider.dart';
import 'package:mangaku/themes/app_theme.dart';
import 'package:mangaku/screens/splash_screen.dart';
import 'package:mangaku/screens/homeScreen.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";

import 'package:mangaku/screens/searchScreen.dart';
import 'package:mangaku/screens/libraryScreen.dart';
import 'package:mangaku/screens/activityScreen.dart';
import 'package:mangaku/screens/navigationScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  
  // Initialize database
  final database = AppDatabase();
  
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;
  
  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => Homeprovider()),
        ChangeNotifierProvider(create: (_) => LibraryProvider()),
        ChangeNotifierProvider(create: (_) => Detailprovider()),
        ChangeNotifierProvider(create: (_) => ReaderProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => Activityproviders(database)),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'MangaKu',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: SplashScreen.routename,
            routes: {
              SplashScreen.routename: (context) => const SplashScreen(),
              HomeScreen.routename: (context) => const HomeScreen(),
              Searchscreen.routename: (context) => const Searchscreen(),
              LibraryScreen.routename: (context) => const LibraryScreen(),
              ActivityScreen.routename: (context) => const ActivityScreen(),
              NavigationScreen.routename: (context) => const NavigationScreen(),
            },
          );
        },
      ),
    );
  }
}