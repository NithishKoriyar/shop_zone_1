import 'package:flutter/material.dart';
import 'package:shop_zone/seller/models/orders.dart';
import 'package:shop_zone/seller/splashScreen/seller_my_splash_screen.dart';

// ignore: must_be_immutable
class OrderDetailsScreen extends StatefulWidget {
  Orders? model;

  OrderDetailsScreen({
    this.model,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String? orderStatus;

  @override
  void initState() {
    super.initState();
    orderStatus = widget.model?.orderStatus;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "status :${widget.model?.orderStatus}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "₹ ${widget.model?.totalAmount}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Order ID = ${widget.model?.orderId}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Order at = ${widget.model?.orderTime?.toString() ?? 'N/A'}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                )),
          ),
          const Divider(
            thickness: 1,
            color: Colors.pinkAccent,
          ),
          orderStatus == "ended"
              ? Image.asset("images/delivered.png")
              : Image.asset("images/state.png"),
          const Divider(
            thickness: 1,
            color: Colors.pinkAccent,
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 150),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Shipping Address",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Name : ${widget.model?.name}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Phone Number : ${widget.model?.phoneNumber}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Address : ${widget.model?.completeAddress}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              if (orderStatus == "normal") {
                //update earnings
              } else if (orderStatus == "shifted") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SellerSplashScreen()));
              } else if (orderStatus == "ended") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SellerSplashScreen()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SellerSplashScreen()));
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
                )),
                width: MediaQuery.of(context).size.width - 40,
                height: orderStatus == "ended"
                    ? 60
                    : MediaQuery.of(context).size.height * .10,
                child: Center(
                  child: Text(
                    orderStatus == "ended"
                        ? "Go Back"
                        : orderStatus == "shifted"
                            ? "Go Back"
                            : orderStatus == "normal"
                                ? "Parcel Packed & \nShifted to Nearest PickUp Point. \nClick to Confirm"
                                : "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
