
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_zone/user/models/orders.dart';
import 'package:shop_zone/user/splashScreen/my_splash_screen.dart';

class AddressDesign extends StatelessWidget {
      final Orders? model;

    AddressDesign({this.model}); 

  // sendNotificationToSeller() async {
  //   if (model?.sellerDeviceToken != null) {
  //     notificationFormat(
  //       model!.sellerDeviceToken!,
  //       model!.orderId!,
  //       model!.name!,  // Assuming "name" is from Orders model. Adjust if it's different.
  //     );
  //   } else {
  //     Fluttertoast.showToast(msg: "Seller token not available!");
  //   }
  // }

  // notificationFormat(sellerDeviceToken, getUserOrderID, userName) {
  //   Map<String, String> headerNotification = {
  //     'Content-Type': 'application/json',
  //     'Authorization': fcmServerToken,
  //   };

  //   Map bodyNotification = {
  //     'body': "Dear seller, Parcel (# $getUserOrderID) has Received Successfully by user $userName. \nPlease Check Now",
  //     'title': "Parcel Received by User",
  //   };

  //   Map dataMap = {
  //     "click_action": "FLUTTER_NOTIFICATION_CLICK",
  //     "id": "1",
  //     .orderStatus": "done",
  //     "userOrderId": getUserOrderID,
  //   };

  //   Map officialNotificationFormat = {
  //     'notification': bodyNotification,
  //     'data': dataMap,
  //     'priority': 'high',
  //     'to': sellerDeviceToken,
  //   };

  //   http.post(
  //     Uri.parse("https://fcm.googleapis.com/fcm/send"),
  //     headers: headerNotification,
  //     body: jsonEncode(officialNotificationFormat),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Shipping Details:',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: [
                  const Text("Name", style: TextStyle(color: Colors.grey)),
                  Text(
                    model?.name ?? "",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const TableRow(
                children: [
                  SizedBox(height: 4),
                  SizedBox(height: 4),
                ],
              ),
              TableRow(
                children: [
                  const Text("Phone Number", style: TextStyle(color: Colors.grey)),
                  Text(
                    model?.phoneNumber ?? "",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model?.completeAddress ?? "",
            textAlign: TextAlign.justify,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (model?.orderStatus == "normal") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MySplashScreen()));
            } else if (model?.orderStatus == "shifted") {
              //! Shifted and normal status is not
              //sendNotificationToSeller();

              Fluttertoast.showToast(msg: "Confirmed Successfully.");
              Navigator.push(context, MaterialPageRoute(builder: (context) => MySplashScreen()));
            } else if (model?.orderStatus == "ended") {
              // Rate the Seller feature
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MySplashScreen()));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.pinkAccent,
                    Colors.purpleAccent,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              width: MediaQuery.of(context).size.width - 40,
              height: model?.orderStatus == "ended" ? 60 : MediaQuery.of(context).size.height * .10,
              child: Center(
                child: Text(
                  getModelStatusText(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getModelStatusText() {
    if (model?.orderStatus == "ended") {
      return "Do you want to Rate this Seller?";
    } else if (model?.orderStatus == "shifted") {
      return "Parcel Received, \nClick to Confirm";
    } else if (model?.orderStatus == "normal") {
      return "Go Back";
    } else {
      return "";
    }
  }
}
