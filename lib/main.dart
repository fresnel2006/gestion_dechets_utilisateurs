import  'package:flutter/material.dart';
import 'package:hackaton_utilisateur/Pages/Acceuil.dart';
import 'package:hackaton_utilisateur/Pages/Compte.dart';
import 'package:hackaton_utilisateur/Pages/CompteModification.dart';
import 'package:hackaton_utilisateur/Pages/Drawer.dart';
import 'package:hackaton_utilisateur/Pages/Rapports.dart';

import 'package:hackaton_utilisateur/Pages/Redirecteur.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
body: RedirecteurPage()
      ),
    );
  }
}