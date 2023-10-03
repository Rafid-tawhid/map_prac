import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_prac/models/place_model.dart';
import 'package:map_prac/providers/user_provider.dart';

import '../widgets/imager_input.dart';
import '../widgets/location_input.dart';

class AddNewPlaces extends ConsumerStatefulWidget {
  const AddNewPlaces({super.key});

  @override
  ConsumerState<AddNewPlaces> createState() => _AddNewPlacesState();
}

class _AddNewPlacesState extends ConsumerState<AddNewPlaces> {
  final _titleCon=TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  @override
  void dispose() {
    _titleCon.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  void  _savePlace(){
    final enteredText=_titleCon.text;
    if(enteredText.isEmpty||_selectedImage==null||_selectedLocation==null){
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(enteredText,_selectedImage!,_selectedLocation!);
    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add new Place'),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20 ),
          child: Column(
            children: [
              TextField(decoration: InputDecoration(labelText: 'Title'),
              controller: _titleCon ,
              ),
              ImageInput(onPickedImage: (image){
                _selectedImage=image;
              },),
              SizedBox(height: 10,),
              LocationInput(onSelectLocation: (location){
                _selectedLocation=location;
              },),
              SizedBox(height: 10,),
              ElevatedButton.icon(
                  onPressed: _savePlace ,
                  icon: Icon(Icons.add),
                  label: const Text('Add Place'))
            ],
          )
      ),
    );

  }
}
