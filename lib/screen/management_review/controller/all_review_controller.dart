import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/models/review.dart';
import 'package:furnitureshop_appadmin/data/models/user_profile.dart';
import 'package:furnitureshop_appadmin/data/repository/review_repository.dart';
import 'package:get/get.dart';

class AllReviewController extends GetxController {
  bool load = true;
  List<Review> reviews = [];

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    reviews = await ReviewRepository().getReviews();
    load = false;
    update();
  }
}
