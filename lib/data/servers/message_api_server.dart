import 'package:firebase_auth/firebase_auth.dart';
import 'package:furnitureshop_appadmin/data/servers/base_api_server.dart';

class MessageAPIServer {
  String url(String s) => "chatroom/$s/message";
  String urlRoom() => "chatroom";

  static BaseAPIServer api = BaseAPIServer();
  Future<void> add(Map<String, dynamic> data, String idUser) async {
    await api.add(url: url(idUser), data: data);
  }

  Future<void> setChatRoom(Map<String, dynamic> data, String idUser) async {
    await api.set(url: urlRoom(), data: data, id: idUser);
  }

  Future<void> updateChatRoom(Map<String, dynamic> data, String idUser) async {
    await api.update(url: urlRoom(), data: data, id: idUser);
  }
}
