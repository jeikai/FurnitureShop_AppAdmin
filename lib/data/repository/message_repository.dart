import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furnitureshop_appadmin/data/models/message_model.dart';
import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/models/user_profile.dart';
import 'package:furnitureshop_appadmin/data/repository/product_repository.dart';
import 'package:furnitureshop_appadmin/data/servers/message_api_server.dart';

class MessageRepository {
  Future<List<Message>> getMessage(String userID) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('chatroom').doc(userID).collection('message');
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

  Future<Message> getLatestMessage(String userID) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('chatroom').doc(userID).collection('message');
    List<Message> message = [];
    await collection.orderBy('time', descending: true).limit(1).get().then((QuerySnapshot querySnapshot) {
      message = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Message a = Message.fromMap(data);
          return a;
        }
        return Message(time: DateTime.now());
      }).toList();
    });
    return message[0];
  }

  Future<bool> checkOrigin(String userID) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('chatroom');
    List<Message> message = [];
    await collection.where('userID', isEqualTo: userID).limit(1).get().then((QuerySnapshot querySnapshot) {
      message = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Message a = Message.fromMap(data);
          return a;
        }
        return Message(time: DateTime.now());
      }).toList();
    });
    if (message.length > 0) return false;
    return true;
  }

  Future<void> sendProduct(Product product, UserProfile user) async {
    Message mess = Message(
      userID: user.id,
      userName: user.name,
      userAvataPath: user.avatarPath,
      isAdmin: true,
      adminID: FirebaseAuth.instance.currentUser?.uid ?? "",
      content: null,
      productId: product.id,
      productName: product.name,
      productPrice: product.price,
      productImage: product.imagePath?[0] ?? null,
      time: DateTime.now(),
    );
    if (await checkOrigin(user.id)) {
      await MessageAPIServer().setChatRoom(mess.toMap(), user.id);
    } else {
      await MessageAPIServer().updateChatRoom({
        'is_admin': true,
        'time': DateTime.now().millisecondsSinceEpoch,
        'productID': product.id,
        'product_name': product.name,
        'product_price': product.price,
        'product_image_path': product.imagePath?[0] ?? null,
        'adminID': FirebaseAuth.instance.currentUser?.uid ?? "",
      }, user.id);
    }
    await MessageAPIServer().add(mess.toMap(), user.id);
  }

  Future<void> sendMessage(String content, UserProfile user) async {
    if (content.trim() == "") return;
    Message mess = Message(
      userID: user.id,
      userName: user.name,
      userAvataPath: user.avatarPath,
      isAdmin: true,
      adminID: null,
      content: content,
      productId: null,
      productName: null,
      productPrice: null,
      productImage: null,
      time: DateTime.now(),
    );
    if (await checkOrigin(user.id)) {
      await MessageAPIServer().setChatRoom(mess.toMap(), user.id);
    } else {
      await MessageAPIServer().updateChatRoom({
        'is_admin': true,
        'time': DateTime.now().millisecondsSinceEpoch,
        'content': content,
        'adminID': FirebaseAuth.instance.currentUser?.uid ?? "",
      }, user.id);
    }
    await MessageAPIServer().add(mess.toMap(), user.id);
  }
}
