import 'package:furnitureshop_appadmin/data/servers/base_api_server.dart';

class CategoryAPIServer {
  final String imageCategoryURL = "/image_category";
  final String categoryURL = "/category";

  static BaseAPIServer api = BaseAPIServer();

  String getIdImageCategory(String imagePath) {
    String re = imagePath;
    re = re.replaceAll('assets/category/icons8-', '');
    re = re.replaceAll('-50.png', '');
    re = re.replaceAll('-', '_');
    return re;
  }

  Future<void> addImageCategory(Map<String, dynamic> data) async {
    await api.set(
        url: imageCategoryURL,
        data: data,
        id: getIdImageCategory(data['image_path']));
  }

  Future<void> deleteImageCategory(String id) async {
    await api.delete(url: imageCategoryURL, id: id);
  }

  Future<void> addCategory(Map<String, dynamic> data) async {
    await api.set(url: categoryURL, id: data["path"], data: data);
  }
}
