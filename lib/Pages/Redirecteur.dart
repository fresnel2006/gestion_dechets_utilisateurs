import 'package:flutter/material.dart';
import 'package:hackaton_utilisateur/Pages/Acceuil.dart';
import 'package:lottie/lottie.dart';
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
    if(rediriger==false) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>InscriptionPage()));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerPage()));

    }
  }
@override
void initState() {
    super.initState();
     charger();
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(width: MediaQuery.of(context).size.width *1,),
          Container(child: Lottie.asset("assets/animations/chargement.json"),),
          Container(child: Text("CHARGEMENT ...",style: TextStyle(fontFamily: "Poppins"),),)
        ],)
    );
  }
}
