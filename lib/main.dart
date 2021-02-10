import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'models/transaction_data.dart';
import 'screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'title',
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
          accentColor: Colors.blueAccent,
          textTheme: GoogleFonts.poppinsTextTheme(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.blueAccent,
          accentColor: Colors.blueAccent,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
