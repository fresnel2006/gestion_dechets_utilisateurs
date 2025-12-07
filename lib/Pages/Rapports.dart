import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart' as picker;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RapportsPage extends StatefulWidget {
  RapportsPage({super.key, required this.latitude, required this.longitude});

  var latitude;
  var longitude;
  @override
  State<RapportsPage> createState() => _RapportsPageState();
}

class _RapportsPageState extends State<RapportsPage> {


  var data;
  var photo;
  var photo_string;
  var photo_rapport;
  var numero;
  final description=TextEditingController();

  void message_rapport_recu(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),backgroundColor: Colors.transparent,content: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height *0.1,
          width: MediaQuery.of(context).size.width *1,
          decoration: BoxDecoration(color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
          ),
          child: ListTile(

            title: Text("MERCI NOUS VOUS RECONTACTERONS",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
            leading: Icon(Icons.track_changes_outlined,size: MediaQuery.of(context).size.width *0.15,color: Colors.white,),
          ),
        )
    )));
  }
  Future <void> restaurer_donnee() async{
    var perfs=await SharedPreferences.getInstance();
    setState(() {
      numero=perfs.getString("numero_utilisateur")??"vide";
    });
    print(numero);

  }
  Future <void> envoyer_rapport()async{
    final url=Uri.parse("http://192.168.1.7:8000/envoyer_rapport_utilisateur");
    var message=await http.post(url,headers: {"Content-Type":"application/json"},
        body: jsonEncode({
          "numero":numero,
          "latitude":widget.latitude.toString(),
          "longitude":widget.longitude.toString(),
          "descriptions":description.text,
          "photo":photo_string
        })
    );
    data=jsonDecode(message.body);
    if(data["rapport_utilisateur"]=="rapport utilisateur ajouté"){
      message_rapport_recu();
    }

  }
  void message_champ_vide(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),backgroundColor: Colors.transparent,content: GestureDetector(
        child: Container(
          height: MediaQuery.of(context).size.height *0.1,
          width: MediaQuery.of(context).size.width *1,
          decoration: BoxDecoration(color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
          ),
          child: ListTile(

            title: Text("CHAMP VIDE",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
            subtitle: Container(
              child: Text("VOUS DEVEZ ENTRER DES DONNEES",style: TextStyle(color: Colors.white70,fontFamily: "Poppins"),),),
            leading: Icon(Icons.dangerous,size: MediaQuery.of(context).size.width *0.15,color: Colors.white,),
          ),
        )
    )));
  }
  Future <void> prendre_photo() async {
    photo = await picker.ImagePicker().pickImage(source: picker.ImageSource.camera);
    var photo_bytes=await File(photo!.path).readAsBytes();

    setState(() {
      photo_string=base64Encode(photo_bytes).toString();

      photo_rapport =  Image.file(File(photo!.path));

    });
    print(photo_string);
    await Gal.putImage(photo!.path);
  }
  @override
  void initState(){
    super.initState();
    restaurer_donnee();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child:
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.05),
        height: MediaQuery.of(context).size.height *1,
        width: MediaQuery.of(context).size.width *1,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.green,width: 20)),
            borderRadius: BorderRadius.only(topRight: Radius.circular(MediaQuery.of(context).size.width *1),topLeft: Radius.circular(MediaQuery.of(context).size.width *1)),color: Colors.white),
        child: Column(
          children: [

            SizedBox(height: MediaQuery.of(context).size.height *0.04,),
            Container(child: Lottie.asset("assets/animations/Walking Pothos.json",height: 150),),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("RETOUR",style: TextStyle(fontFamily: "Poppins",color: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),
            SizedBox(height: MediaQuery.of(context).size.height *0.03,),
            Container(child: Text("AJOUTER UN RAPPORT",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.06),),),
            SizedBox(height: MediaQuery.of(context).size.height *0.02,),
            Container(child: Text("Appuyer pour prendre \nune photo",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.04)),),
            SizedBox(height: MediaQuery.of(context).size.height *0.01,),
            GestureDetector(
              child: photo_rapport!=null?Container(
                height: MediaQuery.of(context).size.height *0.15,
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.green,width: MediaQuery.of(context).size.width *0.007,),borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.02))),
                  child:ClipRRect(child: photo_rapport,),),):Container(
                  child: Lottie.asset("assets/animations/Add new.json",height: MediaQuery.of(context).size.height *0.20)),
              onTap: ()async{
                await prendre_photo();
              },

            ),
            SizedBox(height: MediaQuery.of(context).size.height *0.02,),
            Container(
              height: MediaQuery.of(context).size.height *0.1,
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.04,right: MediaQuery.of(context).size.width *0.04),
              child: TextFormField(
                controller: description,
                maxLines: 200,
                decoration: InputDecoration(
                    hintText: "DESCRIPTION",

                    suffixIcon: IconButton(onPressed: ()async{
                      if(photo==null|| description.text.isEmpty){
                        Navigator.pop(context);
                        message_champ_vide();
                      }else{

await envoyer_rapport();
Navigator.pop(context);

                      }

                    }, icon: Icon(Icons.send,color: Colors.black,)),
                    hintStyle: TextStyle(fontFamily: "Poppins"),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.03))
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.03))
                    )
                ),
              ),)
          ],),
      ),),
    );
  }
}
