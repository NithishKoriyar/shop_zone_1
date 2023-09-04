import 'package:flutter/material.dart';
import 'package:shop_zone/user/ordersScreens/orders_screen.dart';
import 'package:shop_zone/user/models/orders.dart';

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
  String orderStatus = "";

  @override
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
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                )),
          ),
          const Divider(
            thickness: 1,
            color: Colors.pinkAccent,
          ),
          const SizedBox(
            height: 20,
          ),
          orderStatus == "ended"
              ? Image.asset("images/delivered.png")
              : Image.asset("images/state.png"),
          const Divider(
            thickness: 1,
            color: Colors.pinkAccent,
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
          FloatingActionButton.extended(
onPressed: () {
  Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (c) => const OrdersScreen()));
},

            heroTag: "btn2",
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            label: const Text(
              "Go Back to Order",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
        ],
      )),
    );
  }
}
