import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hackaton_utilisateur/Pages/Compte.dart';
import 'package:hackaton_utilisateur/Pages/Rapport.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:shared_preferences/shared_preferences.dart';

class AcceuilPage extends StatefulWidget {
  const AcceuilPage({super.key});

  @override
  State<AcceuilPage> createState() => _AcceuilPageState();
}

var donnee;

class _AcceuilPageState extends State<AcceuilPage> {
  double longitude = 0;
  double latitude = 0;

  // Pour le marqueur de l'utilisateur
  CircleAnnotationManager? _circleAnnotationManager;
  CircleAnnotation? _userCircleAnnotation;
  // Nouvelle variable pour gérer le centrage initial de la carte
  bool _isFirstLocationUpdate = true;

  Future<void> avoirville() async {
    if (latitude == 0 && longitude == 0) return;

    final url = Uri.parse(
        "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$latitude&lon=$longitude&accept-language=fr");
    final reponse = await http.get(
      url,
      headers: {"User-Agent": "hackaton_utilisateur/1.0 (exemple@monmail.com)"},
    );

    if (reponse.statusCode == 200) {
      var message = jsonDecode(reponse.body);
      if (mounted) {
        // Correction pour trouver le nom du lieu de manière fiable
        var address = message["address"];
        String? nomLieu = address["city"] ?? address["town"] ?? address["village"] ?? address["suburb"];
        setState(() {
          donnee = nomLieu ?? "Lieu inconnu";
        });
      }
      print(donnee);
    }
  }

  geolocator.Position? _currentPosition;
  late MapboxMap _mapboxMap;

  var numero;
  var data;
  Future <void> affichier_donnee()async{
    final url=Uri.parse("http://192.168.1.17:8000/afficher_donnee_utilisateur");
    var message=await http.post(url,headers: {"Content-Type":"application/json"},
        body: jsonEncode({
          "numero":numero
        })
    );
    data=jsonDecode(message.body);
    print(data);
  }
  Future <void> restaurer_donnee() async{
    var perfs=await SharedPreferences.getInstance();
    setState(() {
      numero=perfs.getString("numero_utilisateur")??"vide";
    });
    print(numero);
  }
  @override
  void initState() {
    super.initState();
    MapboxOptions.setAccessToken(
        "pk.eyJ1IjoiZnJlc25lbDYwNyIsImEiOiJjbWhrbGx1MzMwOGV4MmtxazdsOWp0dzIxIn0.v02HfvuS1iZnm_-od_niSw");
    _determinePosition();
    avoirville();
    affichier_donnee();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    geolocator.LocationPermission permission;

    serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    permission = await geolocator.Geolocator.checkPermission();
    if (permission == geolocator.LocationPermission.denied) {
      permission = await geolocator.Geolocator.requestPermission();
      if (permission == geolocator.LocationPermission.denied) {
        print('Location permissions are denied');
        return;
      }
    }

    if (permission == geolocator.LocationPermission.deniedForever) {
      print('Location permissions are permanently denied');
      return;
    }

    geolocator.Geolocator.getPositionStream(
      locationSettings: const geolocator.LocationSettings(
        accuracy: geolocator.LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((geolocator.Position position) {
      print('Position mise à jour: ${position.latitude}, ${position.longitude}');

      if (mounted) {
        setState(() {
          _currentPosition = position;
          longitude = position.longitude;
          latitude = position.latitude;
        });

        avoirville();
        _updateUserMarker(position);

        // A la toute première mise à jour de la position, on centre la carte
        if (_isFirstLocationUpdate) {
          _isFirstLocationUpdate = false;

          _mapboxMap.flyTo(
            CameraOptions(
              center: Point(coordinates: Position(position.longitude, position.latitude)),
              zoom: 14,
            ),
            MapAnimationOptions(duration: 1500), // Animation fluide
          );
        }
      }
    });
  }

  void _onMapCreated(MapboxMap controller) async {
    _mapboxMap = controller;
    _circleAnnotationManager = await _mapboxMap.annotations.createCircleAnnotationManager();
  }

  void _updateUserMarker(geolocator.Position position) async {
    if (_circleAnnotationManager == null) return;
    final point = Point(coordinates: Position(position.longitude, position.latitude));

    if (_userCircleAnnotation == null) {
      _userCircleAnnotation = await _circleAnnotationManager!.create(
        CircleAnnotationOptions(
            geometry: point,
            circleColor: Colors.blue.value,
            circleRadius: 8.0,
            circleStrokeColor: Colors.white.value,
            circleStrokeWidth: 2.0),
      );
    } else {
      _userCircleAnnotation!.geometry = point;
      _circleAnnotationManager!.update(_userCircleAnnotation!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapWidget(
            styleUri: MapboxStyles.MAPBOX_STREETS,
            onMapCreated: _onMapCreated,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
                  decoration: BoxDecoration(color:Colors.white,border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 1)),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: (){
                        // Correction de l'erreur ici
                        ZoomDrawer.of(context)!.toggle();

                      },
                      icon: Icon(Icons.menu, color: Colors.green),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
                height: MediaQuery.of(context).size.height * 0.065,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: Colors.red),
                    SizedBox(width: 8),
                    Text(donnee == null ? "CHARGEMENT...." : "$donnee",style: TextStyle(fontFamily: "Poppins"),),
                  ],
                ),
              ),
              //fresnel modifie ici met l'icone du compte
              Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black), shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        // Quand on appuie sur ce bouton, on recentre la carte
                        if (_currentPosition != null) {
                          _mapboxMap.flyTo(
                            CameraOptions(
                              center: Point(coordinates: Position(_currentPosition!.longitude, _currentPosition!.latitude)),
                              zoom: 14,
                            ),
                            MapAnimationOptions(duration: 1500),
                          );
                        }
                      },
                      icon: Icon(Icons.my_location, color: Colors.green),
                    ),
                  )),
            ],
          ),
          Container(
padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.07,right: MediaQuery.of(context).size.width *0.07),
            height: MediaQuery.of(context).size.height *0.2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width * 0.15), topRight: Radius.circular(MediaQuery.of(context).size.width * 0.15))),

              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.8),
              child: Stack(

                alignment: AlignmentGeometry.center,
                children: [

                  GestureDetector(
                    onTap: ()async{
                      await restaurer_donnee();
Navigator.push(context, MaterialPageRoute(builder: (context)=>RapportPage(longitude:longitude,latitude:latitude,numero:numero)));
                    },
                    child:Container(

                      padding:EdgeInsets.only(top: MediaQuery.of(context).size.height *0.015),
                      margin:EdgeInsets.only(bottom:MediaQuery.of(context).size.height *0.02,top: MediaQuery.of(context).size.height *0.02),
                      height: MediaQuery.of(context).size.height *0.11,
                      width: MediaQuery.of(context).size.width *1,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1))
                      ),
                      child: ListTile(title: Text("RAPPORT DE \nSALUBRITE",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
                        leading: CircleAvatar(radius: MediaQuery.of(context).size.width *0.1,child: Icon(Icons.camera_alt_rounded,color: Colors.green,),backgroundColor: Colors.white,),),
                    ),),
                  //fait des modification ici c'etait pas toi la
                  Positioned(top:MediaQuery.of(context).size.height *0.07 ,right:MediaQuery.of(context).size.width *0.11,child: Container(decoration:BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1)),border: Border.all(color: Colors.green)),
                    child:CircleAvatar(backgroundColor: Colors.white,child: IconButton(onPressed: (){

                    }, icon: Icon(Icons.arrow_forward_outlined))),))
                ],
              )
          ),
          Positioned(
              top: MediaQuery.of(context).size.height *0.14,
              right: MediaQuery.of(context).size.width *0.035,
              child: Row(
            children: [
              Container(decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width *1)),child: CircleAvatar(backgroundColor: Colors.white,child: IconButton(onPressed: (){}, icon: Icon(Icons.warning,color: Colors.red)),),),
              SizedBox(width: MediaQuery.of(context).size.width *0.04,),
              Container(decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width *1)),child: CircleAvatar(backgroundColor: Colors.white,child: IconButton(onPressed: ()async{
                await restaurer_donnee();
                await affichier_donnee();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ComptePage()));
              }, icon: Icon(Icons.account_circle_sharp,color: Colors.green))),)
            ],))


        ],
      ),
    );
  }
}
