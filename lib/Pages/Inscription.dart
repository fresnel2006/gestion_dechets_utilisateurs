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
    final url = Uri.parse("http://192.168.1.7:8000/verifier_utilisateur");
    var message = await http.post(
        url, headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'numero': numero.text,
        })
    );
     data=jsonDecode(message.body);
    print(data["existe"]);
  }
  //message disant a l'utilisateur qu'il s'est deja connecté
  void messagecode1(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 1200),backgroundColor: Colors.transparent,content: Container(
      height: MediaQuery.of(context).size.height *0.11,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius:BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
      ),
      child: ListTile(leading:Icon(Icons.check_circle_outline,size: MediaQuery.of(context).size.width *0.13,color: Colors.white,),title: Text("UTILISATEUR EXISTE",style: TextStyle(color: Colors.white,fontFamily: "Poppins2"),),
        subtitle: Container(margin:EdgeInsets.only(top: MediaQuery.of(context).size.height *0.02),decoration:BoxDecoration(color:Colors.white,border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width *0.02)),child: Text("REDIRECTION",textAlign: TextAlign.center,style: TextStyle(color: Colors.green,fontFamily: "Poppins2"),),), ),),
    ));
  }
  //fonction affichant un message dissant que l'utilisateur a rentré les donnees correctement et lui demande d'etre veridique
  void messagenotifier(){
    showModalBottomSheet(context: context, builder: (context)=>Container(
      height: MediaQuery.of(context).size.height *0.4,
      width: MediaQuery.of(context).size.width *1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width *0.06),topRight: Radius.circular(MediaQuery.of(context).size.width *0.06))
      ),
child: SingleChildScrollView(child: Column(children: [
  SizedBox(height: MediaQuery.of(context).size.height *0.02,),
  Icon(Icons.warning_amber_outlined,size: MediaQuery.of(context).size.width *0.1,color: Colors.red[200],),
  SizedBox(height: MediaQuery.of(context).size.height *0.01,),
  Text("ATTENTION !",textAlign: TextAlign.center,style: TextStyle(fontSize: MediaQuery.of(context).size.width *0.06,fontFamily: "Poppins2",color: Colors.red[200]),),
  SizedBox(height: MediaQuery.of(context).size.height *0.02,),
  Container(
    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.03,right: MediaQuery.of(context).size.width *0.03),
    child: Text("Veuillez vérifier attentivement votre numéro \nde téléphone.Il sera utilisé \npour les opérations de vérification, \net les communications liées \nà votre compte.",textAlign: TextAlign.center,style: TextStyle(fontSize:15,color: Colors.green,fontFamily: "Poppins2"),)
    ,),
  SizedBox(height: MediaQuery.of(context).size.height *0.02),
  Container(
    child: ElevatedButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CreationComptePage(numero: numero.text,nom_complet:nom_complet.text)));
    }, child: Text("VALIDER",style: TextStyle(color: Colors.white,fontFamily: "Poppins2"),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green,),)
    ,)
  ],),
    )));
  }
//fonction de verification de la saisie des valeurs
  void verifie_valeur_et_validation() async {
    //couleur rouge de la bordure de l'input de saisie nom si la saisie est vide
    if(nom_complet.text.isEmpty || nom_complet.text.trim().isEmpty){
      setState(() {
        couleurbordure1=false;
      });
    }
    //couleur rouge de la bordure de l'input de saisie du numero si c'est inferieur a 10 ou vide
    if(numero.text.trim().isEmpty||numero.text.trim().length!=10){
      setState(() {
        couleurbordure2=false;
      });
    }
    //couleur verte de la bordure de l'input de saisie si la saisie du nom est correct
    if(nom_complet.text.trim().isNotEmpty){
      setState(() {
        couleurbordure1=true;
      });
    }
    //couleur verte de la bourdure de l'input de saisie si le nom est n'est pas vide et correctement saisie c'est a dire 10 chiffres
    if(numero.text.isNotEmpty && numero.text.trim().isNotEmpty && numero.text.trim().length==10){
      setState(() {
        couleurbordure2=true;
      });
    }
    //les conditions de redirection
    //Si le nom n'est pas vide et bien saisie
    if(nom_complet.text.trim().isNotEmpty && numero.text.trim().length==10){
      //On appelle la fonction qui est chargee de verifier les donnees et renvoie une valeur
      await envoyerdonnees();
      //Si l'utilisateur existe sa redirige ver la page de connexion
      if(data["existe"]=="true"){
        //message disant que l'utilisateur est revenu
        messagecode1();
        //widget de redirection
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ConnexionPage()));
      }
      //Si l'utilisateur n'existe pas on redirige vers la page de creation de compte
      if(data["existe"]=="false"){
        //notifie un messsage et le redirige vers la page de creation de compte
        messagenotifier();
      }
    }
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
                  height: MediaQuery.of(context).size.height *0.065,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: TextFormField(
                    controller: nom_complet,
                    style: TextStyle(fontFamily: "Poppins"),
                    cursorColor: Color(0xFF292D3E),
                    decoration: InputDecoration(
                      hintText:"Nom complet",
                      hintStyle: TextStyle(fontFamily: "Poppins",color: Colors.grey[500]),
                      prefixIcon: Icon(FontAwesomeIcons.leaf,size: 19,color: Color(0xFF292D3E),),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(MediaQuery.of(context).size.width *0.03)
                        ),
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
            //espace vertical
            SizedBox(height: MediaQuery.of(context).size.height *0.02,),
              //espace vertical

              //contenaire de saisie du numero
              Container(
                width: MediaQuery.of(context).size.width *0.7,
                height: MediaQuery.of(context).size.height *0.065,
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
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(MediaQuery.of(context).size.width *0.03)
                      ),
                        borderSide: BorderSide(color: couleurbordure2!=false?Colors.green:Colors.red,width: MediaQuery.of(context).size.width *0.007,)
                    ),
                  ),
                ),
              )
              //espace vertical
            ,SizedBox(height: MediaQuery.of(context).size.height *0.03,),
              //espace vertical

              //Bouton d'inscription
            Container(child: ElevatedButton(onPressed: (){
              verifie_valeur_et_validation();
            },child: Text("S'INSCRIRE",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),),
            SizedBox(height: MediaQuery.of(context).size.height *0.02,),
            //le widget contenant les contenaires et le texte de la ligne
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Container(color: Colors.black,width: MediaQuery.of(context).size.width *0.35,height: MediaQuery.of(context).size.height *0.002,),
              Text("OU",style: TextStyle(fontFamily: "Poppins",color: Colors.green),),
              Container(color: Colors.black,width: MediaQuery.of(context).size.width *0.35,height: MediaQuery.of(context).size.height *0.002),
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
