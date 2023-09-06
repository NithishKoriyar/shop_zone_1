import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop_zone/seller/splashScreen/seller_my_splash_screen.dart';
import 'package:shop_zone/user/cart/cart_screen.dart';
import 'package:shop_zone/user/history/history_screen.dart';
import 'package:shop_zone/user/notYetReceivedParcels/not_yet_received_parcels_screen.dart';
import 'package:shop_zone/user/ordersScreens/orders_screen.dart';
import 'package:shop_zone/user/sellersScreens/home_screen.dart';
import 'package:shop_zone/user/splashScreen/my_splash_screen.dart';
import 'package:shop_zone/user/userPreferences/current_user.dart';
import 'package:shop_zone/user/userPreferences/user_preferences.dart';

import '../../api_key.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
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

  @override
  Widget build(BuildContext context) {
    // Check if sellerImg is null before accessing it.
// Placeholder if sellerImg is empty.

    return Drawer(
      backgroundColor: Colors.black54,
      child: ListView(
        children: [
          //header
          Container(
            padding: const EdgeInsets.only(top: 26, bottom: 12),
            child: Column(
              children: [
                //user profile image
                SizedBox(
                  height: 130,
                  width: 130,
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(API.userImage + userImg)),
                ),

                const SizedBox(
                  height: 12,
                ),

                //user name
                Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),

          //body
          Container(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

                //home
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => HomeScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

                ListTile(
                  leading: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Cart",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => CartScreenUser()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

                //my orders
                ListTile(
                  leading: const Icon(
                    Icons.reorder,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "My Orders",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const OrdersScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

                //not yet received orders
                ListTile(
                  leading: const Icon(
                    Icons.picture_in_picture_alt_rounded,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Not Yet Received Parcels",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> NotYetReceivedParcelsScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

                //history
                ListTile(
                  leading: const Icon(
                    Icons.access_time,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "History",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> HistoryScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

                //search
                ListTile(
                  leading: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Search",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (c)=> SearchScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

                //logout
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    RememberUserPrefs.removeUserInfo();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => MySplashScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.supervisor_account_sharp,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Be a Seller",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const SellerSplashScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
