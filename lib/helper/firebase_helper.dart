import 'package:authentication_app_exam/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseHelper extends GetxController {

  FirebaseHelper._();
  static FirebaseHelper firebaseHelper = FirebaseHelper._();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String userCollection = 'FavUsers';
  var allFavUsers = <UserModel>[].obs;

  void fetchUsers() async {
    var snapshot = await fireStore.collection(userCollection).get();
    allFavUsers.value =
        snapshot.docs.map((e) => UserModel.fromMap(data: e.data())).toList();
  }

  void toggleFavorite(String userId, bool isFavorite) async {
    await fireStore
        .collection(userCollection)
        .doc(userId)
        .update({'isFavorite': !isFavorite});
    fetchUsers();
  }
}
