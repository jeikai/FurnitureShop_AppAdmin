import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/guarantee.dart';
import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/models/user_profile.dart';
import 'package:get/get.dart';

class GuaranteeDetailController extends GetxController {
  List<Guarantee> totalGuarantee = [];
  List<Guarantee> guarantees = [
    Guarantee(
        imagePath: [
          'https://firebasestorage.googleapis.com/v0/b/furnitureapp-27389.appspot.com/o/image_product%2Fdouble_bed%2F8b7Dfc3RJkVhoAZ%2Freceived_940785973609906.webp?alt=media&token=a3f4c1f6-77c3-444d-854e-ea0af1e53663'
        ],
        Error: "jdfhd dbfjdfhd fhdgfdf sfudgfdf shgfdg",
        orderID: '',
        productID: '',
        product: Product(imagePath: [
          'https://firebasestorage.googleapis.com/v0/b/furnitureapp-27389.appspot.com/o/image_product%2Fdouble_bed%2F8b7Dfc3RJkVhoAZ%2Freceived_940785973609906.webp?alt=media&token=a3f4c1f6-77c3-444d-854e-ea0af1e53663'
        ], name: "Armchair", price: 699.0),
        userID: '',
        user: UserProfile(
            name: "Thu Hien",
            avatarPath:
                'https://firebasestorage.googleapis.com/v0/b/furnitureapp-27389.appspot.com/o/image_product%2Fdouble_bed%2F8b7Dfc3RJkVhoAZ%2Freceived_940785973609906.webp?alt=media&token=a3f4c1f6-77c3-444d-854e-ea0af1e53663'))
  ];
  TextEditingController noteController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
}
