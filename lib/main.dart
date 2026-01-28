import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main(){
  runApp(const RumahKosApps());
}

class RumahKosApps extends StatelessWidget {
  const RumahKosApps({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RumahKos Apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const LoginScreen(),
    );
  }
}