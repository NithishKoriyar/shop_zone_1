import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shop_zone/api_key.dart';
import 'package:shop_zone/user/addressScreens/address_design_widget.dart';
import 'package:shop_zone/user/addressScreens/save_new_address_screen.dart';
import 'package:shop_zone/user/assistantMethods/address_changer.dart';
import 'package:shop_zone/user/models/address.dart';
import 'package:http/http.dart' as http;
import 'package:shop_zone/user/models/cart.dart';
import 'package:shop_zone/user/userPreferences/current_user.dart';

// ignore: must_be_immutable
class AddressScreen extends StatefulWidget {
  Carts? model;

  AddressScreen({this.model});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final CurrentUser currentUserController = Get.put(CurrentUser());

  late String userName;
  late String userEmail;
  late String userID;
  late String userImg;

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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.black,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: const Text(
          "Shop Zone",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => SaveNewAddressScreen()));
        },
        label: const Text("Add New Address"),
        icon: const Icon(
          Icons.add_location,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Consumer<AddressChanger>(builder: (context, address, c) {
            return Flexible(
              child: StreamBuilder<List<dynamic>>(
                stream: fetchAddressStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return AddressDesignWidget(
                            addressModel:
                                Address.fromJson(snapshot.data![index]),
                            index: address.count,
                            value: index,
                            addressID: snapshot.data![index]['id'],
                            sellerUID: widget.model?.sellerUID, // assuming you have a sellerUID property in the Carts model
                            totalPrice:  widget.model?.totalPrice,
                            cartId: widget.model?.cartId,
                            model: widget.model,// assuming you have a totalPrice property in the Carts model
                          );
                        },
                        itemCount: snapshot.data!.length,
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Stream<List<dynamic>> fetchAddressStream() async* {
    while (true) {
      print("------address stream-------");

      Uri requestUri = Uri.parse('${API.fetchAddress}?uid=$userID');
      print("Requesting URI: $requestUri"); 

      final response = await http.get(requestUri);

      if (response.statusCode == 200) {
        print("Data received: ${response.body}");

        var decodedData = json.decode(response.body);
        if (decodedData is List) {
          yield decodedData;
        } else {
          yield [];
        }
      } else {
        throw Exception('Failed to load address');
      }

      await Future.delayed(Duration(seconds: 10));
    }
  }
}
