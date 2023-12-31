import 'package:flutter/material.dart';
import 'package:map_prac/models/place_model.dart';

import 'map_screen.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key,required this.place});
  final Place place;

  String get locationImage{
    final lat=place.location.latitude;
    final lng=place.location.longatude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat ,$lng&key=AIzaSyBsmIxUdW_2FQ24Kl-ZhJ_oPyh0K422y0o';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(place.image,fit: BoxFit.cover,width: double.infinity,height: double.infinity,),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MapScreen(location: place.location,isSelecting: false,)));
                    },
                    child: CircleAvatar(
                      radius:70,
                      backgroundImage: NetworkImage(locationImage),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                    child: Text(place.location.address,style: TextStyle(),textAlign: TextAlign.center,),
                  ),
                ],
              ))
        ],
      )
    );
  }
}
