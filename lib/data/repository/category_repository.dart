import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furnitureshop_appadmin/data/models/category.dart';
import 'package:furnitureshop_appadmin/data/servers/category_api_server.dart';

class CategoryRepository {
  CategoryAPIServer categoryAPIServer = CategoryAPIServer();

  Future<void> addNewImage(MyCategory category) async {
    Map<String, dynamic> data = category.toJson();
    await categoryAPIServer.addImageCategory(data);
  }

  Future<void> addNewCategory(MyCategory category) async {
    category.name = format(category.name.toString());
    category.path = getPath(category.name.toString());
    Map<String, dynamic> data = category.toJson();
    await categoryAPIServer.addCategory(data);
  }

  Future<void> deletedImageCategory(String id) async {
    await categoryAPIServer.deleteImageCategory(id);
  }

  Future<List<MyCategory>> getImageCategories() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('image_category');
    List<MyCategory> categories = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      categories = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyCategory a = MyCategory.fromJson(data, doc.id);
          return a;
        }
        return MyCategory();
      }).toList();
    });
    return categories;
  }

  Future<List<MyCategory>> getCategories() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('category');
    List<MyCategory> categories = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      categories = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyCategory a = MyCategory.fromJson(data, doc.id);
          return a;
        }
        return MyCategory();
      }).toList();
    });
    return categories;
  }

  String format(String st) {
    String re = st.trim();
    re = re.replaceAll("  ", " ");
    return re;
  }

  String getPath(String st) {
    String re = st.trim();
    re = re.toLowerCase();
    re = re.replaceAll("  ", " ");
    re = re.replaceAll(" ", "_");
    return re;
  }
}
