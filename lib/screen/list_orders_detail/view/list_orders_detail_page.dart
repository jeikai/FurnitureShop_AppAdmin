import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/product.dart';
import 'package:furnitureshop_appadmin/data/repository/order_repository.dart';
import 'package:furnitureshop_appadmin/data/values/strings.dart';
import 'package:furnitureshop_appadmin/screen/list_orders_detail/controller/list_orders_detail_controller.dart';
import 'package:get/get.dart';
import '../../../data/values/colors.dart';
import 'package:intl/intl.dart';

class ListOrderDetail extends GetView<ListOrderDetailController> {
  const ListOrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListOrderDetailController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: _appBar(),
              body: _bodyContent(
                context,
              ),
            ));
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          }),
      backgroundColor: backgroundColor,
      title: Text(
        titleDetailsProduct,
        style: TextStyle(
          fontSize: Get.height * 0.031,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _bodyContent(
    BuildContext context,
  ) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(thickness: 5),
            Container(
              height: Get.height * 0.052,
              margin: EdgeInsets.only(left: Get.height * 0.017, right: Get.height * 0.017),
              child: Row(
                children: [
                  Text(
                    controller.order.id.toString(),
                    style: TextStyle(
                      fontSize: Get.height * 0.024,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    OrderRepository().statusOrderToString(controller.order),
                    style: TextStyle(fontSize: Get.height * 0.024, fontWeight: FontWeight.w400, color: controller.getColorStatus()),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 5),
            _titleContent(titleName, controller.user.name.toString()),
            _titleContent(
              titleAddress,
              controller.order.address.fullAddress,
              maxLine: 2,
            ),
            _titleContent(
              titleHotline,
              controller.order.address.phoneNumber,
            ),
            _product(),
            _date(),
            _titleContent(titlePriceTo, '\$${controller.order.priceTotal.toString()}'),
            _payment(),
          ],
        ),
      ),
    );
  }

  Container _pictureContent(String imagePath) {
    return Container(
      margin: EdgeInsets.all(Get.height * 0.009),
      height: Get.height * 0.122,
      width: Get.height * 0.122,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Get.height * 0.017),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _product() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: Get.height * 0.026, right: Get.height * 0.026, top: Get.height * 0.003),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Products',
                style: TextStyle(fontSize: Get.height * 0.021, fontWeight: FontWeight.w500),
              ),
              if (controller.products.length > 0)
                Container(
                  height: Get.height * 0.229,
                  width: Get.width,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: controller.products.length,
                      itemBuilder: (BuildContext context, int itemIndex) {
                        return textProduct(itemIndex, controller.products[itemIndex]);
                      }),
                ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Container textProduct(int index, Product product) {
    return Container(
      margin: EdgeInsets.all(Get.height * 0.003),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: buttonColor)),
      padding: EdgeInsets.all(Get.height * 0.017),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ID: ${product.id}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: Get.height * 0.019, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _pictureContent(product.imagePath!.first.toString()),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name.toString(),
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: Get.height * 0.009,
                    ),
                    Text(
                      'Price: ' + '\$${product.price}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      'Amount: ${controller.order.carts[index].amount}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      'Size: ${product.weight}x${product.width}x${product.length}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Color: ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Row(
                          children: List.generate(
                            product.imageColorTheme?.length ?? 0,
                            (index) => Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: product.imageColorTheme![index],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _date() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: Get.height * 0.026, right: Get.height * 0.026, top: Get.height * 0.003),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date',
                style: TextStyle(fontSize: Get.height * 0.021, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              Column(
                children: List.generate(
                  OrderRepository().statusOrderToInt(controller.order),
                  (index) => textDate(index),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Row textDate(int index) {
    return Row(
      children: [
        Text(controller.order.status[index].status),
        const Spacer(),
        Text(
          "${DateFormat('H:m dd-MM-yyyy').format(controller.order.status[index].date ?? DateTime.now())}",
          style: TextStyle(fontSize: Get.height * 0.019, fontWeight: FontWeight.w700),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _titleContent(String title, String content, {int maxLine = 1}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: Get.height * 0.026, right: Get.height * 0.026, top: Get.height * 0.003),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: Get.height * 0.021, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  content,
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: Get.height * 0.019, fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                  maxLines: maxLine,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _payment() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: Get.height * 0.026, right: Get.height * 0.026, top: Get.height * 0.003),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    payment,
                    style: TextStyle(fontSize: Get.height * 0.021, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                    controller.order.paymentInCash == false ? cash_payment : card_payment,
                    style: TextStyle(fontSize: Get.height * 0.019, fontWeight: FontWeight.w700, color: Colors.orange),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
