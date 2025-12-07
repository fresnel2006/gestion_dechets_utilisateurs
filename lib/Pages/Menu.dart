import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_zoom_drawer/src/drawer_controller.dart';
import 'package:hackaton_utilisateur/Pages/Compte.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var numero;
  var data;
  Future <void> affichier_donnee()async{
    final url=Uri.parse("http://192.168.1.7:8000/afficher_donnee_utilisateur");
    var message=await http.post(url,headers: {"Content-Type":"application/json"},
        body: jsonEncode({
          "numero":numero
        })
    );
    data=jsonDecode(message.body);
    print(data["resultat"][0]);
    print(data["resultat"][0][1]);
    print(data["resultat"][0][2]);
    print(data["resultat"][0][3]);
  }

  Future <void> restaurer_donnee() async{
    var perfs=await SharedPreferences.getInstance();
    setState(() {
      numero=perfs.getString("numero_utilisateur")??"vide";
    });
    print(numero);
  }
  Future <void> sauvegarder_donnee_utilisateur() async{
    var perfs=await SharedPreferences.getInstance();
    setState(() {
      perfs.setString("nom_utilisateur", data["resultat"][0][1]);
      perfs.setString("numero_utilisateur", data["resultat"][0][2]);
      perfs.setString("mot_de_passe_utilisateur", data["resultat"][0][3]);
    });
    print(numero);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
spacing: MediaQuery.of(context).size.height *0.018,
        children: [
        Container(decoration:BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1)),border: Border.all(color: Colors.green)),child: CircleAvatar(backgroundColor: Colors.lightGreen[50] ,radius: 45,child: Lottie.asset("assets/animations/deploiement.json"),),
        ),SizedBox(height: MediaQuery.of(context).size.height *0.025,),
          Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.03),height: MediaQuery.of(context).size.height *0.065,
            decoration: BoxDecoration(border: Border.all(color: Colors.green),color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1))),
            width: MediaQuery.of(context).size.width *1,
          child:Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_circle_sharp,color: Colors.green,),
              TextButton(onPressed: ()async{
                await restaurer_donnee();
                await affichier_donnee();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ComptePage()));

              }, child: Text("Mon compte",style: TextStyle(color: Colors.black,fontFamily: "Poppins2")))
            ],
          )),
          Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.03),height: MediaQuery.of(context).size.height *0.065,
              decoration: BoxDecoration(border: Border.all(color: Colors.green),color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1))),
              width: MediaQuery.of(context).size.width *1,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.car_crash,color: Colors.green,),
                  TextButton(onPressed: (){}, child: Text("PASSER PRO",style: TextStyle(color: Colors.black,fontFamily: "Poppins2"),))
                ],
              )),
          SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Container(height: MediaQuery.of(context).size.height *0.002,width:MediaQuery.of(context).size.width *0.2,color: Colors.green,),
            Text("OU",style: TextStyle(fontFamily: "Poppins2"),),
            Container(height: MediaQuery.of(context).size.height *0.002,width:MediaQuery.of(context).size.width *0.2,color: Colors.green,),

          ],),
          SizedBox(),
          Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.03),height: MediaQuery.of(context).size.height *0.065,
              decoration: BoxDecoration(border: Border.all(color: Colors.green),color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1))),
              width: MediaQuery.of(context).size.width *1,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  TextButton(onPressed: (){}, child: Text("VOIR PLUS",style: TextStyle(color: Colors.green,fontFamily: "Poppins2")))
                ],
              )),
          Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.03),height: MediaQuery.of(context).size.height *0.065,
              decoration: BoxDecoration(border: Border.all(color:  Colors.green),color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1))),
              width: MediaQuery.of(context).size.width *1,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.headset_mic_outlined),
                  TextButton(onPressed: (){}, child: Text("ASSISTANCE",style: TextStyle(color: Colors.green,fontFamily: "Poppins2")))
                ],
              )),




        ],),
    );
  }
}
