import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:http/http.dart' as http show get;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geolocator;

class AcceuilPage extends StatefulWidget {
  const AcceuilPage({required this.controller, Key? key}) : super(key: key);
  final ZoomDrawerController controller;

  @override
  State<AcceuilPage> createState() => _AcceuilPageState();
}
double longitude=0;
double latitude=0;
var donnee;

class _AcceuilPageState extends State<AcceuilPage> {
  Future <void> avoirville() async{
    final url=Uri.parse("https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$latitude&lon=$longitude&accept-language=fr");
    final reponse=await http.get(url,headers: {
      "User-Agent": "hackaton_utilisateur/1.0 (exemple@monmail.com)"
    },);

    var message=jsonDecode(reponse.body);

    setState(() {
      donnee=message["address"]["city"];
    });
    print(donnee);
  }
  // 2. Toutes les variables et fonctions sont maintenant DANS la classe
  geolocator.Position? _currentPosition;
  late MapboxMap _mapboxMap;

  // Le point utilise la classe `Position` de Mapbox, donc pas de préfixe ici.
  final _mezePoint = Point(
    coordinates: Position(-4.0082563, 5.3599517),
  );

  @override
  void initState() {
    super.initState();
    // Le token doit être défini ici, une seule fois.
    MapboxOptions.setAccessToken("pk.eyJ1IjoiZnJlc25lbDYwNyIsImEiOiJjbWhrbGx1MzMwOGV4MmtxazdsOWp0dzIxIn0.v02HfvuS1iZnm_-od_niSw");
    _determinePosition();
    avoirville();

  }

  // Fonction pour recevoir le contrôleur de la carte
  void _onMapCreated(MapboxMap controller) {
    _mapboxMap = controller;
    // Centrer la carte sur le point initial
    _mapboxMap.setCamera(
      CameraOptions(
        center: _mezePoint,
        zoom: 14,
      ),
    );
    avoirville();
  }

  /// Détermine la position et écoute les changements.
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

    // Écoute le flux de positions
    geolocator.Geolocator.getPositionStream(
      locationSettings: const geolocator.LocationSettings(
        accuracy: geolocator.LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((geolocator.Position position) {

      print('Position mise à jour: ${position.latitude}, ${position.longitude}');
      setState(() {
        longitude=position.longitude;
        latitude=position.latitude;
print(longitude);
print(latitude);
      });
      // 3. Utiliser setState pour mettre à jour la variable et rafraîchir l'écran
      if (mounted) {
        setState(() {
          _currentPosition = position;
          longitude=position.longitude;
          latitude=position.latitude;
          print(longitude);
          print(latitude);
          avoirville();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Note: `WidgetsFlutterBinding.ensureInitialized()` et la définition du token
    // ne doivent pas être dans la méthode build car elle est appelée très souvent.
    // Je les ai déplacés dans initState.

    return Scaffold(
      body: Stack(
        children: [
          // Le widget Mapbox en arrière-plan
          MapWidget(
            styleUri: MapboxStyles.MAPBOX_STREETS,
            onMapCreated: _onMapCreated,
          ),

          // Votre interface utilisateur par-dessus la carte
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 1)),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        // Correction: Il faut appeler la fonction avec des parenthèses ()
                        widget.controller.toggle!();
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
                    Icon(Icons.location_on,color: Colors.red,),
                    SizedBox(width: 8),

                    // Afficher la position pour vérifier que ça marche
                    Text(donnee==null?"CHARGEMENT....":"$donnee"),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black), shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.manage_accounts_sharp, color: Colors.green),
                    ),
                  )),
            ],
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width * 0.15), topRight: Radius.circular(MediaQuery.of(context).size.width * 0.15))),
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.7),
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: AlignmentGeometry.center,
                    children: [
                    Container(

                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height *0.03),
                      padding:EdgeInsets.only(top: MediaQuery.of(context).size.height *0.01),
                      width: MediaQuery.of(context).size.width *0.7,height: MediaQuery.of(context).size.height *0.1,decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1))),child: ListTile(leading: CircleAvatar(radius: MediaQuery.of(context).size.width *0.08,),title: Text("Conducteur 1",style: TextStyle(fontFamily: "Poppins2",fontSize: MediaQuery.of(context).size.width *0.05,color: Colors.white),),subtitle: Text("Distance",style: TextStyle(color: Colors.white,fontFamily: "Poppins2"),),),),
                      Positioned(
                        top:MediaQuery.of(context).size.height *0.025,
                        right:MediaQuery.of(context).size.width *0.11,
                        child: CircleAvatar(radius: MediaQuery.of(context).size.width *0.05,child: Icon(Icons.play_arrow_rounded,size: MediaQuery.of(context).size.width *0.09,),)
                        ,)],);
                },
              ))
        ],
      ),
    );
  }
}
