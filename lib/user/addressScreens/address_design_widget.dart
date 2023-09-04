import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_zone/user/assistantMethods/address_changer.dart';
import 'package:shop_zone/user/models/address.dart';
import 'package:shop_zone/user/models/cart.dart';
import 'package:shop_zone/user/placeOrderScreen/place_order_screen.dart';

// ignore: must_be_immutable
class AddressDesignWidget extends StatefulWidget {
  Address? addressModel;
  Carts? model;
  int? index;
  int? value;
  String? addressID;
  String? sellerUID;
  String? cartId;
  int? totalPrice;

  AddressDesignWidget({
    this.addressModel,
    this.model,
    this.index,
    this.value,
    this.addressID,
    this.sellerUID,
    this.totalPrice,
    this.cartId, 
  });
  

  @override
  State<AddressDesignWidget> createState() => _AddressDesignWidgetState();
}

class _AddressDesignWidgetState extends State<AddressDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white24,
      child: Column(
        children: [
          //address info
          Row(
            children: [
              Radio(
                groupValue: widget.index,
                value: widget.value!,
                activeColor: Colors.pink,
                onChanged: (val) {
                  //provider
                  Provider.of<AddressChanger>(context, listen: false)
                      .showSelectedAddress(val);
                },
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            const Text(
                              "Name: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.addressModel!.name.toString(),
                            ),
                          ],
                        ),
                        const TableRow(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              "Phone Number: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.addressModel!.phoneNumber.toString(),
                            ),
                          ],
                        ),
                        const TableRow(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              "Full Address: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.addressModel!.completeAddress.toString(),
                            ),
                          ],
                        ),
                        const TableRow(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          //button
          widget.value == Provider.of<AddressChanger>(context).count
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent,
                    ),
                    onPressed: () {
                      // Print the values of addressID, sellerUID, and totalAmount
                      print("addressID: ${widget.addressID}");
                      print("totalAmount: ${widget.totalPrice}");
                      print("cartId: ${widget.cartId}");

                      //send user to Place Order Screen finally
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => PlaceOrderScreen(
                                    addressID: widget.addressID,
                                    totalAmount: widget.totalPrice, 
                                    cartId: widget.cartId,
                                    model: widget.model,
                                    
                                  )));
                    },
                    child: const Text("Proceed"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
