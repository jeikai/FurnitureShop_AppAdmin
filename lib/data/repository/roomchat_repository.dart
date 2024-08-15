import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furnitureshop_appadmin/data/models/message_model.dart';
import 'package:furnitureshop_appadmin/data/repository/user_repository.dart';

class RoomChatRepository {
  Future<List<Message>> getRoomChat() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('chatroom');
    List<Message> message = [];
    await collection.orderBy('time', descending: true).get().then((QuerySnapshot querySnapshot) {
      message = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Message a = Message.fromMap(data);
          return a;
        }
        return Message(time: DateTime.now());
      }).toList();
    });
    return message;
  }
}
