import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:map_prac/models/place_location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  bool _isloading=false;
  PlaceLocation? _pickedLocation;

  String get locationImage{
    final lat=_pickedLocation!.latitude;
    final lng=_pickedLocation!.latitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat ,$lng&key=AIzaSyBsmIxUdW_2FQ24Kl-ZhJ_oPyh0K422y0o';
  }

  @override
  Widget build(BuildContext context) {
    Widget preview=Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(.2)
          )
      ),
      child: Center(child: Text('No Location Chosen',textAlign: TextAlign.center,)),
    );
    if(_pickedLocation!=null){
      print('IMAGE ${locationImage}');
      preview=Image.network(locationImage,fit: BoxFit.cover,width: double.infinity,height: double.infinity,);

    }
    if(_isloading){
      preview=CircularProgressIndicator();
    }


    return  Scaffold(
      body: Column(
        children: [
          Container(
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(.2)
              )
            ),
            child: Center(child: preview),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: getCurrentLocation,
                icon: Icon(Icons.location_on),
                label: Text('Get current Location'),
              ),
              TextButton.icon(
                onPressed: (){},
                icon: Icon(Icons.map),
                label: Text('Select On Map'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isloading=true;
    });
    _locationData = await location.getLocation();

    final url=Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=${_locationData.latitude},${_locationData.longitude}&key=AIzaSyBsmIxUdW_2FQ24Kl-ZhJ_oPyh0K422y0o');

    final response= await http.get(url);
    final resData= json.decode(response.body);
    final lat=_locationData.latitude;
    final lng=_locationData.longitude;
    print(_locationData.latitude);
    print(_locationData.longitude);
    if(lat==null||lng==null){
      return;
    }

    final address=resData['results'][0]['formatted_address'];
    print('ADDRESS ${address}');
    setState(() {
      _pickedLocation=PlaceLocation(latitude: _locationData.latitude!, longatude: _locationData.longitude!, address: address);
    });




    setState(() {
      _isloading=false;
    });


  }
}
//AIzaSyBsmIxUdW_2FQ24Kl-ZhJ_oPyh0K422y0o