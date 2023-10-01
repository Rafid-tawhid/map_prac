import 'package:map_prac/models/place_model.dart';
import 'package:riverpod/riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>>{
  UserPlacesNotifier():super(const[]);

  void addPlace(String title){
    final newPlace=Place(title: title);
    state=[newPlace, ...state];
  }

}

final userPlacesProvider=StateNotifierProvider<UserPlacesNotifier,List<Place>>((ref) => UserPlacesNotifier());