import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furnitureshop_appadmin/data/models/user_profile.dart';

class UserRepository {
  Future<UserProfile> getUserProfileWithID(String userID) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    UserProfile user = UserProfile();
    await collection.doc(userID).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        user = UserProfile.fromJson(data, userID);
      }
    });
    return user;
  }

  
  Future<bool> checkAccountAdmin(String userID) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('account_admin');
    UserProfile? user;
    await collection.doc(userID).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print("Inside check admin");
        print(data);
        print(userID);
        user = UserProfile.fromJson(data, userID);
      }
    });
    if (user != null) return true;
    return false;
  }

  // Future<bool> getAllMyUserProfile(String userID) async {
  //   CollectionReference collection =
  //       FirebaseFirestore.instance.collection('account_admin');
  //   List<UserProfile> carts = [];

  //   await collection.get().then((QuerySnapshot querySnapshot) {
  //     carts = querySnapshot.docs.map((doc) {
  //       if (doc.exists) {
  //         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //         user = UserProfile.fromJson(data, userID);
  //         if (doc.id == userID) return true;
  //         return a;
  //       }
  //       return UserProfile();
  //     }).toList();
  //   });
  //   return false;
  // }
}
