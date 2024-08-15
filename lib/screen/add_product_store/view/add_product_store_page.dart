import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/screen/item_product/view/item_product_page.dart';
import 'package:get/get.dart';
import '../../../data/values/colors.dart';
import '../controller/add_product_store_controller.dart';

class AddStoreOptionState extends State<AddStoreOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 2 / 3,
        margin: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(widget.product.imagePath!.first.toString()), fit: BoxFit.cover)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Price:${widget.product.price}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: buttonColor,
            ),
            Text(
              "Color",
              style: TextStyle(fontSize: 20),
            ),
            colorCustom(),
            Text(
              "Amount",
              style: TextStyle(fontSize: 20),
            ),
            amountCustom(),
            SizedBox(
              height: 5,
            ),
            buttonCustom(),
            SizedBox(
              height: 10,
            )
          ]),
        ),
      ),
    );
  }

  TextEditingController amountEditting = TextEditingController();

  Widget amountCustom() {
    return TextField(
      controller: amountEditting,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: Get.height * 0.024,
      ),
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: buttonColor),
        ),
        hintText: 'Enter amount ... ',
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.grey,
          fontSize: Get.height * 0.024,
        ),
      ),
    );
  }

  Widget colorCustom() {
    List<Widget> items = [];
    for (int i = 0; i < (widget.product.imageColorTheme ?? []).length; i++) {
      items.add(colorWidget(i, i == widget.chooseColor, widget.product.imageColorTheme![i]));
      items.add(SizedBox(
        width: 10,
      ));
    }
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: items,
        ),
      ),
    );
  }

  Widget colorWidget(int index, bool onSelectedColor, Color title) {
    return InkWell(
      onTap: () {
        setState(() {
          if (onSelectedColor == false) widget.chooseColor = index;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: title.withAlpha(150),
            child: onSelectedColor
                ? CircleAvatar(
                    radius: 15,
                    backgroundColor: title,
                    child: Icon(
                      Icons.check,
                    ),
                  )
                : CircleAvatar(radius: 15, backgroundColor: title),
          ),
        ],
      ),
    );
  }

  Widget sizeCustom() {
    List<Widget> items = [];
    // for (int i = 0; i < widget.sizes.length; i++) {
    //   items.add(sizeWidget(i, i == widget.sizes.first, widget.sizes[i]));
    //   items.add(SizedBox(
    //     width: 10,
    //   ));
    // }
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // sizeWidget(widget.sizes[0])
          ],
        ),
      ),
    );
  }

  Widget sizeWidget(String title) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                //border: Border.all(color: Colors.grey),
                color: true ? buttonColor : Color.fromARGB(255, 207, 207, 207),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              title.toString(),
              style: TextStyle(color: true ? Colors.black : Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget buttonCustom() {
    return InkWell(
      onTap: () async {
        await widget.AddProductStore(amountEditting, context);
      },
      child: Container(
        margin: EdgeInsets.only(left: 80, right: 80, top: 30),
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor,
        ),
        child: Text(
          widget.load.value ? "LOADING..." : "ADD TO STORE",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
    );
  }
}
