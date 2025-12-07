import 'dart:convert';
import 'package:hackaton_utilisateur/Pages/Redirecteur.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackaton_utilisateur/Pages/Drawer.dart';
import 'package:http/http.dart' as http;
import 'Inscription.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  //varaiable chargé de prendre une valeur pour affirme si l'utilisateur existe
  var data;
  var donnee_utilisateur;
  //fonction de sauvegarde permettant le chargement des dpages en foctions de l'utilisateur inscrit
  Future<void> sauvegarder() async{
    SharedPreferences perfs=await SharedPreferences.getInstance();
    await perfs.setBool("rediriger", true);
  }
  //fonction qui sert a envoyer les donnees dans la base de donnee(nom et mot_de_passe) pour un quelle me retourne si l'utilisateur existe
  Future <void> envoyerdonnee() async {
    final url = Uri.parse("http://192.168.1.7:8000/verifier_donnee");
    var message=await http.post(url,headers: {'Content-Type':'application/json'},
    body: jsonEncode({
      'numero':numero.text,
      'mot_de_passe':mot_de_passe.text
    }),
    );
    setState(() {
      data=jsonDecode(message.body);
    });
    print(data["existe"]);
  }
  //fonction pour afficher les information sur un utilisateur
  Future <void> affichier_donnee_utilisateur() async {
    final url = Uri.parse("http://192.168.1.7:8000/afficher_donnee_utilisateur");
    var message=await http.post(url,headers: {"Content-Type":"application/json"},body: jsonEncode({
      "numero":numero.text
    }));
    donnee_utilisateur=jsonDecode(message.body);

    print(donnee_utilisateur["resultat"][0][1]);
    print(donnee_utilisateur["resultat"][0][2]);
    var perfs=await SharedPreferences.getInstance();
    await perfs.setString("nom_utilisateur",donnee_utilisateur["resultat"][0][1]);
    await perfs.setString("numero_utilisateur",donnee_utilisateur["resultat"][0][2]);
  }
  //Variable de controler
  final numero=TextEditingController();
  final mot_de_passe=TextEditingController();
  bool bourdurecouleur1=true;
//Fonction de verification des saisie
void verifiersaisie() {
  //si le numero est inferieur a 10 ou superieur a 10
  if(numero.text.trim().length<10 || numero.text.trim().length>10){
    setState(() {
      //couleur devient rouge
      bourdurecouleur1=false;
    });
  }else{
    //couleur de l'input devient verte
    setState(() {
      bourdurecouleur1=true;
    });
  }
}
//fonction de redirection vers la page de acceuille
  void redirecteur()async{
    if(data["existe"]=="true"){
      await sauvegarder();
      await affichier_donnee_utilisateur();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>RedirecteurPage()), (route)=>false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
        Container(width: MediaQuery.of(context).size.width *1,),
      //Image de fond
      Container(
        child: Image.asset("assets/images/image_equipe.png",height: MediaQuery.of(context).size.height *0.4,width: MediaQuery.of(context).size.width *1,),
      ),
      //Pour l'input de la saisie du Nom
      Container(
        width: MediaQuery.of(context).size.width *0.7,
        height: MediaQuery.of(context).size.height *0.065,
        padding: EdgeInsets.only(left: 10,right: 10),
        child: TextFormField(
          controller: numero,
          style: TextStyle(fontFamily: "Poppins"),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          cursorColor: Color(0xFF292D3E),
          decoration: InputDecoration(
              hintText:"Numero",
              hintStyle: TextStyle(fontFamily: "Poppins",color: Colors.grey[500]),
              prefixIcon: Icon(FontAwesomeIcons.hashtag,size: 19,color: Color(0xFF292D3E),),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: bourdurecouleur1?Colors.green:Colors.red,width: MediaQuery.of(context).size.width *0.007,)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(MediaQuery.of(context).size.width *0.03)
                ), borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: bourdurecouleur1?Colors.green:Colors.red),
              )
          ),
        ),

      )

          //espace
          ,SizedBox(height: MediaQuery.of(context).size.height *0.02,),
          //espace

          Container(
      width: MediaQuery.of(context).size.width *0.7,
            height: MediaQuery.of(context).size.height *0.065,
      padding: EdgeInsets.only(left: 10,right: 10),
//Pour la saisie du numero
      child: TextFormField(
        controller: mot_de_passe,
        style: TextStyle(fontFamily: "Poppins"),
        cursorColor: Color(0xFF292D3E),
        decoration: InputDecoration(
          hintText: "Mot de passe",
          hintStyle: TextStyle(fontFamily: "Poppins",color: Colors.grey[500]),
          prefixIcon: Icon(FontAwesomeIcons.lock,size: 17,color: Color(0xFF292D3E)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width *0.03)
              ),borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: Colors.green)
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green,width: MediaQuery.of(context).size.width *0.007,)
          ),
        ),
      ),
    ),

          //espace
          SizedBox(height: MediaQuery.of(context).size.height *0.02,),
          //espace

          //Bouton d'inscription
      Container(child: ElevatedButton(onPressed: () async{

          verifiersaisie();
          await envoyerdonnee();
          redirecteur();


      }, child: Text("SE CONNECTER",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),),
      SizedBox(height: MediaQuery.of(context).size.height *0.02,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(color: Colors.black,width: MediaQuery.of(context).size.width *0.35,height: MediaQuery.of(context).size.height *0.002,),
          Text("OU",style: TextStyle(fontFamily: "Poppins",color: Colors.green),),
          Container(color: Colors.black,width: MediaQuery.of(context).size.width *0.35,height: MediaQuery.of(context).size.height *0.002,),

        ],),
      //animation
      Container(child: Lottie.asset("assets/animations/fruit_lance.json",height: MediaQuery.of(context).size.height *0.2,),),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("PAS ENCORE DE COMPTE ?",style: TextStyle(color: Colors.black,fontFamily: "Poppins"),),
          TextButton(onPressed: (){
            //widget de redirection vers la page d'inscription au clic
            Navigator.push(context, MaterialPageRoute(builder: (context)=>InscriptionPage()));
          }, child: Text("S'INSCRIRE",style: TextStyle(color: Colors.green,fontFamily: "Poppins"),))
        ],),
    ])),
    );
  }
}
