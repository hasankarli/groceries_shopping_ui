import 'package:flutter/material.dart';
import 'package:groceries_shopping_ui/product_list_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) =>
          MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.nunitoSansTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: const ProductListScreen(),
      ),
    );
  }
}
