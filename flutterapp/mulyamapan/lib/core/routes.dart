import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mulyankan/data/models/product/product_model.dart';
import 'package:mulyankan/data/models/product/product_search_input_model.dart';
import 'package:mulyankan/presentation/screens/auth/providers/login_provider.dart';
import 'package:mulyankan/presentation/screens/auth/providers/signup_provider.dart';
import 'package:mulyankan/presentation/screens/auth/signin.screen.dart';
import 'package:mulyankan/presentation/screens/auth/signup.screen.dart';
import 'package:mulyankan/presentation/screens/home/home_screen.dart';
import 'package:mulyankan/presentation/screens/home/profile_screen.dart';
import 'package:mulyankan/presentation/screens/home/providers/profile_provider.dart';
import 'package:mulyankan/presentation/screens/home/user_feed_screen.dart';
import 'package:mulyankan/presentation/screens/product/product_detail_screen.dart';
import 'package:mulyankan/presentation/screens/product/product_search_screen.dart';
import 'package:mulyankan/presentation/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ProfileScreen.routeName:
        print("route called ...");
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => ProfileProvider(context),
                child: const ProfileScreen()));
      case SignInScreen.routeName:
        print("route called ...");
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => LoginProvider(context),
                child: const SignInScreen()));
      case SignupScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => SignupProvider(context),
                child: const SignupScreen()));
      case HomeScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                          create: (context) => SignupProvider(context)),
                    ],
                    child: HomeScreen(
                      onMenuItemTap: (index) {},
                    )));
      case SplashScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());
      case ProductDetailScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ProductDetailScreen(
                  productModel: settings.arguments as ProductModel,
                ));
      case ProductSearchScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => ProductSearchScreen(
                  productSearchInputModel:
                      settings.arguments as ProductSearchInputModel,
                ));
      default:
        return null;
    }
  }
}
