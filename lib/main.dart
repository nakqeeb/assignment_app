import 'package:assignment_app/helper/auth.dart';
import 'package:assignment_app/helper/theme_provider.dart';
import 'package:assignment_app/screens/main_screen.dart';
import 'package:assignment_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  // force the landscape mode only
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ThemeProvider()..initialize(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<Auth>(
      builder: (ctx, auth, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Assignment App',
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        home: FutureBuilder(
          future: auth.autoLogIn(),
          builder: (ctx, authResultSnapshot) =>
              auth.isAuth ? MainScreen() : const LoginScreen(),
        ),
        routes: {
          MainScreen.routeName: (context) => MainScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
        },
      ),
    );
  }
}
