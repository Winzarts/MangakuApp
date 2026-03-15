import 'package:flutter/material.dart';
import 'package:mangaku/providers/homeProvider.dart';
import 'package:mangaku/providers/searchProvider.dart';
import 'package:mangaku/providers/libraryProvider.dart';
import 'package:mangaku/providers/activityProvider.dart';
import 'package:mangaku/providers/detailProvider.dart';
import 'package:mangaku/providers/readProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:mangaku/themes/zenThemes.dart';
import 'package:mangaku/widgets/bottomNavBar.dart';
import 'package:mangaku/database/Appdb.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  await dotenv.load(fileName: ".env");
  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final AppDatabase db;
  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => LibraryProvider()),
        ChangeNotifierProvider(create: (_) => ActivityProvider(db)),
        ChangeNotifierProvider(create: (_) => DetailProvider()),
        ChangeNotifierProvider(create: (_) => ReaderProvider()),
      ],
      child: MaterialApp(
        title: 'Mangaku',
        debugShowCheckedModeBanner: false,
        theme: ZenTheme.dark,
        home: const BottomNavbar(),
      ),
    );
  }
}
