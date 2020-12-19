import 'package:flutter/material.dart';
import 'package:stripe_app/pages/home.dart';
import 'package:stripe_app/pages/pagoCompleto.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stripe App',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePage(),
        'pago_completo': (_) => PagoCompletoPage(),
      },
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xff284879),
        scaffoldBackgroundColor: Color(0xff21212A),
      ),
    );
  }
}
