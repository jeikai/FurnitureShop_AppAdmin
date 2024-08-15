import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/auth/auth_wapper.dart';
import 'package:furnitureshop_appadmin/screen/add_category/controller/add_category_controller.dart';
import 'package:furnitureshop_appadmin/screen/add_discount/controller/add_discount_controller.dart';
import 'package:furnitureshop_appadmin/screen/add_staff/controller/add_staff_controller.dart';
import 'package:furnitureshop_appadmin/screen/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:furnitureshop_appadmin/screen/chat/chat_with_user/controller/chat_with_user_controller.dart';
import 'package:furnitureshop_appadmin/screen/choose_product/controller/choose_product_controller.dart';
import 'package:furnitureshop_appadmin/screen/dashboard/controller/dashboard_controller.dart';
import 'package:furnitureshop_appadmin/screen/discount_detail/controller/discount_detail_controller.dart';
import 'package:furnitureshop_appadmin/screen/edit_product/controller/edit_product_controller.dart';
import 'package:furnitureshop_appadmin/screen/edit_profile/view/edit_profile_page.dart';
import 'package:furnitureshop_appadmin/screen/item_category/controller/item_category_controller.dart';
import 'package:furnitureshop_appadmin/screen/item_product/controller/item_product_controller.dart';
import 'package:furnitureshop_appadmin/screen/list_orders_detail/controller/list_orders_detail_controller.dart';
import 'package:furnitureshop_appadmin/screen/login/controller/login_controller.dart';
import 'package:furnitureshop_appadmin/screen/management_category/controller/management_category_controller.dart';
import 'package:furnitureshop_appadmin/screen/management_discount/controller/managemnet_discount_controller.dart';
import 'package:furnitureshop_appadmin/screen/details_products/controller/details_product_controller.dart';
import 'package:furnitureshop_appadmin/screen/management_guarantee/controller/guarantee_controller.dart';
import 'package:furnitureshop_appadmin/screen/list_orders/controller/list_order_controller.dart';
import 'package:furnitureshop_appadmin/screen/management_product_store/controller/list_product_store_controller.dart';
import 'package:furnitureshop_appadmin/screen/management_review/controller/all_review_controller.dart';
import 'package:furnitureshop_appadmin/screen/order_request/controller/order_request_controller.dart';
import 'package:furnitureshop_appadmin/screen/order_request_detail/controller/order_request_detail_controller.dart';
import 'package:furnitureshop_appadmin/screen/password/change_password/change-password_controller.dart';
import 'package:furnitureshop_appadmin/screen/profile/profile_controller.dart';
import 'package:furnitureshop_appadmin/screen/splash/controller/splash_controller.dart';
import 'package:get/get.dart';
import 'package:furnitureshop_appadmin/screen/setting/controller/setting_controller.dart';
import 'screen/chat/chat_home/controller/chat_home_controller.dart';
import 'screen/guarantee_details/controller/guarantee_detail_controller.dart';
import 'screen/reply_review/controller/reply_review_controller.dart';
import 'screen/sale_product/controller/sale_product_controller.dart';
import 'screen/upload_products/controller/upload_products_controller.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Furniture App Admin',
      home: const AuthWrapper(),
      initialBinding: _Binding(),
    );
  }
}

class _Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
    Get.lazyPut<ListOrderController>(() => ListOrderController(), fenix: true);
    Get.lazyPut<GuaranteeController>(() => GuaranteeController(), fenix: true);
    Get.lazyPut<OrderRequestDetailController>(
        () => OrderRequestDetailController(),
        fenix: true);
    Get.lazyPut<DetailsProductController>(() => DetailsProductController(),
        fenix: true);
    Get.lazyPut<BottomBarController>(() => BottomBarController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<ChatHomeController>(() => ChatHomeController(), fenix: true);
    Get.lazyPut<ChatWithUserController>(() => ChatWithUserController(),
        fenix: true);
    Get.lazyPut<ManagementDiscountController>(
        () => ManagementDiscountController(),
        fenix: true);
    Get.lazyPut<DiscountDetailController>(() => DiscountDetailController(),
        fenix: true);
    Get.lazyPut<AddDiscountController>(() => AddDiscountController(),
        fenix: true);
    Get.lazyPut<ManagementCategoryController>(
        () => ManagementCategoryController(),
        fenix: true);
    Get.lazyPut<ItemProductController>(() => ItemProductController(),
        fenix: true);
    Get.lazyPut<ItemCategoryController>(() => ItemCategoryController(),
        fenix: true);
    Get.lazyPut<UploadProductsController>(() => UploadProductsController(),
        fenix: true);
    Get.lazyPut<ChooseProductController>(() => ChooseProductController(),
        fenix: true);
    Get.lazyPut<AddCategoryController>(() => AddCategoryController(),
        fenix: true);
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController(),
        fenix: true);
    Get.lazyPut<ChatWithUserController>(() => ChatWithUserController(),
        fenix: true);
    Get.lazyPut<ManagementDiscountController>(
        () => ManagementDiscountController(),
        fenix: true);
    Get.lazyPut<SaleProductController>(() => SaleProductController(),
        fenix: true);
    Get.lazyPut<DiscountDetailController>(() => DiscountDetailController(),
        fenix: true);
    Get.lazyPut<AddDiscountController>(() => AddDiscountController(),
        fenix: true);
    Get.lazyPut<ManagementCategoryController>(
        () => ManagementCategoryController(),
        fenix: true);
    Get.lazyPut<ItemProductController>(() => ItemProductController(),
        fenix: true);
    Get.lazyPut<ItemCategoryController>(() => ItemCategoryController(),
        fenix: true);
    Get.lazyPut<UploadProductsController>(() => UploadProductsController(),
        fenix: true);
    Get.lazyPut<AddCategoryController>(() => AddCategoryController(),
        fenix: true);
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController(),
        fenix: true);
    Get.lazyPut<DashBoardController>(() => DashBoardController(), fenix: true);
    Get.lazyPut<OrderRequestController>(() => OrderRequestController(),
        fenix: true);
    Get.lazyPut<DashBoardController>(() => DashBoardController(), fenix: true);
    Get.lazyPut<EditProductController>(() => EditProductController(),
        fenix: true);
    Get.lazyPut<GuaranteeDetailController>(() => GuaranteeDetailController(),
        fenix: true);
    Get.lazyPut<AllReviewController>(() => AllReviewController(), fenix: true);
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
    Get.lazyPut<ReplyReviewController>(() => ReplyReviewController(),
        fenix: true);
    Get.lazyPut<ManagementProductStoreController>(
        () => ManagementProductStoreController(),
        fenix: true);
    Get.lazyPut<AddStaffController>(() => AddStaffController(), fenix: true);
    Get.lazyPut<ListOrderDetailController>(() => ListOrderDetailController(),
        fenix: true);
    Get.lazyPut<EditProfilePage>(() => const EditProfilePage(), fenix: true);
  }
}
