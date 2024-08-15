import 'package:get/get.dart';

class DetailsProductController extends GetxController {
  DetailsModelDemo demo = DetailsModelDemo(
    id: '#DH26986987',
    nameClient: 'Nguyễn Trọng Nhân',
    status: 1,
    address: '1020, Lê Trọng Tấn,, 1020, Lê  ',
    hotline: '02929292222',
    nameProduct: 'Ghế',
    detailContent: 'Lorem text, ispum lorem text',
    estimatedTimeDelivery: DateTime.now(),
    startTimeDelivery: DateTime.now(),
    endTimeDelivery: DateTime.now(),
    price: 200.0,
    dayGuarentee: 1,
  );

  // ignore: non_constant_identifier_names
  void OnInit() {
    super.onInit();
    //Using When New Function
  }

  String swapStatus(int status) {
    String titleStatus = '';
    if (status == 1) {
      titleStatus = 'Chờ Xác Nhận';
      return titleStatus;
    } else if (status == 2) {
      titleStatus = 'Đang giao hàng';
      return titleStatus;
    } else {
      titleStatus = titleStatus;
      return titleStatus;
    }
  }
}

class DetailsModelDemo {
  String id;
  String nameClient;
  int status;
  String address;
  String hotline;
  String nameProduct;
  String detailContent;
  DateTime estimatedTimeDelivery;
  DateTime startTimeDelivery;
  DateTime endTimeDelivery;
  double price;
  int dayGuarentee;
  DetailsModelDemo({
    required this.id,
    required this.nameClient,
    required this.status,
    required this.address,
    required this.hotline,
    required this.nameProduct,
    required this.detailContent,
    required this.estimatedTimeDelivery,
    required this.startTimeDelivery,
    required this.endTimeDelivery,
    required this.price,
    required this.dayGuarentee,
  });
}
