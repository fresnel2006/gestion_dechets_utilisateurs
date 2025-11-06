import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
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

                    Text("Vérifiez vos messages et\n entrez le code reçu au numero \n ########## pour confirmer \n votre identité.",textAlign: TextAlign.center,style: TextStyle(),),
                    SizedBox(height: MediaQuery.of(context).size.height *0.04,),
                    Container(
                        width: MediaQuery.of(context).size.width *0.7,
                        height: 50,
                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: TextFormField(
                          cursorColor: Color(0xFF292D3E),
                          decoration: InputDecoration(
                              hintText:"Saisissez le code",
                              prefixIcon: Icon(FontAwesomeIcons.lock,size: 19,color: Color(0xFF292D3E),),
                              focusedBorder: UnderlineInputBorder(
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
//Bouton d'inscription
                    Container(child: ElevatedButton(onPressed: (){}, child: Text("VERIFICATION",style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),),

                  ],
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height *0.05,
                    left: MediaQuery.of(context).size.width *0.02,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1)),
                            border: Border.all(color: Colors.black)
                        ),
                        child: CircleAvatar(backgroundColor: Colors.white,radius: MediaQuery.of(context).size.width *0.08,child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,color: Colors.green,size: MediaQuery.of(context).size.width *0.09 ,),style: ElevatedButton.styleFrom(backgroundColor: Colors.white),),))
                ),
              ],
            )));

  }
}

