import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackaton_utilisateur/Pages/Inscription.dart';
import 'package:hackaton_utilisateur/Pages/Redirecteur.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class CreationComptePage extends StatefulWidget {
  var numero;
  var nom_complet;

  CreationComptePage({required this.numero, required this.nom_complet});
  @override
  State<CreationComptePage> createState() => _CreationComptePageState();
}

class _CreationComptePageState extends State<CreationComptePage> {
  final mot_de_passe0=TextEditingController();
  final mot_de_passe=TextEditingController();
  bool ecriture_valeur=true;
  bool apparaitre=true;
  bool couleurbordure1=true;
  bool couleurborder2=true;
  var data;
  Future <void> envoyerdonnees() async{
    final url=Uri.parse("http://10.0.2.2:8000/ajouter_utilisateur");
    var message=await http.post(url,headers: {'Content-Type':'application/json'},
    body: jsonEncode({
      'nom':nom_complet.text,
      'numero':numero.text,
      'mot_de_passe':mot_de_passe.text
    })
    );
    setState(() {
      data=jsonDecode(message.body);
    });
    print(data["utilisateur"]);
    print(nom_complet.text);
  }
  Future <void> sauvegarder() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setBool("rediriger", true);

  }
  Future <void> sauvegarder_numero() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString("numero_utilisateur", numero.text);

  }
  void messagecode1(){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 1200),backgroundColor: Colors.transparent,content: Container(
    height: MediaQuery.of(context).size.height *0.11,
decoration: BoxDecoration(
  color: Colors.green,
  borderRadius:BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
),
    child: ListTile(leading:Icon(Icons.not_interested_outlined,size: MediaQuery.of(context).size.width *0.13,color: Colors.red[300],),title: Text("LE MOT DE PASSE DOIT ETRE SUPERIEUR OU EGALE A 5",style: TextStyle(color: Colors.white,fontFamily: "Poppins2"),),
      subtitle: Container(decoration:BoxDecoration(color:Colors.white,border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width *0.02)),margin:EdgeInsets.only(top: MediaQuery.of(context).size.height *0.01),child: Text("Saisissez a nouveau",textAlign: TextAlign.center,style: TextStyle(color: Colors.green,fontFamily: "Poppins2"),),), ),),
  ));
  }
  void messagecode2(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 1200),backgroundColor: Colors.transparent,content: Container(
      height: MediaQuery.of(context).size.height *0.11,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius:BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
      ),
      child: ListTile(leading:Icon(Icons.not_interested_outlined,size: MediaQuery.of(context).size.width *0.13,color: Colors.red[300],),title: Text("LES CHAMPS DE DOIT PAS ETRE VIDE",style: TextStyle(color: Colors.white,fontFamily: "Poppins2"),),
        subtitle: Container(decoration:BoxDecoration(color:Colors.white,border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width *0.02)),margin:EdgeInsets.only(top: MediaQuery.of(context).size.height *0.01),child: Text("Saisissez a nouveau",textAlign: TextAlign.center,style: TextStyle(color: Colors.green,fontFamily: "Poppins2"),),), ),),
    ));
  }

  void messagecode3(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 1200),backgroundColor: Colors.transparent,content: Container(
      height: MediaQuery.of(context).size.height *0.11,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius:BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
      ),
      child: ListTile(leading:Icon(Icons.not_interested_outlined,size: MediaQuery.of(context).size.width *0.13,color: Colors.red[300],),title: Text("LE MOT DE PASSE NE DOIT PAS CONTENIR D'ESPACE",style: TextStyle(color: Colors.white,fontFamily: "Poppins2"),),
        subtitle: Container(decoration:BoxDecoration(color:Colors.white,border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width *0.02)),margin:EdgeInsets.only(top: MediaQuery.of(context).size.height *0.01),child: Text("Saisissez a nouveau",textAlign: TextAlign.center,style: TextStyle(color: Colors.green,fontFamily: "Poppins2"),),), ),),
    ));
  }
  void messagecode4(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 1200),backgroundColor: Colors.transparent,content: Container(
      height: MediaQuery.of(context).size.height *0.11,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius:BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
      ),
      child: ListTile(leading:Icon(Icons.not_interested_outlined,size: MediaQuery.of(context).size.width *0.13,color: Colors.red[300],),title: Text("VERIFIEZ LE MOT DE PASSE ",style: TextStyle(color: Colors.white,fontFamily: "Poppins2"),),
        subtitle: Container(decoration:BoxDecoration(color:Colors.white,border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width *0.02)),margin:EdgeInsets.only(top: MediaQuery.of(context).size.height *0.01),child: Text("Saisissez a correctement",textAlign: TextAlign.center,style: TextStyle(color: Colors.green,fontFamily: "Poppins2"),),), ),),
    ));
  }
@override
void dispose(){
    mot_de_passe.dispose();
    mot_de_passe0.dispose();
    super.dispose();
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Stack(
              children: [

                Column(
                  children: [

                    Container(width: MediaQuery.of(context).size.width *1,),
//Image de fond
                    Container(
                      child: Image.asset("assets/images/image_equipe.png",height: MediaQuery.of(context).size.height *0.4,width: MediaQuery.of(context).size.width *1,),
                    ),
                    Container(
                       alignment: AlignmentGeometry.center,
                        child: Column(children: [
                          Text("VEUILLEZ SAISIR \nVOTRE MOT DE PASSE\nPOUR LE NUMERO",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Poppins"),),
                          TextButton(onPressed: (){setState(() {
                            ecriture_valeur=!ecriture_valeur;
                          });}, child:ecriture_valeur?Text("##########",style: TextStyle(fontFamily: "Poppins",color: Colors.green),):Text(numero.text,style: TextStyle(fontFamily: "Poppins",color: Colors.green)))
                        ],),),SizedBox(height: MediaQuery.of(context).size.height *0.02,),
                    Container(
                        width: MediaQuery.of(context).size.width *0.7,
                        height: MediaQuery.of(context).size.height *0.065,
                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: TextFormField(
                          controller: mot_de_passe0 ,
                          style: TextStyle(fontFamily: "Poppins"),
                          cursorColor: Color(0xFF292D3E),
                          decoration: InputDecoration(
                              hintText:"Mot de passe",
                              hintStyle: TextStyle(fontFamily: "Poppins",color: Colors.grey[500]),
                              prefixIcon: Icon(FontAwesomeIcons.lock,size: 19,color: Color(0xFF292D3E),),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(MediaQuery.of(context).size.width *0.03)
                                ),
                                  borderSide: BorderSide(color: Colors.green,width: MediaQuery.of(context).size.width *0.007,)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(MediaQuery.of(context).size.width *0.03)
                                ), borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: Colors.green),
                              )
                          ),
                        )),
                    SizedBox(height: MediaQuery.of(context).size.height *0.02,),
                    Container(
                        width: MediaQuery.of(context).size.width *0.7,
                        height: MediaQuery.of(context).size.height *0.065,
                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: TextFormField(
                          controller: mot_de_passe,
                          obscureText: apparaitre,
                          style: TextStyle(fontFamily: "Poppins"),
                          cursorColor: Color(0xFF292D3E),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(onPressed: (){
                              setState(() {
                                apparaitre=!apparaitre;
                              });
                            }, icon: apparaitre?Icon(CupertinoIcons.eye_solid):Icon(CupertinoIcons.eye_slash)),
                              hintText:"Seconde saisie",
                              hintStyle: TextStyle(fontFamily: "Poppins",color: Colors.grey[500]),
                              prefixIcon: Icon(FontAwesomeIcons.lock,size: 19,color: Color(0xFF292D3E),),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(MediaQuery.of(context).size.width *0.03)
                                ),
                                  borderSide: BorderSide(color: couleurborder2?Colors.green:Colors.red,width: MediaQuery.of(context).size.width *0.007,)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(MediaQuery.of(context).size.width *0.03)
                                ), borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: couleurborder2?Colors.green:Colors.red),
                              )
                          ),
                        )),
//Bouton d'inscription
                    SizedBox(height: MediaQuery.of(context).size.height *0.04,),
                    Container(child: ElevatedButton(onPressed: () async{
                      if(mot_de_passe0.text.trim().length<5){
                        setState(() {
                          couleurbordure1=false;
                        });
                        messagecode1();

                      }
                      if(mot_de_passe0.text.trim().isEmpty){
                          setState(() {
                            couleurbordure1=false;
                          });
                          messagecode2();

                      }
                      if(mot_de_passe0.text.contains(" ")){
                        messagecode3();

                      }
                      if(mot_de_passe.text!=mot_de_passe0.text || mot_de_passe.text.isEmpty ){
                        setState(() {
                          couleurborder2=false;
                        });

                      }
                      if(mot_de_passe.text!=mot_de_passe0.text){
                        messagecode4();

                      }
                      if(mot_de_passe.text==mot_de_passe0.text && mot_de_passe0.text.length>=5){
await envoyerdonnees();
if(data["utilisateur"]=="utilisateur ajouté"){
  await sauvegarder();
  await sauvegarder_numero();
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>RedirecteurPage()), (route)=>false);
}



                      }
                    }, child: Text("VERIFICATION",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),),
                    SizedBox(height: MediaQuery.of(context).size.height *0.04,),
                  ],
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height *0.09,
                    left: MediaQuery.of(context).size.width *0.06,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1)),
                            border: Border.all(color: Colors.black)
                        ),
                        child: CircleAvatar(backgroundColor: Colors.white,radius: MediaQuery.of(context).size.width *0.05,child: IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back,color: Colors.green,size: MediaQuery.of(context).size.width *0.05 ,),style: ElevatedButton.styleFrom(backgroundColor: Colors.white),),))
                ),
              ],
            )));

  }
}
