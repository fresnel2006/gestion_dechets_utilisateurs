import 'dart:convert';
import 'dart:ffi';
import 'package:hackaton_utilisateur/Pages/Acceuil.dart';
import 'package:hackaton_utilisateur/Pages/CompteModification.dart';
import 'package:hackaton_utilisateur/Pages/Drawer.dart';
import 'package:hackaton_utilisateur/Pages/Redirecteur.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComptePage extends StatefulWidget {
  const ComptePage({super.key});

  @override
  State<ComptePage> createState() => _ComptePageState();
}

class _ComptePageState extends State<ComptePage> {
  var numero;
  var nom;
  var mot_de_passe;
  var information;
  final verificateur=TextEditingController();
  Future <void> sauvegarder() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setBool("rediriger", false);

  }
  void message_erreur_mot_de_passe(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),backgroundColor: Colors.transparent,content: GestureDetector(
        child: Container(
          height: MediaQuery.of(context).size.height *0.1,
          width: MediaQuery.of(context).size.width *1,
          decoration: BoxDecoration(color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
          ),
          child: ListTile(

            title: Text("MOTE DE PASSE INCORRECT",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
            subtitle: Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.01),
              child: Text("REESSAYEZ",style: TextStyle(color: Colors.white70,fontFamily: "Poppins"),),),
            leading: Icon(Icons.dangerous,size: MediaQuery.of(context).size.width *0.15,color: Colors.white,),
          ),
        )
    )));
  }
  Future <void> restaurer_donnee() async {
    var perfs = await SharedPreferences.getInstance();
    setState(() {
      numero = perfs.getString("numero_utilisateur");
      nom = perfs.getString("nom_utilisateur");
    });
    print(numero);
    print(nom);

  }
  Future <void> information_utilisateur() async {
    final url=Uri.parse("http://10.0.2.2:8000/afficher_donnee_utilisateur");
    var message= await http.post(url,headers: {"Content-Type":"application/json"},
    body: jsonEncode({
      "numero":numero
    })
    );
    information=jsonDecode(message.body);
    print(information["resultat"][0][3]);

  }

  Future <void> verifier_mot_de_passe() async{
    showModalBottomSheet(backgroundColor:Colors.transparent,context: context, builder: (context)=>SingleChildScrollView(child:Container(height: MediaQuery.of(context).size.height *0.6,width: MediaQuery.of(context).size.width *1,decoration: BoxDecoration(color: Colors.white,border: Border(top: BorderSide(color: Colors.green,width: MediaQuery.of(context).size.width *0.05)),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width *0.6),topRight: Radius.circular(MediaQuery.of(context).size.width *0.6)),
      
    ),child: Column(
      children: [
        Container(width: MediaQuery.of(context).size.width *1,),
        SizedBox(height: MediaQuery.of(context).size.height *0.06,),
      Lottie.asset("assets/animations/Warning animation.json"),
        SizedBox(height: MediaQuery.of(context).size.height *0.04,),
        Container(child: Text("Saisissez votre \nmot de passe actuel : ",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.05),),),
        SizedBox(height: MediaQuery.of(context).size.height *0.04,),
        Container(
          height: MediaQuery.of(context).size.height *0.07,
          width: MediaQuery.of(context).size.width *0.7,
          child: TextFormField(
            controller: verificateur,
            decoration: InputDecoration(
              hintText: "Mot de passe",
              hintStyle: TextStyle(fontFamily: "Poppins",color: Colors.black38),
              prefixIcon: Icon(Icons.lock),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.065))
          ),
           focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.065))
           )
        ),),),
        SizedBox(height: MediaQuery.of(context).size.height *0.04,),
        Container(

          child: ElevatedButton(onPressed: (){
if(verificateur.text!=information["resultat"][0][3]){
  verificateur.clear();
  Navigator.pop(context);
  message_erreur_mot_de_passe();
}else{
  verificateur.clear();
  Navigator.push(context, MaterialPageRoute(builder: (context)=>CompteModificationPage(identifiant:information["resultat"][0][0])));
}
          }, child: Text("Verifier",style: TextStyle(fontFamily:"Poppins",color: Colors.white,fontSize: MediaQuery.of(context).size.width *0.05),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),)
    ],
    ),)));
  }
  Future <void> verifier_mot_de_passe_deconnexion() async{
    showModalBottomSheet(backgroundColor:Colors.transparent,context: context, builder: (context)=>SingleChildScrollView(child:Container(height: MediaQuery.of(context).size.height *0.6,width: MediaQuery.of(context).size.width *1,decoration: BoxDecoration(color: Colors.white,border: Border(top: BorderSide(color: Colors.green,width: MediaQuery.of(context).size.width *0.05)),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width *0.6),topRight: Radius.circular(MediaQuery.of(context).size.width *0.6)),

    ),child: Column(
      children: [
        Container(width: MediaQuery.of(context).size.width *1,),
        SizedBox(height: MediaQuery.of(context).size.height *0.06,),
        Lottie.asset("assets/animations/Warning animation.json"),
        SizedBox(height: MediaQuery.of(context).size.height *0.04,),
        Container(child: Text("Saisissez votre \nmot de passe actuel : ",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.05),),),
        SizedBox(height: MediaQuery.of(context).size.height *0.04,),
        Container(
          height: MediaQuery.of(context).size.height *0.07,
          width: MediaQuery.of(context).size.width *0.7,
          child: TextFormField(
            controller: verificateur,
            decoration: InputDecoration(
                hintText: "Mot de passe",
                hintStyle: TextStyle(fontFamily: "Poppins",color: Colors.black38),
                prefixIcon: Icon(Icons.lock),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.065))
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.065))
                )
            ),),),
        SizedBox(height: MediaQuery.of(context).size.height *0.04,),
        Container(

          child: ElevatedButton(onPressed: (){
            if(verificateur.text==information["resultat"][0][3]){
              verificateur.clear();
              sauvegarder();
              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>RedirecteurPage()), (route)=>false);


            }else{
              verificateur.clear();
              Navigator.pop(context);
              message_erreur_mot_de_passe();
              }
          }, child: Text("Verifier",style: TextStyle(fontFamily:"Poppins",color: Colors.white,fontSize: MediaQuery.of(context).size.width *0.05),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),)
      ],
    ),)));
  }
@override
void initState(){
    super.initState();
    restaurer_donnee();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            //le widget contenant l'animation et le contenaire avec un background vert ansi que le radius
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: MediaQuery.of(context).size.width *1),
                Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.055,bottom: MediaQuery.of(context).size.height *0.019),
                  decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(MediaQuery.of(context).size.width *1,),bottomRight:  Radius.circular(MediaQuery.of(context).size.width *1)),
                    color: Colors.green[300],
                      border: Border(bottom: BorderSide(width: MediaQuery.of(context).size.width *0.006,color: Colors.black26))
                      ),
                child: Lottie.asset("assets/animations/Walking Pothos.json",
                    height: MediaQuery.of(context).size.height *0.25,
                    width: MediaQuery.of(context).size.width *1),
              )
                ],
            ),
            //l'icone vers le milieu
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height *0.24,
                left: MediaQuery.of(context).size.width *0.35,),

              child: CircleAvatar(
              backgroundColor: Colors.white,
                radius: MediaQuery.of(context).size.width *0.15,
                child: Icon(Icons.account_circle,size: MediaQuery.of(context).size.width *0.3,color: Colors.green,),
              ),
            ),
//le mot "profile" et l'icone de la fleche
            Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.045),
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.04),
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_sharp,size: MediaQuery.of(context).size.width *0.09,color: Colors.black54,)),
                    SizedBox(width: MediaQuery.of(context).size.width *0.21,),
                    Text("profile",style:TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.07,color: Colors.black54) ,)
                  ],)),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.9),
              height: MediaQuery.of(context).size.height *0.1,
              width: MediaQuery.of(context).size.width *1,
              decoration: BoxDecoration(color: Colors.green[200],
              border: Border(top: BorderSide(width: MediaQuery.of(context).size.width *0.006,color: Colors.black26)),
              borderRadius: BorderRadius.only(topRight: Radius.circular(MediaQuery.of(context).size.width *1),topLeft: Radius.circular(MediaQuery.of(context).size.width *1))
              ),
              child: TextButton(onPressed: (){
verifier_mot_de_passe_deconnexion();
              }, child: Text("DECONNEXION",style: TextStyle(fontFamily: "Poppins2",color: Colors.white,fontSize: MediaQuery.of(context).size.width *0.04),)),
            ),
            //ici commence les inputs mais avanat faut les placer
            Column(
              children: [
                Container(width: MediaQuery.of(context).size.width *1,),
              Container(
                width: MediaQuery.of(context).size.width *0.7,
                height: MediaQuery.of(context).size.height *0.065,
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.07),
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.45),
                decoration: BoxDecoration(

                    border: Border.all(
                      width: MediaQuery.of(context).size.width *0.007,
                    color: Colors.green.shade200,

                ),borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1))),
                child: Row(
                  children: [
Icon(Icons.edit,color: Colors.green,),
                    SizedBox(width: MediaQuery.of(context).size.width *0.04,),
                    Text(nom??"vide",style: TextStyle(fontFamily: "Poppins"),)


                ],),),
                Container(
                  width: MediaQuery.of(context).size.width *0.7,
                  height: MediaQuery.of(context).size.height *0.065,
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.07),
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.04),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: MediaQuery.of(context).size.width *0.007,
                          color: Colors.green.shade200
                      ),borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1))),
                  child: Row(children: [
                    Icon(Icons.numbers_rounded,color: Colors.green,),
                    SizedBox(width: MediaQuery.of(context).size.width *0.05,),
                    Text(numero??"########",style: TextStyle(fontFamily: "Poppins"))

                  ],),),
                Container(
                  width: MediaQuery.of(context).size.width *0.7,
                  height: MediaQuery.of(context).size.height *0.065,
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.07),

                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.04),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: MediaQuery.of(context).size.width *0.007,
                          color: Colors.green.shade200
                      ),borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1))),
                  child: Row(
                    children: [
                      Icon(Icons.lock,color: Colors.green,),
                      SizedBox(width: MediaQuery.of(context).size.width *0.04,),
                      Text("####",style: TextStyle(fontFamily: "Poppins"))
                  ],),),
                GestureDetector(
                    onTap: () async{
                      await information_utilisateur();
                     verifier_mot_de_passe();
                      },
                    child: Container(
                  alignment: AlignmentGeometry.center,
                  width: MediaQuery.of(context).size.width *0.8,
                  height: MediaQuery.of(context).size.height *0.07,
                  decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.black54) ),color: Colors.green.shade300,borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1))),
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.08),
                  child: Text("MODIFIER",style: TextStyle(color: Colors.white,fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.07),)))],)


        ],),
      ),
    );
  }
}
