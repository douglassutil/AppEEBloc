import 'package:flutter/material.dart';
import 'package:loja/screens/cadastro_eventos.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Eventos Esportivos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.green
      ),
      debugShowCheckedModeBanner: false,
      home: CadastroEventos(),
    );
  }
}

