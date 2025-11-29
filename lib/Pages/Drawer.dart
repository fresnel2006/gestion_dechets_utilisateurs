import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hackaton_utilisateur/Pages/Acceuil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Menu.dart';


class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}
final _controller = ZoomDrawerController();
class _DrawerPageState extends State<DrawerPage> {


  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
        menuBackgroundColor: Colors.white,
        mainScreenTapClose: true,
        angle: 0,
        slideWidth: MediaQuery.of(context).size.width * 0.7,
        showShadow: true,
        shadowLayer1Color: Colors.lightGreen[200],
        shadowLayer2Color: Colors.green[100],
        menuScreen: MenuPage(),
        mainScreen: AcceuilPage());
  }
}
