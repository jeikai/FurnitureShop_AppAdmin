// ignore_for_file: non_constant_identifier_names

import 'package:furnitureshop_appadmin/data/servers/base_api_server.dart';

class DiscountAPIServer {
  final String URL = "/discount";

  static BaseAPIServer api = BaseAPIServer();
  Future<void> addDiscount(Map<String, dynamic> data) async {
    String ramdomIDFolder = api.getRandomString(15);
    if (data["image_network"] != 'null') {
      String getURLdownload = await api.uploadFile('image_discount/$ramdomIDFolder', data["image_network"]);
      data["image_network"] = getURLdownload;
    } else {
      data["image_network"] = "https://firebasestorage.googleapis.com/v0/b/furnitureapp-27389.appspot.com/o/image_discount%2F5T4DJfKBQobBexa%2F10bg.png?alt=media&token=605712de-2ad1-4118-a99f-3d6fd8c39ef1";
    }
    await api.set(url: URL, id: ramdomIDFolder, data: data);
  }
}
