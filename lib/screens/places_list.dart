import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_prac/providers/user_provider.dart';
import 'package:map_prac/screens/places_details.dart';

import 'add_places.dart';

class PlacesListScreen extends ConsumerStatefulWidget {
  const PlacesListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _PlaceListScreenState();
  }
}
class _PlaceListScreenState extends ConsumerState<PlacesListScreen> {

  late Future<void> _placeFuture;

  @override
  void initState() {
   _placeFuture=ref.read(userPlacesProvider.notifier).loadPlace();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPlace = ref.watch(userPlacesProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddNewPlaces()));
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: _placeFuture,
          builder: (context,snapshot)=> snapshot.connectionState==ConnectionState.waiting?
          Center(child: CircularProgressIndicator(),):
            ListView.builder(
              itemCount: userPlace.length,
              itemBuilder: (context, index) {
                final place = userPlace[index];
                return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 26,
                        backgroundImage: FileImage(place.image),
                      ),
                      title: Text(place.title ?? ''),
                      subtitle: Text(place.location.address),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlaceDetailsScreen(place: place)));

                      },
                    ));
              },
            )

        ));
  }
}
