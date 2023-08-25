import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_zone/user/assistantMethods/address_changer.dart';
import 'package:shop_zone/user/splashScreen/my_splash_screen.dart';


void main()
{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.zkz
  @override
  // Widget build(BuildContext context) {
  //   return GetMaterialApp(
  //     title: 'Shop Zone',
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData(
  //       primarySwatch: Colors.purple,
  //     ),
  //     home: const MySplashScreen()
  //   );
  // }
    Widget build(BuildContext context) {
    return MultiProvider(
      providers:
      [

        ChangeNotifierProvider(create: (c)=> AddressChanger()),
      ],
      child: MaterialApp(
        title: 'Shop Zone',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        debugShowCheckedModeBanner: false,
        home: const MySplashScreen(),
      ),
    );
  }
}

