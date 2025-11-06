import 'package:flutter/material.dart';
import 'Inscription.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final Numero=TextEditingController();
  final Motdepasse=TextEditingController();
  bool bourdurecouleur1=true;

void verifiersaisie(){
  if(Numero.text.trim().length<10 || Motdepasse.text.trim().length>10){
    setState(() {
      bourdurecouleur1=false;
    });
  }else{
    setState(() {
      bourdurecouleur1=true;
    });
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
        height: 50,
        padding: EdgeInsets.only(left: 10,right: 10),
        child: TextFormField(
          controller: Numero,
          cursorColor: Color(0xFF292D3E),
          decoration: InputDecoration(
              hintText:"Numero",
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

      ),SizedBox(height: MediaQuery.of(context).size.height *0.02,),Container(
      width: MediaQuery.of(context).size.width *0.7,
      height: 50,
      padding: EdgeInsets.only(left: 10,right: 10),
//Pour la saisie du numero
      child: TextFormField(
        cursorColor: Color(0xFF292D3E),
        decoration: InputDecoration(
          hintText: "Mot de passe",
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
    ),SizedBox(height: MediaQuery.of(context).size.height *0.02,),
      //Bouton d'inscription
      Container(child: ElevatedButton(onPressed: (){

          verifiersaisie();


      }, child: Text("SE CONNECTER",style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),),
      SizedBox(height: MediaQuery.of(context).size.height *0.02,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(color: Color(0xFF292D3E),width: 150,height: 2,),
          Text("OU",style: TextStyle(color: Color(0xFF292D3E)),),
          Container(color: Color(0xFF292D3E),width: 150,height: 2,),
        ],),
      //animation
      Container(child: Lottie.asset("assets/animations/fruit_lance.json",height: MediaQuery.of(context).size.height *0.2,),),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("PAS ENCORE DE COMPTE ?",style: TextStyle(color: Color(0xFF292D3E)),),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>InscriptionPage()));
          }, child: Text("S'INSCRIRE",style: TextStyle(color: Colors.green),))
        ],),
    ])),
    );
  }
}
