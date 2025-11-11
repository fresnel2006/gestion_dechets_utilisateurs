import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackaton_utilisateur/Pages/Connexion.dart';
import 'package:hackaton_utilisateur/Pages/CreationCompte.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

    //Variables permettant le controle de la saisie des donnees

    final nom_complet = TextEditingController();
    final numero = TextEditingController();
    bool couleurbordure1=true;
    bool couleurbordure2=true;

class _InscriptionPageState extends State<InscriptionPage> {
  //les variables de chargement des donnees
  var data;
  //fonction pour envoyer les donnees vers fastapi qui se chargera d'envoyer vers la base de donnée
  Future <void> envoyerdonnees() async {
    final url = Uri.parse("http://10.0.2.2:8000/verifier_utilisateur");
    var message = await http.post(
        url, headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'numero': numero.text,
        })
    );
     data=jsonDecode(message.body);
    print(data["existe"]);
  }
  void messagenotifier(){
    showModalBottomSheet(context: context, builder: (context)=>Container(
      height: MediaQuery.of(context).size.height *0.35,
      width: MediaQuery.of(context).size.width *1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width *0.06),topRight: Radius.circular(MediaQuery.of(context).size.width *0.06))
      ),
child: Column(children: [
  SizedBox(height: MediaQuery.of(context).size.height *0.02,),
  Text("ATTENTION !",textAlign: TextAlign.center,style: TextStyle(fontSize: MediaQuery.of(context).size.width *0.07,fontFamily: "Poppins2",color: Colors.red[200]),),
  SizedBox(height: MediaQuery.of(context).size.height *0.02,),
  Container(
    padding: EdgeInsets.only(left: 13,right: 13),
    child: Text("Veuillez vérifier attentivement votre numéro de téléphone.Il sera utilisé pour les opérations de vérification, \net les communications liées à votre compte.",textAlign: TextAlign.center,style: TextStyle(fontSize:15,color: Colors.green,fontFamily: "Poppins2"),)
    ,),
  SizedBox(height: MediaQuery.of(context).size.height *0.02),
  Container(
    child: ElevatedButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CreationComptePage(numero: numero.text,nom_complet:nom_complet.text)));

    }, child: Text("VALIDER",style: TextStyle(color: Colors.white,fontFamily: "Poppins2"),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green,),)
    ,)
  ],),
    ));
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      //Couleur de fond
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
          //Pour aligner verticalement les elements
          child: Column(
            children: [
              //Pour permettre de centrer les elements
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
                    controller: nom_complet,
                    style: TextStyle(fontFamily: "Poppins"),
                    cursorColor: Color(0xFF292D3E),
                    decoration: InputDecoration(
                      hintText:"Nom complet",
                      hintStyle: TextStyle(fontFamily: "Poppins",color: Colors.grey[500]),
                      prefixIcon: Icon(FontAwesomeIcons.leaf,size: 19,color: Color(0xFF292D3E),),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: couleurbordure1!=false?Colors.green:Colors.red,width: MediaQuery.of(context).size.width *0.007,)
                        ),
                      enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(MediaQuery.of(context).size.width *0.03)
                      ), borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: couleurbordure1?Colors.green:Colors.red),
                      )
                    ),
                  ),
                ),
            //Pour l'input de la saisie du Nom
            SizedBox(height: MediaQuery.of(context).size.height *0.02,),
              Container(
                width: MediaQuery.of(context).size.width *0.7,
                height: 50,
                padding: EdgeInsets.only(left: 10,right: 10),
                  //Pour la saisie du numero
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: numero,
                  style: TextStyle(fontFamily: "Poppins"),
                  cursorColor: Color(0xFF292D3E),
                  decoration: InputDecoration(
                    hintText: "Numero",
                    hintStyle: TextStyle(fontFamily: "Poppins",color: Colors.grey[500]),
                    prefixIcon: Icon(FontAwesomeIcons.hashtag,size: 17,color: Color(0xFF292D3E)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(MediaQuery.of(context).size.width *0.03)
                        ),borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: couleurbordure2?Colors.green:Colors.red)
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: couleurbordure2!=false?Colors.green:Colors.red,width: MediaQuery.of(context).size.width *0.007,)
                    ),
                  ),
                ),
              )
            ,SizedBox(height: MediaQuery.of(context).size.height *0.03,),
            //Bouton d'inscription
            Container(child: ElevatedButton(onPressed: () async{

              print(nom_complet.text);
              print(numero.text);
              print(numero.text.length);
              if(nom_complet.text.isEmpty || nom_complet.text.trim().isEmpty){
                  setState(() {
                    couleurbordure1=false;
                  });
              }
              if(numero.text.trim().isEmpty||numero.text.trim().length!=10){
                  setState(() {
                    couleurbordure2=false;
                  });
              }
              if(nom_complet.text.trim().isNotEmpty){
                setState(() {
                  couleurbordure1=true;
                });
              }
              if(numero.text.isNotEmpty && numero.text.trim().isNotEmpty && numero.text.trim().length==10){
                setState(() {
                  couleurbordure2=true;
                });
              }
if(nom_complet.text.trim().isNotEmpty && numero.text.trim().length==10){
  await envoyerdonnees();

  if(data["existe"]=="true"){

    Navigator.push(context, MaterialPageRoute(builder: (context)=>ConnexionPage()));
  }if(data["existe"]=="false"){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>CreationComptePage(numero: numero, nom_complet: nom_complet)));
  }
  }
            },child: Text("S'INSCRIRE",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),),
            SizedBox(height: MediaQuery.of(context).size.height *0.02,),
            //le widget contenant les contenaires et le texte de la ligne
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Container(color: Color(0xFF292D3E),width: 150,height: 2,),
              Text("OU",style: TextStyle(fontFamily: "Poppins",color: Color(0xFF292D3E)),),
              Container(color: Color(0xFF292D3E),width: 150,height: 2,),
            ],),
            //animation
            Container(child: Lottie.asset("assets/animations/fruit_lance.json",height: MediaQuery.of(context).size.height *0.2,),),
            //le widget contenant des le boutons et les textes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("DEJA UN COMPTE ?",style: TextStyle(fontFamily: "Poppins",color: Color(0xFF292D3E)),),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ConnexionPage()));
              }, child: Text("SE CONNECTER",style: TextStyle(fontFamily: "Poppins",color: Colors.green),))
            ],)
        ],),
      ),
    );
  }
}
