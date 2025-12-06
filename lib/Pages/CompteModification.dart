import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackaton_utilisateur/Pages/Inscription.dart';
import 'package:lottie/lottie.dart';

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
  void message_erreur_mot_de_passe1(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),backgroundColor: Colors.transparent,content: GestureDetector(
        child: Container(
          height: MediaQuery.of(context).size.height *0.1,
          width: MediaQuery.of(context).size.width *1,
          decoration: BoxDecoration(color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
          ),
          child: ListTile(

            title: Text("ERREUR \nVERIFIEZ LES CHAMPS",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
            subtitle: Container(

              child: Text("REESSAYEZ",style: TextStyle(color: Colors.white70,fontFamily: "Poppins"),),),
            leading: Icon(Icons.dangerous,size: MediaQuery.of(context).size.width *0.15,color: Colors.white,),
          ),
        )
    )));
  }void message_erreur_mot_de_passe2(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),backgroundColor: Colors.transparent,content: GestureDetector(
        child: Container(
          height: MediaQuery.of(context).size.height *0.1,
          width: MediaQuery.of(context).size.width *1,
          decoration: BoxDecoration(color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
          ),
          child: ListTile(

            title: Text("ERREUR \nLE CHAMPS EST VIDE OU CONTIENT UN ESPACE",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
            subtitle: Container(

              child: Text("REESSAYEZ",style: TextStyle(color: Colors.white70,fontFamily: "Poppins"),),),
            leading: Icon(Icons.dangerous,size: MediaQuery.of(context).size.width *0.15,color: Colors.white,),
          ),
        )
    )));
  }
  void verification_donne(){
    if(nom.text.isNotEmpty){
      message_erreur_mot_de_passe1();
      setState(() {
        bordure_couleur1=true;
      });
    }
    if(nom.text.isEmpty){
      message_erreur_mot_de_passe1();
      setState(() {
        bordure_couleur1=false;
      });
    }
    if(numero.text.isEmpty){
      message_erreur_mot_de_passe1();
      setState(() {
        bordure_couleur2=false;
      });
    }
    if(numero.text.isNotEmpty){
      message_erreur_mot_de_passe1();
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
    if(numero.text.isNotEmpty && !mot_de_passe.text.contains(" ") && mot_de_passe.text.isNotEmpty && nom.text.isNotEmpty){
      setState(() {
        bordure_couleur1=true;
        bordure_couleur2=true;
        bordure_couleur3=true;
      });

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
                            borderSide: BorderSide(color: Colors.green,width: MediaQuery.of(context).size.width *0.007,)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(MediaQuery.of(context).size.width *0.03)
                          ), borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: Colors.green),
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
                            borderSide: BorderSide(color: Colors.green,width: MediaQuery.of(context).size.width *0.007,)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(MediaQuery.of(context).size.width *0.03)
                          ), borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: Colors.green),
                        ),


                    ),
                  )),
              GestureDetector(
onTap: (){verification_donne();},
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
