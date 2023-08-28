import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shop_zone/user/models/cart.dart';
import 'package:shop_zone/user/userPreferences/current_user.dart';
import 'package:shop_zone/user/widgets/appbar_cart_badge.dart';
import '../../api_key.dart';

class ItemsDetailsScreen extends StatefulWidget {
  Carts? model;

  ItemsDetailsScreen({this.model});

  @override
  State<ItemsDetailsScreen> createState() => _ItemsDetailsScreenState();
}

class _ItemsDetailsScreenState extends State<ItemsDetailsScreen> {
  final CurrentUser currentUserController = Get.put(CurrentUser());

  late String userName;
  late String userEmail;
  late String userID;
  late String userImg;
  int counterLimit = 1;

  @override
  void initState() {
    super.initState();
    currentUserController.getUserInfo().then((_) {
      setUserInfo();
      printUserInfo();
      setState(() {});
    });
  }

  void setUserInfo() {
    userName = currentUserController.user.user_name;
    userEmail = currentUserController.user.user_email;
    userID = currentUserController.user.user_id.toString();
    userImg = currentUserController.user.user_profile;
  }

  void printUserInfo() {
    print('user Name: $userName');
    print('user Email: $userEmail');
    print('user ID: $userID');
    print('user image: $userImg');
  }

double getTotalPrice() {
  double itemPrice = double.tryParse(widget.model!.price ?? '0') ?? 0.0;
  return itemPrice * (widget.model!.itemCounter ?? 0);
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithCartBadge(
        sellerUID: widget.model!.sellerUID.toString(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Your onPressed logic here
        },
        label: const Text("Buy Now"),
        icon: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              API.getItemsImage + (widget.model!.thumbnailUrl ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Center(
                child: Text(
                  widget.model!.itemTitle.toString(),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                "Quantity :" + widget.model!.itemCounter.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
              child: Text(
                widget.model!.longDescription.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "₹ " + widget.model!.price.toString(),
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.green,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 320.0),
              child: Divider(
                height: 1,
                thickness: 2,
                color: Colors.green,
              ),
            ),
Padding(
  padding: const EdgeInsets.all(10.0),
  child: Text(
    "Total Price : ₹ " + getTotalPrice().toString(),
    textAlign: TextAlign.justify,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.black,
    ),
  ),
),


            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
