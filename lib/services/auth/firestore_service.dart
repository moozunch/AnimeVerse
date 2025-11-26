import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/anime.dart';

class FirestoreService {
  // Firestore service implementation
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; //hubungin ke Firestore
  //buat collection
  CollectionReference _usersCollection(){
      return _firestore.collection('users');
  }

  //Get favorite anime stream, ngebaca dari Firestore dipanggil berdasar userId
  Stream<List<Anime>> getfavoritesStream(String userId) {
    return _usersCollection()
        .doc(userId)
        .collection('favorites')
        .snapshots() //bedanya dengan get, snapshots itu stream jadi realtime update
        .map((snapshot) {
          return snapshot.docs
              .map((doc) {
                return Anime.fromFavoritesJson(doc.data());
              })
              .toList();
        });
  }

  //Add favorite anime
  Future<void> addFavoriteAnime(String userId, Anime anime) async {
    await _usersCollection()
        .doc(userId)
        .collection('favorites')
        .doc(anime.malId.toString())  //ditambahkan ke favortie berdasarkan ide dari animenya bukan nama animenya
        .set(anime.toJson());
  }
  //Remove favorite anime
  Future<void> removeFavoriteAnime(String userId, int malId) async {
    await _usersCollection()
        .doc(userId)
        .collection('favorites')
        .doc(malId.toString())
        .delete();
  }
}