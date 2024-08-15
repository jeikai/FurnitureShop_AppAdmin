import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furnitureshop_appadmin/data/models/account_admin.dart';
import 'package:furnitureshop_appadmin/data/servers/admin_api_server.dart';

class AdminRepository {
  Future<Admin> getUserProfile() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('account_admin');
    String userID = FirebaseAuth.instance.currentUser?.uid ?? "";
    Admin ad = Admin();
    await collection.doc(userID).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        ad = Admin.fromJson(data, userID);
      }
    });
    return ad;
  }

  Future<void> addStaff(Admin admin, String id) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('account_admin');
    await AdminAPIServer().add(id, admin.toJson());
  }
}
