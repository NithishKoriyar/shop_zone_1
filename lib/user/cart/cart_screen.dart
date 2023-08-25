import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_zone/user/userPreferences/current_user.dart';
import 'package:http/http.dart' as http;
import 'package:shop_zone/user/widgets/my_drawer.dart';

import '../../api_key.dart';

class CartScreenUser extends StatefulWidget {
  @override
  State<CartScreenUser> createState() => _CartScreenUserState();
}

class _CartScreenUserState extends State<CartScreenUser> {
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
      fetchCartItems();
      // Once the seller info is set, call setState to trigger a rebuild.
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
    print('user ID: $userID'); // Corrected variable name
    print('user image: $userImg');
  }

  List<dynamic> items = [];
  bool isLoading = true;

  Future<void> fetchCartItems() async {
    // Assuming your API endpoint is something like this
    print("Loading");
    const String apiUrl = API.cartView;
    final response =
        await http.post(Uri.parse(apiUrl), body: {'userID': userID});

    if (response.statusCode == 200) {
      final List<dynamic> fetchedItems = json.decode(response.body);
      setState(() {
        items = fetchedItems;
        isLoading = false;
      });
    } else {
      // Handle the error here
      print("Error fetching cart items");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        
        title: Text("Cart"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item['itemTitle']),
            // Add more fields as per your item structure
          );
        },
      ),
    );
  }
}
