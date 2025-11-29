import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class CompteModificationPage extends StatefulWidget {
  const CompteModificationPage({super.key});

  @override
  State<CompteModificationPage> createState() => _CompteModificationPageState();
}

class _CompteModificationPageState extends State<CompteModificationPage> {
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
                    cursorColor: Color(0xFF292D3E),
                    decoration: InputDecoration(
                        hintText:"Nom",
                        hintStyle: TextStyle(fontFamily: "Poppins",color: Colors.grey[500]),
                        prefixIcon: Icon(Icons.edit,size: 19,color: Colors.green,),
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
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.01),
                  width: MediaQuery.of(context).size.width *0.7,
                  height: MediaQuery.of(context).size.height *0.065,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: TextFormField(
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
