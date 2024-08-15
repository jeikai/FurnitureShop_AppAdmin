import 'package:furnitureshop_appadmin/data/servers/base_api_server.dart';

class ProductAPIServer {
  final String productURL = "/products";
  final String categoryURL = "/category";
  final String allUrl = "/category/all/products";

  static BaseAPIServer api = BaseAPIServer();
  Future<void> addProduct(Map<String, dynamic> data) async {
    String ramdomIDFolder = api.getRandomString(15);
    if (data["image_path"] != null && (data["image_path"] as List<String>).length > 0) {
      List<String> getURLdownloads = await api.uploadFiles('image_product/${data['category']}/$ramdomIDFolder', data["image_path"]);
      data["image_path"] = getURLdownloads;
    }
    if (data["link_ar"] != null && data["link_ar"] != "") {
      String getURLdownload = await api.uploadFile('image_product/${data['category']}/$ramdomIDFolder', data["link_ar"]);
      data["link_ar"] = getURLdownload;
    }
    String idProduct = await api.add(url: allUrl, data: data);
    await api.set(url: "$categoryURL/${data['category']}/products", id: idProduct, data: data);
  }

  Future<void> update(Map<String, dynamic> data, String id, {String? linkAR, List<String>? linkimage}) async {
    String ramdomIDFolder = api.getRandomString(15);
    if (linkimage != null) {
      List<String> getURLdownloads = await api.uploadFiles('image_product/${data['category']}/$ramdomIDFolder', linkimage);
      data["image_path"] = data["image_path"].addAll(getURLdownloads);
    }
    if (linkAR != null) {
      String getURLdownload = await api.uploadFile('image_product/${data['category']}/$ramdomIDFolder', linkAR);
      data["link_ar"] = getURLdownload;
    }

    await api.update(url: allUrl, data: data, id: id);
    await api.update(url: "$categoryURL/${data['category']}/products", id: id, data: data);
  }

  Future<void> set(Map<String, dynamic> data, String id) async {
    await api.set(url: allUrl, data: data, id: id);
    await api.set(url: "$categoryURL/${data['category']}/products", id: id, data: data);
  }
}
