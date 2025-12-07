import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackaton_utilisateur/Pages/Drawer.dart';
import 'package:hackaton_utilisateur/Pages/Inscription.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompteModificationPage extends StatefulWidget {
  CompteModificationPage({super.key, required this.identifiant});
var identifiant;
  @override
  State<CompteModificationPage> createState() => _CompteModificationPageState();
}

class _CompteModificationPageState extends State<CompteModificationPage> {

  final nom=TextEditingController();
  final numero=TextEditingController();
  final mot_de_passe=TextEditingController();
  bool bordure_couleur1=true;
  bool bordure_couleur2=true;
  bool bordure_couleur3=true;
  var data;

  Future <void> sauvegarder_numero() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString("numero_utilisateur", numero.text);
    await preferences.setString("nom_utilisateur",nom.text);
  }

  Future <void> envoyerdonnees() async {
    final url = Uri.parse("http://10.0.2.2:8000/verifier_utilisateur");
    var message = await http.post(
        url, headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'numero': numero.text,
        })
    );
    setState(() {
      data=jsonDecode(message.body);
    });
    print(data["existe"]);
  }

  Future <void> modifier_compte() async{
    final url=Uri.parse("http://10.0.2.2:8000/modifier_information");
    var message=await http.post(url,headers: {"Content-Type":"application/json"},
    body: jsonEncode({
      "id_utilisateur":widget.identifiant,
      "nom":nom.text,
      "numero":numero.text,
      "mot_de_passe":mot_de_passe.text
    })

    );
    setState(() {
      data=jsonDecode(message.body);
    });

    print(data);
  }

  void message_erreur_mot_de_passe1(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),backgroundColor: Colors.transparent,content: GestureDetector(
        child: Container(
          height: MediaQuery.of(context).size.height *0.1,
          width: MediaQuery.of(context).size.width *1,
          decoration: BoxDecoration(color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
          ),
          child: ListTile(

            title: Text("ERREUR\nPAS D'ESPACE OU DE VIDE",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
            subtitle: Container(

              child: Text("Saisissz correctement",style: TextStyle(color: Colors.white70,fontFamily: "Poppins"),),),
            leading: Icon(Icons.dangerous,size: MediaQuery.of(context).size.width *0.15,color: Colors.white,),
          ),
        )
    )));
  }
  void utilisateur_existence(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),backgroundColor: Colors.transparent,content: GestureDetector(
        child: Container(
          height: MediaQuery.of(context).size.height *0.1,
          width: MediaQuery.of(context).size.width *1,
          decoration: BoxDecoration(color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
          ),
          child: ListTile(

            title: Text("ERREUR\nUTILISATEUR EXISTE",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
            subtitle: Container(
              child: Text("Numero possédé",style: TextStyle(color: Colors.white70,fontFamily: "Poppins"),),),
            leading: Icon(Icons.warning_amber,size: MediaQuery.of(context).size.width *0.15,color: Colors.white,),
          ),
        )
    )));
  }
  void message_erreur_mot_de_passe2(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),backgroundColor: Colors.transparent,content: GestureDetector(
        child: Container(
          height: MediaQuery.of(context).size.height *0.1,
          width: MediaQuery.of(context).size.width *1,
          decoration: BoxDecoration(color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
          ),
          child: ListTile(

            title: Text("ERREUR \n PROBLEME SUR NUMERO",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
            subtitle: Container(

              child: Text("REESSAYEZ",style: TextStyle(color: Colors.white70,fontFamily: "Poppins"),),),
            leading: Icon(Icons.dangerous,size: MediaQuery.of(context).size.width *0.15,color: Colors.white,),
          ),
        )
    )));
  }
  Future<void> verification_donne() async {
    if(nom.text.isNotEmpty){

      setState(() {
        bordure_couleur1=true;
      });
    }
    if(nom.text.isEmpty||numero.text.isEmpty||numero.text.length!=10){
      message_erreur_mot_de_passe1();
      setState(() {
        bordure_couleur1=false;
      });
    }
    if(numero.text.isEmpty||numero.text.length!=10){

      setState(() {
        bordure_couleur2=false;
      });
    }
    if(numero.text.isNotEmpty && numero.text.length==10 ){
      setState(() {
        bordure_couleur2=true;
      });
    }

    if(mot_de_passe.text.contains(" ")||mot_de_passe.text.isEmpty){
      message_erreur_mot_de_passe2();
      setState(() {
        bordure_couleur3=false;
      });
    }
    if(numero.text.isNotEmpty && !mot_de_passe.text.contains(" ") && mot_de_passe.text.isNotEmpty && nom.text.isNotEmpty && numero.text.length==10){
      setState(() {
        bordure_couleur1=true;
        bordure_couleur2=true;
        bordure_couleur3=true;
      });
await envoyerdonnees();
if(data["existe"]=="true"){
  utilisateur_existence();
}else{
  await modifier_compte();
  sauvegarder_numero();
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>DrawerPage()), (route)=>false);
}

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.04),
              child: Lottie.asset("assets/animations/Recycle.json"),),
            Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.045),
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.04),
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_sharp,size: MediaQuery.of(context).size.width *0.09,color: Colors.black54,)),
                    SizedBox(width: MediaQuery.of(context).size.width *0.21,),
                    Text("modifer",style:TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.07,color: Colors.black54) ,)
                  ],)),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height *0.23,
                left: MediaQuery.of(context).size.width *0.35,),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: MediaQuery.of(context).size.width *0.15,
                child: Icon(Icons.account_circle,size: MediaQuery.of(context).size.width *0.3,color: Colors.green,),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height *0.46,
right: MediaQuery.of(context).size.width *0.22,
              child: Text("Modifier vos \ninformations a tout moment",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.038),),),
            Column(
              children: [
              Container(width: MediaQuery.of(context).size.width *1,),

              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.55),
                  width: MediaQuery.of(context).size.width *0.7,
                  height: MediaQuery.of(context).size.height *0.065,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: TextFormField(
                    controller: nom,
                    cursorColor: Color(0xFF292D3E),
                    decoration: InputDecoration(
                        hintText:"Nom",
                        hintStyle: TextStyle(fontFamily: "Poppins",color: Colors.grey[500]),
                        prefixIcon: Icon(Icons.edit,size: 19,color: Colors.green,),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.03)),
                            borderSide: BorderSide(color: bordure_couleur1?Colors.green:Colors.red,width: MediaQuery.of(context).size.width *0.007,)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(MediaQuery.of(context).size.width *0.03)
                          ), borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: bordure_couleur1?Colors.green:Colors.red),
                        )
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.01),
                  width: MediaQuery.of(context).size.width *0.7,
                  height: MediaQuery.of(context).size.height *0.065,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: numero,
                    cursorColor: Color(0xFF292D3E),
                    decoration: InputDecoration(

                        hintText:"Numero",
                        hintStyle: TextStyle(fontFamily: "Poppins",color: Colors.grey[500]),
                        prefixIcon: Icon(Icons.numbers_outlined,size: 19,color: Colors.green,),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.03)),
                            borderSide: BorderSide(color: bordure_couleur2?Colors.green:Colors.red,width: MediaQuery.of(context).size.width *0.007,)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(MediaQuery.of(context).size.width *0.03)
                          ), borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: bordure_couleur2?Colors.green:Colors.red),
                        )
                    ),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width *0.7,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.01),
                  height: MediaQuery.of(context).size.height *0.065,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: TextFormField(
                    controller: mot_de_passe,
                    cursorColor: Color(0xFF292D3E),
                    decoration: InputDecoration(
                        hintText:"Mot de passe",
                        hintStyle: TextStyle(fontFamily: "Poppins",color: Colors.grey[500]),
                        prefixIcon: Icon(FontAwesomeIcons.lock,size: 19,color: Colors.green,),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.03)),
                            borderSide: BorderSide(color: bordure_couleur3?Colors.green:Colors.red,width: MediaQuery.of(context).size.width *0.007,)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(MediaQuery.of(context).size.width *0.03)
                          ), borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: bordure_couleur3?Colors.green:Colors.red),
                        ),


                    ),
                  )),
              GestureDetector(
onTap: (){
  verification_donne();
  },
                child:
              Container(
                alignment: AlignmentGeometry.center,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.05),
                width: MediaQuery.of(context).size.width *0.5,
                height: MediaQuery.of(context).size.height *0.06,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1))
                ),
child: Text("VALIDER",style: TextStyle(color: Colors.white,fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.06),),
              ),)
            ],)
        ],),
      ),
    );
  }
}
