import 'package:eventos/services/evento_service.dart';
import 'package:eventos/views/home_page.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const Evento());
}

class Evento extends StatelessWidget {
  const Evento({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}






