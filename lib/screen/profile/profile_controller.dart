import 'package:furnitureshop_appadmin/data/models/account_admin.dart';
import 'package:furnitureshop_appadmin/data/repository/admin_repository.dart';
import 'package:furnitureshop_appadmin/data/repository/user_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Admin ad = Admin(name: "", email: "");

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    ad = await AdminRepository().getUserProfile();
    update();
  }
}
