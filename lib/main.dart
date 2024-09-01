import 'package:expenses_app/widgets/expenses_list/expanses.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp
  // ]).then((fn) {
runApp(const MyApp());
  // });
  
}

var colorsceame =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(104, 0, 255, 149));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
          colorScheme: colorsceame,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: colorsceame.onPrimaryContainer,
            foregroundColor: colorsceame.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: colorsceame.secondary,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          ),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle(fontSize: 22 ),
              bodyMedium: const TextStyle(
                  fontSize: 17)),
          iconTheme: const IconThemeData()
              .copyWith(color: colorsceame.secondaryContainer),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(colorsceame.primaryContainer),
            foregroundColor: MaterialStatePropertyAll(colorsceame.primary),
          )),
          dialogTheme: const DialogTheme().copyWith(
            backgroundColor: colorsceame.onPrimary,
            contentTextStyle: TextStyle(color: colorsceame.secondary),
          ),
          iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      colorsceame.primary)))),
      home: const Expanses(),
    );
  }
}
