import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shop_zone/api_key.dart';
import 'package:shop_zone/user/models/brands.dart';
import 'package:shop_zone/user/models/sellers.dart';
import 'package:shop_zone/user/widgets/my_drawer.dart';

import '../../seller/widgets/seller_text_delegate_header_widget.dart';
import 'brands_ui_design_widget.dart';

class BrandsScreen extends StatefulWidget {
  final Sellers? model;

  BrandsScreen({this.model,});


  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {

  Future<List<dynamic>> fetchBrands(String sellerId) async {
    Uri uri = Uri.parse('${API.sellerBrandView}?sellerId=$sellerId');

    // Print the link in the terminal
    // print("Fetching brands from: $uri");

    final response = await http.get(uri);


    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);

      if (responseBody is List) {
        return responseBody;
      } else if (responseBody.containsKey('error')) {
        // Handle custom error messages from the server
        throw Exception(responseBody['error']);
      }
    } else {
      throw Exception('Failed to load brands');
    }
    return [];  // Return an empty list if all else fails
  }


  Stream<List<dynamic>> brandsStream(String sellerId) async* {
    while (true) {
      await Future.delayed(Duration(seconds: 2)); // Polling every 5 seconds
      final brands = await fetchBrands(sellerId);
      yield brands;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.black],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: const Text(
          "Shop Zone",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextDelegateHeaderWidget(
              title: '${widget.model!.sellerName} - Brands',
            ),
          ),
          StreamBuilder<List<dynamic>>(
            stream: brandsStream(widget.model!.sellerId.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error); // Log the error
                return SliverToBoxAdapter(
                  child: Center(child: Text("Error fetching brands")),
                );
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(child: Text("No brands exist")),
                );
              } else {
                var brands = snapshot.data;
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    Brands brandsModel = Brands.fromJson(brands[index]);
                    return BrandsUiDesignWidget(
                      model: brandsModel,
                    );
                  },
                  itemCount: brands!.length,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
