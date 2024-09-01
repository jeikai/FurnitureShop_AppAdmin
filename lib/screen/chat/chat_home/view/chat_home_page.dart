import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furnitureshop_appadmin/data/models/user_profile.dart';
import 'package:furnitureshop_appadmin/data/values/colors.dart';
import 'package:furnitureshop_appadmin/data/values/fonts.dart';
import 'package:furnitureshop_appadmin/data/models/message_model.dart';
import 'package:furnitureshop_appadmin/data/values/images.dart';
import 'package:furnitureshop_appadmin/screen/chat/chat_home/controller/chat_home_controller.dart';
import 'package:furnitureshop_appadmin/screen/chat/chat_with_user/view/chat_with_user_page.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/intl.dart';

class ChatHomePage extends GetView<ChatHomeController> {
  ChatHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatHomeController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: _buildBody(),
            ));
  }

  final Stream<QuerySnapshot> _roomStream = FirebaseFirestore.instance.collection('chatroom').orderBy('time', descending: true).snapshots();

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: _roomStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('ERROR Steam chat room: ${snapshot.hasError}');
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
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              Message chat = Message.fromMap(data);
              return _buildItem(chat, context);
            }).toList(),
          );
        });
  }

  GestureDetector _buildItem(Message chat, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ChatWithUserPage(),
            arguments: UserProfile(
              id: chat.userID.toString(),
              name: chat.userName.toString(),
              avatarPath: chat.userAvataPath.toString(),
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Get.height * 0.024,
          vertical: Get.height * 0.018,
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(Get.height * 0.002),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(avatar1),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.65,
              padding: EdgeInsets.only(
                left: Get.height * 0.024,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        chat.userName ?? "",
                        style: TextStyle(
                          fontSize: Get.height * 0.019,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(chat.time),
                        style: TextStyle(
                          fontSize: Get.height * 0.013,
                          fontWeight: FontWeight.w300,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.012,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      chat.productId == null ? chat.content.toString() : "Send a product",
                      style: TextStyle(
                        fontSize: Get.height * 0.018,
                        color: Colors.black54,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: buttonColor,
      title: Text(
        'Chat with customer',
        style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w700, fontSize: Get.height * 0.021, color: Colors.black),
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
      // actions: <Widget>[
      //   IconButton(
      //     icon: const Icon(Icons.search),
      //     color: Colors.black,
      //     onPressed: () {},
      //   ),
      // ],
    );
  }
}
