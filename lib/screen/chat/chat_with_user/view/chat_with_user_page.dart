import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/values/images.dart';
import 'package:furnitureshop_appadmin/data/models/message_model.dart';
import 'package:furnitureshop_appadmin/screen/chat/chat_with_user/controller/chat_with_user_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatWithUserPage extends GetView<ChatWithUserController> {
  const ChatWithUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatWithUserController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: Column(
                children: <Widget>[
                  SizedBox(
                    height: Get.height * 0.012,
                  ),
                  _buildStreamChat(),
                  sendMessageArea(context),
                  SizedBox(
                    height: Get.height * 0.024,
                  )
                ],
              ),
            ));
  }

  Stream<QuerySnapshot> _roomStream(String id) => FirebaseFirestore.instance.collection('chatroom').doc(id).collection('message').orderBy('time', descending: true).snapshots();

  Expanded _buildStreamChat() {
    if (controller.user.id.toString().trim() == "") return Expanded(child: Container());
    return Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: _roomStream(controller.user.id),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print('ERROR Steam chat product: ${snapshot.hasError}');
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.black,
                  size: 30,
                ));
              }
              return ListView(
                reverse: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  Message message = Message.fromMap(data);
                  if (message.productId != null) {
                    return _chatProduct(context, message);
                  }
                  return _chatMessage(context, message);
                }).toList(),
              );
            }));
  }

  Widget productInfo() {
    return Container(
      padding: EdgeInsets.all(Get.height * 0.023),
      height: Get.height * 0.166,
      width: Get.height * 0.414,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(Get.height * 0.023)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 7,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          imageCustom(),
          SizedBox(
            width: Get.height * 0.023,
          ),
          nameProductCustom(),
        ],
      ),
    );
  }

  Column nameProductCustom() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: Get.height * 0.225,
          child: Text(
            'Compass Chair (Letter A) Natural Oak',
            style: TextStyle(
              fontSize: Get.height * 0.023,
              color: textGrey2Color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: Get.height * 0.225,
          child: Text(
            "\$ 180 ",
            style: TextStyle(
              fontFamily: jose_fin_sans,
              fontSize: Get.height * 0.029,
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  SizedBox imageCustom() {
    return SizedBox(
      height: Get.height * 0.118,
      width: Get.height * 0.118,
      child: Stack(children: [
        Positioned(
            child: SizedBox(
                height: Get.height * 0.118,
                width: Get.height * 0.118,
                child: Container(
                  height: Get.height * 0.118,
                  width: Get.height * 0.118,
                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(product1), fit: BoxFit.contain)),
                ))),
      ]),
    );
  }

  Widget sendMessageArea(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.height * 0.009),
      height: Get.height * 0.083,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.height * 0.059), color: Colors.white, border: Border.all(color: buttonColor)),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.photo,
              color: buttonColor,
            ),
            iconSize: Get.height * 0.029,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: controller.messageText,
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: buttonColor,
            ),
            iconSize: Get.height * 0.029,
            onPressed: () {
              controller.sendMessage();
            },
          ),
        ],
      ),
    );
  }

  Widget _chatMessage(BuildContext context, Message message) {
    return Column(
      children: <Widget>[
        Container(
          alignment: message.isAdmin ? Alignment.topRight : Alignment.topLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.80,
            ),
            padding: EdgeInsets.all(Get.height * 0.012),
            margin: EdgeInsets.symmetric(vertical: Get.height * 0.005),
            decoration: BoxDecoration(
              color: message.isAdmin ? buttonColor : Colors.white,
              borderRadius: BorderRadius.circular(Get.height * 0.018),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Text(
              message.content.toString(),
              style: TextStyle(
                color: message.isAdmin ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        // if (index == controller.message.length - 1 || controller.message[index + 1].isAdmin != message.isAdmin) message.isAdmin ? _buildTimeAdmin(message) : _buildTimeUser(message)
      ],
    );
  }

  Widget _chatProduct(BuildContext context, Message message) {
    return Column(
      children: <Widget>[
        Container(
          alignment: message.isAdmin ? Alignment.topRight : Alignment.topLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.80,
            ),
            padding: EdgeInsets.all(Get.height * 0.012),
            margin: EdgeInsets.symmetric(vertical: Get.height * 0.005),
            decoration: BoxDecoration(
              color: message.isAdmin ? buttonColor : Colors.white,
              borderRadius: BorderRadius.circular(Get.height * 0.018),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Container(
                height: 50,
                width: 100,
                child: (message.productImage != null)
                    ? Image.network(
                        message.productImage!,
                        fit: BoxFit.contain,
                      )
                    : SizedBox(),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.productName.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: jose_fin_sans,
                        fontSize: 14,
                        color: textGrey2Color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "\$ ${message.productPrice}",
                      style: TextStyle(
                        fontFamily: jose_fin_sans,
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
        // if (index == controller.message.length - 1 || controller.message[index + 1].isAdmin != message.isAdmin) message.isAdmin ? _buildTimeAdmin(message) : _buildTimeUser(message)
      ],
    );
  }

  Row _buildTimeUser(Message message) {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: Get.height * 0.018,
            backgroundImage: const AssetImage(avatar2),
          ),
        ),
        SizedBox(
          width: Get.height * 0.012,
        ),
        Text(
          DateFormat('Hm').format(message.time),
          style: TextStyle(
            fontSize: Get.height * 0.014,
            color: Colors.black45,
          ),
        ),
      ],
    );
  }

  Row _buildTimeAdmin(Message message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          DateFormat('Hm').format(message.time),
          style: TextStyle(
            fontSize: Get.height * 0.014,
            color: Colors.black45,
          ),
        ),
        SizedBox(
          width: Get.height * 0.012,
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: const CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage(avatar1),
          ),
        ),
      ],
    );
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: buttonColor,
      title: Text(
        controller.user.name.toString(),
        style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black),
      ),
      leading: SizedBox(
        height: Get.height * 0.01,
        width: Get.width * 0.01,
        child: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.black,
          onPressed: () {},
        ),
      ],
    );
  }
}
