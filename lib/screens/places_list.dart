import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_prac/providers/user_provider.dart';

import 'add_places.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final  userPlace= ref.watch(userPlacesProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Your Places'),
      actions: [IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNewPlaces() ));
      }, icon: Icon(Icons.add))],
      ),
      body: Column(
        children: userPlace.map((e) => Card(child: ListTile(title: Text(e.title??''),))).toList(),
      ),
    );
  }
}
