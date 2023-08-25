import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_zone/seller/brandsScreens/seller_brands_ui_design_widget.dart';
import 'package:shop_zone/seller/brandsScreens/seller_upload_brands_screen.dart';
import 'package:shop_zone/seller/models/seller_brands.dart';
import 'package:shop_zone/seller/widgets/seller_text_delegate_header_widget.dart';
import '../../api_key.dart';
import '../sellerPreferences/current_seller.dart';
import '../widgets/seller_my_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getSellerEarningsFromDatabase() {
    // FirebaseFirestore.instance
    //     .collection("sellers")
    //     .doc(sharedPreferences!.getString("uid"))
    //     .get()
    //     .then((dataSnapShot)
    // {
    //   previousEarning = dataSnapShot.data()!["earnings"].toString();
    // }).whenComplete(()
    // {
    //   restrictBlockedSellersFromUsingSellersApp();
    // });
  }

  restrictBlockedSellersFromUsingSellersApp() async {
    // await FirebaseFirestore.instance
    //     .collection("sellers")
    //     .doc(sharedPreferences!.getString("uid"))
    //     .get().then((snapshot)
    // {
    //   if(snapshot.data()!["status"] != "approved")
    //   {
    //     showReusableSnackBar(context, "you are blocked by admin.");
    //     showReusableSnackBar(context, "contact admin: admin2@jan-G-shopy.com");

    //     FirebaseAuth.instance.signOut();
    //     Navigator.push(context, MaterialPageRoute(builder: (c)=> SellerSplashScreen()));
    //   }
    // });
  }

  //!seller information--------------------------------------
  final CurrentSeller currentSellerController = Get.put(CurrentSeller());

  late String sellerName;
  late String sellerEmail;
  late String sellerID;
  late String sellerImg;

  @override
  void initState() {
    super.initState();
    currentSellerController.getSellerInfo().then((_) {
      setSellerInfo();
      printSellerInfo();
      // Once the seller info is set, call setState to trigger a rebuild.
      setState(() {});
      // PushNotificationsSystem pushNotificationsSystem = PushNotificationsSystem();
      // pushNotificationsSystem.whenNotificationReceived(context);
      // pushNotificationsSystem.generateDeviceRecognitionToken();

      getSellerEarningsFromDatabase();
    });
  }

  void setSellerInfo() {
    sellerName = currentSellerController.seller.seller_name;
    sellerEmail = currentSellerController.seller.seller_email;
    sellerID = currentSellerController.seller.seller_id.toString();
    sellerImg = currentSellerController.seller.seller_profile;
  }

  void printSellerInfo() {
    print('Seller Name: $sellerName');
    print('Seller Email: $sellerEmail');
    print('Seller ID: $sellerID'); // Corrected variable name
    print('Seller image: $sellerImg');
  }
  //!seller information--------------------------------------

  @override
  Widget build(BuildContext context) {
    // Register CurrentSeller instance with GetX
    Get.put(CurrentSeller());
    return Scaffold(
      drawer: MyDrawer(),
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => UploadBrandsScreen()));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextDelegateHeaderWidget(title: "My Brands"),
          ),

          //1. write query
          //2  model
          //3. ui design widget
          StreamBuilder(
            stream: fetchBrandsStream(sellerID),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    Brands brandsModel = Brands.fromJson(snapshot.data![index]);

                    return BrandsUiDesignWidget(
                      model: brandsModel,
                      context: context,
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "No brands exists",
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
//   final String apiUrl = '${API.currentSellerBrandView}?uid=$sellerID';
//http://192.168.0.113/amazon%20clone%20in%20backend%20php/shop_zone/shop_zone_api/seller/Brands.php
  Stream<List<dynamic>> fetchBrandsStream(String sellerID) async* {

    final response = await http.get(
        Uri.parse("${API.currentSellerBrandView}?sellerID=$sellerID")
    );

    if (response.statusCode == 200) {
      List<dynamic> brands = json.decode(response.body);
      yield brands;
      print("++++++++++++++++++++++++++");
      print(brands);
    } else {
      throw Exception('Failed to load brands');
    }
  }
}