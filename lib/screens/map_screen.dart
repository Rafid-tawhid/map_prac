import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_prac/models/place_model.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation location;
  final bool isSelecting;
 //const MapScreen({super.key,this.location=const PlaceLocation(latitude: 23.71, longatude: 90.031, address: '')});
 const MapScreen({super.key,required this.location,this.isSelecting=true});


  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text(widget.isSelecting?'Pick your Location':'Your Location'),
      actions: [
        if(widget.isSelecting)IconButton(onPressed: (){
          Navigator.of(context).pop(_pickedLocation);
        }, icon: Icon(Icons.save))
      ],),
      body: GoogleMap(
        onTap: widget.isSelecting==false?null: (position){
          setState(() {
            _pickedLocation=position;
          });
        },
        initialCameraPosition: CameraPosition(target: LatLng(widget.location.latitude, widget.location.longatude),zoom: 16),
        markers: (_pickedLocation==null&&widget.isSelecting)?{}:{
           Marker(
             markerId: MarkerId('m2'),
             position: _pickedLocation!=null?_pickedLocation! : LatLng(widget.location.latitude, widget.location.longatude)
           )
        },

      ),
    );
  }
}
