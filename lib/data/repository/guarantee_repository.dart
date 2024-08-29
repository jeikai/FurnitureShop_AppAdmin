import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furnitureshop_appadmin/data/models/guarantee.dart';
import 'package:furnitureshop_appadmin/data/servers/guarantee_api_server.dart';

class GuaranteeRepository {
  GuaranteeAPIServer guaranteeAPIServer = GuaranteeAPIServer();

  Future<void> addGuarantee(Guarantee guarantee) async {
    Map<String, dynamic> data = guarantee.toMap();
    await guaranteeAPIServer.add(data);
  }

  // Future<List<Guarantee>> getGuarantee() async {
  //   CollectionReference collection = FirebaseFirestore.instance.collection('guarantees_doing');
  //   await collection.get().then((QuerySnapshot querySnapshot) {
  //
  //   }
  // }
}
