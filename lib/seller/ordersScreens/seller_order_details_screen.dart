import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_zone/seller/models/orders.dart';
import 'package:shop_zone/seller/ordersScreens/seller_address_design_widget.dart';
import 'package:shop_zone/seller/sellerPreferences/current_seller.dart';

// ignore: must_be_immutable
class OrderDetailsScreen extends StatefulWidget {
  Orders? model;

  OrderDetailsScreen({
    super.key,
    this.model,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // StatusBanner(
            //   status: widget.model.isSuccess,
            //   orderStatus: widget.model.status,
            // ),
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
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Order at = ${widget.model?.orderTime}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.pinkAccent,
            ),
            widget.model?.orderStatus != "ended"
                ? Image.asset("images/packing.jpg")
                : Image.asset("images/delivered.jpg"),
            const Divider(
              thickness: 1,
              color: Colors.pinkAccent,
            ),
            AddressDesign(
              model: widget.model
            ),
          ],
        ),
      ),
    );
  }
}
