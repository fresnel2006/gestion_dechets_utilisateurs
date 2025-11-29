import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hackaton_utilisateur/Pages/Acceuil.dart';
import 'package:hackaton_utilisateur/Pages/Inscription.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RapportPage extends StatefulWidget {
  RapportPage({super.key, required this.longitude, required this.latitude, required this.numero});
var longitude;
var latitude;
  var numero;
  @override
  State<RapportPage> createState() => _RapportPageState();
}
XFile? photo;
var photo_rapport;
var photo_rapport_string;
String numero_utilisateur="";
final description=TextEditingController();

class _RapportPageState extends State<RapportPage> {

Future <void> prendre_photo() async{
  photo= await ImagePicker().pickImage(source: ImageSource.camera);
  photo_rapport_string=await photo!.readAsBytes();
  setState(() {
    print(widget.longitude.toString());
    print(widget.latitude.toString());
    photo_rapport= Image.file(File(photo!.path),);
photo_rapport_string=photo_rapport_string.toString();
    print(photo_rapport_string);
    numero_utilisateur=widget.numero;
  });
print(numero_utilisateur);

}


  @override
  void initState() {
    super.initState();
    prendre_photo();

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
              SizedBox(height: MediaQuery.of(context).size.height *0.08,),
              Row(
                children: [
                SizedBox(width: MediaQuery.of(context).size.width *0.06,),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black,width: MediaQuery.of(context).size.width *0.004),borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1))),
                    child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_sharp,color: Colors.black,size: MediaQuery.of(context).size.width *0.06,)),
                  ),SizedBox(width: MediaQuery.of(context).size.width *0.1,),
                Container(child: Text("RAPPORT DECHET",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.05,color: Colors.black),),)
              ],),
                SizedBox(height: MediaQuery.of(context).size.height *0.02,),
                GestureDetector(
                  onTap: (){
prendre_photo();
                  },
                  child: Container(height: MediaQuery.of(context).size.height *0.2,child: Lottie.asset("assets/animations/Warning animation.json"),),
                ),
        Container(child: Text("Veuillez vous assurer que les informations fournies sont exactes afin de faciliter la résolution des problèmes liés aux déchets dans votre secteur.",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Poppins",color: Colors.black),),),

                SizedBox(height: MediaQuery.of(context).size.height *0.02,),
                GestureDetector(
                  onTap: (){
                    prendre_photo();
                  },
                  child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.green,width: MediaQuery.of(context).size.width *0.007,),borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.02))),
                  height: MediaQuery.of(context).size.height *0.16,
                  child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.015)),child: photo_rapport,),),
                ),//espace
                SizedBox(height: MediaQuery.of(context).size.height *0.03,),
                Container(
                  width: MediaQuery.of(context).size.width *0.9,
padding: EdgeInsets.all(MediaQuery.of(context).size.width *0.007),
                  height: MediaQuery.of(context).size.height *0.07,
                  decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2),borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.03))),
                  child: Row(children: [

                    Container(child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.025)),child: photo_rapport,),),
                    SizedBox(width: MediaQuery.of(context).size.width *0.01,),
                    Container(decoration: BoxDecoration(border: Border.all(color: Colors.black)),),
                    GestureDetector(onTap:(){
                      prendre_photo();
                    },child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.02),child: Text("Appuyer pour prendre une \nnouvelle photo",style: TextStyle(fontFamily: "Poppins",color: Colors.green),)
                    ))

                  ],),
                ),SizedBox(height: MediaQuery.of(context).size.height *0.01,)

                ,Container(
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.06,right: MediaQuery.of(context).size.width *0.06),
                  height: MediaQuery.of(context).size.height *0.15,
                  child: TextFormField(
                    controller:description,
                    maxLines: 200,
cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: "Saisissez votre rapport nous permettant de gerer le probleme de dechet",
hintStyle: TextStyle(fontFamily: "Poppins",color: Colors.black54),

suffixIcon: IconButton(onPressed: (){

}, icon: Icon(Icons.send),color: Colors.black),
                      focusedBorder: OutlineInputBorder(

                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.04))
                              ,borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007),
                      ),
                      enabledBorder: OutlineInputBorder(

                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.04))
                      )
                    ),
                  ),),


              
          ],)],)
      ),
    );
  }
}
