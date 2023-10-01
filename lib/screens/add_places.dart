import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_prac/providers/user_provider.dart';

class AddNewPlaces extends ConsumerStatefulWidget {
  const AddNewPlaces({super.key});

  @override
  ConsumerState<AddNewPlaces> createState() => _AddNewPlacesState();
}

class _AddNewPlacesState extends ConsumerState<AddNewPlaces> {
  final _titleCon=TextEditingController();

  @override
  void dispose() {
    _titleCon.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  void  _savePlace(){
    final enteredText=_titleCon.text;
    if(enteredText.isEmpty){
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(enteredText);
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
              SizedBox(height: 20,),
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
