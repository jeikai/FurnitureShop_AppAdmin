import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/product_store.dart';
import 'package:get/get.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/screen/choose_product/controller/choose_product_controller.dart';

class ChooseProductPage extends GetView<ChooseProductController> {
  const ChooseProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChooseProductController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              body: SafeArea(child: _buildBodyContent(context)),
            ));
  }

  Widget _buildBodyContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        _buildHeader(context),
        Expanded(
          child: _buildProductList(context),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              controller.back();
            },
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                controller.search(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    final List<ProductStore> productList = controller.productList;

    if (productList.isEmpty) {
      return const Center(
        child: Text('Loading...'),
      );
    }

    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // controller.toggleProductSelection(product);
          },
          child: _buildProductCard(index),
        );
      },
    );
  }

  Widget _buildProductCard(int index) {
    ProductStore product = controller.productList[index];
    bool check = controller.check[index];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 50,
            width: 100,
            child: Image(image: NetworkImage(product.imagePath?[0] ?? '')),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Amount: ',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Text(
                      product.number.toString(),
                      style: TextStyle(fontSize: 14.0),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Color: ',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: product.imageColorTheme,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: check ? buttonColor.withAlpha(50) : buttonColor,
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
              icon: check ? Icon(Icons.check) : Icon(Icons.add),
              color: check ? Colors.green : Colors.white,
              onPressed: () {
                controller.chooseProduct(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
