import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shop_zone/user/global/global.dart';
import 'package:shop_zone/user/models/cart.dart';
import 'package:shop_zone/user/userPreferences/current_user.dart';
import '../../api_key.dart';
import '../sellersScreens/home_screen.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class PlaceOrderScreen extends StatefulWidget {
  String? addressID;
  int? totalAmount;
  String? sellerUID;
  String? cartId;
  Carts? model;

  PlaceOrderScreen({
    this.addressID,
    this.totalAmount,
    this.cartId,
    this.model,
  });

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  String orderId = DateTime.now().millisecondsSinceEpoch.toString();
  final CurrentUser currentUserController = Get.put(CurrentUser());

  late String userName;
  late String userEmail;
  late String userID;
  //! save the order
Future<bool> saveOrderToBackend(Map<String, dynamic> orderData) async {
    var response = await http.post(
      Uri.parse(API.saveOrder),
      body: jsonEncode(orderData),
      headers: {"Content-Type": "application/json"},
    );

    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      if (!data["success"]) {
        print("Server Error: ${data['message']}");
      }
      return data["success"];
      
    } else {
      print("HTTP Error: ${response.statusCode}");
      return false;
    }
}


  //!delete item from the cart list
  Future<void> removeItemFromCart() async {
    final response = await http.post(
      Uri.parse(API.deleteItemFromCart),
      body: {
        'userId': userID,
        'itemId': widget.model?.itemID,
      },
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Item removed successfully!');
    } else {
      Fluttertoast.showToast(msg: 'Failed to remove item. Please try again.');
    }
  }

  orderDetails() async {
    print("Order Details");
    print(widget.model?.itemID);
    bool isSaved = await saveOrderToBackend({
      "addressID": widget.addressID,
      "totalAmount": widget.model?.totalPrice,
      "orderBy": userID,
      "productIDs": widget.model?.cartId,
      "paymentDetails": "Cash On Delivery",
      "orderTime": DateTime.now().toString().split('.')[0], // Format: 2023-08-25 10:40:32
      "orderId": orderId,
      "isSuccess": true,
      "sellerUID": widget.model?.sellerUID,
      "status": "normal",
      "itemQuantity": widget.model?.itemCounter,
      "itemID":  widget.model?.itemID,
    });

    if (isSaved) {
      //send push notification to seller about new order which placed by user
      sendNotificationToSeller(
        widget.sellerUID.toString(),
        orderId,
      );
      removeItemFromCart();
      Fluttertoast.showToast(
          msg: "Congratulations, Order has been placed successfully.");

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));

      orderId = "";
    } else {
      Fluttertoast.showToast(msg: "Error saving order");
    }
  }

  sendNotificationToSeller(sellerUID, userOrderID) async {
    String sellerDeviceToken = "";

    // await FirebaseFirestore.instance
    //     .collection("sellers")
    //     .doc(sellerUID)
    //     .get()
    //     .then(
    //   (snapshot) {
    //     if (snapshot.data()!["sellerDeviceToken"] != null) {
    //       sellerDeviceToken = snapshot.data()!["sellerDeviceToken"].toString();
    //     }
    //   },
    // );

    notificationFormat(
      sellerDeviceToken,
      userOrderID,
      sharedPreferences!.getString("name"),
    );
  }

  notificationFormat(sellerDeviceToken, getUserOrderID, userName) {
    Map<String, String> headerNotification = {
      'Content-Type': 'application/json',
      'Authorization': fcmServerToken,
    };

    Map bodyNotification = {
      'body':
          "Dear seller, New Order (# $getUserOrderID) has placed Successfully from user $userName. \nPlease Check Now",
      'title': "New Order",
    };

    Map dataMap = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "userOrderId": getUserOrderID,
    };

    Map officialNotificationFormat = {
      'notification': bodyNotification,
      'data': dataMap,
      'priority': 'high',
      'to': sellerDeviceToken,
    };

    http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(officialNotificationFormat),
    );
  }

  @override
  void initState() {
    super.initState();
    currentUserController.getUserInfo().then((_) {
      setUserInfo();
      // Once the seller info is set, call setState to trigger a rebuild.
      setState(() {});
    });
  }

  void setUserInfo() {
    userName = currentUserController.user.user_name;
    userEmail = currentUserController.user.user_email;
    userID = currentUserController.user.user_id.toString();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/delivery.png"),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            onPressed: () {
              orderDetails();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text("Place Order Now"),
          ),
        ],
      ),
    );
  }
}
