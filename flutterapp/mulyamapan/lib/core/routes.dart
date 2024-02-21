import 'package:flutter/cupertino.dart';
import 'package:mulyankan/data/models/product/product_model.dart';
import 'package:mulyankan/data/models/product/products_sort_flitered_by_model.dart';
import 'package:mulyankan/presentation/screens/auth/providers/login_provider.dart';
import 'package:mulyankan/presentation/screens/auth/providers/signup_provider.dart';
import 'package:mulyankan/presentation/screens/auth/signin.screen.dart';
import 'package:mulyankan/presentation/screens/auth/signup.screen.dart';
import 'package:mulyankan/presentation/screens/home/home_screen.dart';
import 'package:mulyankan/presentation/screens/home/profile_screen.dart';
import 'package:mulyankan/presentation/screens/home/providers/profile_provider.dart';
import 'package:mulyankan/presentation/screens/product/product_detail_screen.dart';
import 'package:mulyankan/presentation/screens/product/product_search_screen.dart';
import 'package:mulyankan/presentation/screens/product/providers/product_search_provider.dart';
import 'package:mulyankan/presentation/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ProfileScreen.routeName:
        print("ProfileScreen route called ...");
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => ProfileProvider(context),
                child: ProfileScreen(
                  productSearchProvider: ProductSearchProvider(context),
                )));
      case SignInScreen.routeName:
        print("SignInScreen route called ...");
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => LoginProvider(context),
                child: const SignInScreen()));
      case SignupScreen.routeName:
        print("SignupScreen route called ...");
        return CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => SignupProvider(context),
                child: const SignupScreen()));
      case HomeScreen.routeName:
        print("HomeScreen route called ...");
        return CupertinoPageRoute(
            builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                          create: (context) => ProductSearchProvider(context)),
                      ChangeNotifierProvider<ProductsFilterSortByModel>(
                          create: (context) => ProductsFilterSortByModel()),
                      ChangeNotifierProvider(
                          create: (context) => SignupProvider(context)),
                    ],
                    child: HomeScreen(
                      context: context,
                      onMenuItemTap: (index) {},
                      productSearchProvider: ProductSearchProvider(context),
                    )));
      case SplashScreen.routeName:
        print("SplashScreen route called ...");
        return CupertinoPageRoute(builder: (context) => const SplashScreen());
      case ProductDetailScreen.routeName:
        print("ProductDetailScreen route called ...");
        return CupertinoPageRoute(
            builder: (context) => ProductDetailScreen(
                  productModel: settings.arguments as ProductModel,
                ));
      case ProductSearchScreen.routeName:
        print("ProductSearchScreen route called ...");
        return CupertinoPageRoute(
            builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                          create: (context) => ProductSearchProvider(context)),
                      ChangeNotifierProvider<ProductsFilterSortByModel>(
                          create: (context) => ProductsFilterSortByModel()),
                    ],
                    child: ProductSearchScreen(
                      productSearchProvider: ProductSearchProvider(context),
                      productsFilterSortByModel:
                          settings.arguments as ProductsFilterSortByModel,
                    )));
      default:
        return null;
    }
  }
}
