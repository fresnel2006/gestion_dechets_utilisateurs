import 'package:flutter/material.dart';
import 'package:hackaton_utilisateur/Pages/Acceuil.dart';
import 'Drawer.dart';
import 'Inscription.dart';
import 'package:shared_preferences/shared_preferences.dart';



class RedirecteurPage extends StatefulWidget {
  const RedirecteurPage({super.key});

  @override
  State<RedirecteurPage> createState() => _RedirecteurPageState();
}

class _RedirecteurPageState extends State<RedirecteurPage> {

  bool rediriger=false;

  Future <void> charger() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(()  {
      rediriger= preferences.getBool("rediriger")??false;
    });
  }
@override
void initState() {
    super.initState();
     charger();
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:LayoutBuilder(builder: (context, constraints){

        if(rediriger==false) {
          return InscriptionPage();
        }else{
          return DrawerPage();
        }

      },),
    );
  }
}
