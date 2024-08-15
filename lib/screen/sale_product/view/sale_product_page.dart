import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:furnitureshop_appadmin/data/models/product_store.dart';
import 'package:furnitureshop_appadmin/screen/choose_product/view/choose_product_page.dart';
import 'package:furnitureshop_appadmin/screen/sale_product/controller/sale_product_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/discount.dart';
import '../../../data/values/colors.dart';
import '../../../data/values/fonts.dart';
import '../../../data/values/images.dart';
import '../../../data/values/strings.dart';
import '../../discount_detail/view/discount_detail_page.dart';

class SaleProductPage extends GetView<SaleProductController> {
  const SaleProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaleProductController>(
      builder: (value) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: _appBarButtom(context),
        body: _bodyContents(),
      ),
    );
  }

  AppBar _appBarButtom(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      title: SizedBox(
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.only(left: Get.width / 4),
          child: const Text(
            "Sale Product",
            style: TextStyle(
              fontFamily: 'jose_fin_sans',
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _bodyContents() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            infor(),
            const SizedBox(height: 16.0),
            _buildCustomerTextField("Name Customer", controller.nameController),
            const SizedBox(height: 16.0),
            _buildCustomerTextField("Phone", controller.phoneController,
                inputType: TextInputType.phone, maxlength: 10),
            const SizedBox(height: 16.0),
            _buildCustomerTextField("Address", controller.addressController),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text(
                  "Product",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: buttonColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () async {
                      var resuld = await Get.to(const ChooseProductPage());
                      if (resuld != null) {
                        controller.addProductCard(resuld);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            (controller.productList.isEmpty)
                ? SizedBox(height: Get.height * 0.01)
                : SizedBox(
              height: Get.height * 0.32,
              child: GetBuilder<SaleProductController>(
                builder: (controller) => ListView.builder(
                  itemCount: controller.productList.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              controller.removeProduct(index);
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: _buildProductCard(index),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.codeDiscount,
                    decoration: const InputDecoration(
                      labelText: 'Enter Discount Code',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                SizedBox(
                  height: Get.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.checkDiscount();
                    },
                    style: ElevatedButton.styleFrom(
                      // primary: buttonColor, // Set the background color to red
                    ),
                    child: const Text('Check'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            if (controller.discount != null)
              buildDiscount(controller.discount!),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Price order:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "\$${controller.priceOrder.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Discount:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "\$${controller.priceDiscount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total price:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "\$${(controller.priceOrder - controller.priceDiscount).toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _buttomCustom(),
          ],
        ),
      ),
    );
  }

  Column buildDiscount(MyDiscount discount) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              color: buttonColor,
              margin: EdgeInsets.only(
                  bottom: Get.height * 0.02,
                  top: Get.height * 0.005,
                  right: Get.height * 0.025,
                  left: Get.height * 0.025),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(Get.height * 0.0124),
                        height: Get.height * 0.1,
                        width: Get.height * 0.1,
                        color: Colors.white,
                        child: Image.asset(dis20),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: Get.height * 0.28,
                            child: Text(
                              discount.name.toString(),
                              overflow: TextOverflow.ellipsis,
                              //maxLines: 2,
                              style: TextStyle(
                                fontSize: Get.height * 0.025,
                                color: Colors.white,
                                fontFamily: jose_fin_sans,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Text(
                            'Effective : ${DateFormat('dd-MM-yyyy').format(discount.timeStart ?? DateTime.now())}  -  ${DateFormat('dd-MM-yyyy').format(discount.timeEnd ?? DateTime.now())}',
                            style: TextStyle(
                              fontSize: Get.height * 0.016,
                              color: Colors.white,
                              fontFamily: jose_fin_sans,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.012),
                          Row(
                            children: [
                              SizedBox(
                                width: Get.height * 0.2,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(const DiscountDetailPage(),
                                      arguments: {'discount': discount});
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      view_detail,
                                      style: TextStyle(
                                        fontSize: Get.height * 0.014,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(
                                      Icons.navigate_next_rounded,
                                      color: Colors.white,
                                      size: Get.height * 0.019,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: textGreenColor,
              margin: EdgeInsets.only(
                  // top: Get.height * 0.19,
                  left: Get.height * 0.02,
                  right: Get.height * 0.0124),
              width: Get.height * 0.075,
              height: Get.height * 0.0187,
              child: Text(
                'Limited',
                style: TextStyle(
                  fontSize: Get.height * 0.015,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductCard(int index) {
    ProductStore productStore = controller.productList[index];
    int number = controller.number[index];
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Container(
            width: 130,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              image: DecorationImage(
                image: NetworkImage(productStore.imagePath![0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  productStore.name.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Price: \$' + productStore.price.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (number > 1) {
                              controller.number[index]--;
                              controller.priceOrder -= productStore.price;
                              controller.updatePriceDiscount();
                            }
                          },
                        ),
                        Text(
                          number.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            if (number < productStore.number) {
                              controller.number[index]++;
                              controller.priceOrder += productStore.price;
                              controller.updatePriceDiscount();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Color: ',
                      style: TextStyle(fontSize: 14),
                    ),
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: productStore.imageColorTheme,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  'Number in store: ${productStore.number}',
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerTextField(String label, TextEditingController controller,
      {TextInputType? inputType, int? maxlength}) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      maxLength: maxlength,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget infor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            controller.admin.name.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        _buildDateTimeText(),
      ],
    );
  }

  Widget _buildDateTimeText() {
    String formattedTime = DateFormat('hh:mm a').format(controller.now);
    return Row(
      children: [
        const Text(
          'Date time: ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(DateFormat('MMM d, yyyy').format(controller.now)),
        const SizedBox(width: 5.0),
        Text(formattedTime),
      ],
    );
  }

  Widget buildDiscountCodeContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: const [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter discount code',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttomCustom() {
    return InkWell(
      onTap: () {
        controller.clickSubmitButton();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: Get.width,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: ColorShadow,
                blurRadius: 10,
                spreadRadius: 4,
              )
            ]),
        child: Text(
          "Post Now",
          //controller.load == false ?  "Loading...":
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: Get.width * 0.051,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
    );
  }
}
