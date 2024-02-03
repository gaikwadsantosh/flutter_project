import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/data/models/product/product_search_input_model.dart';
import 'package:mulyankan/logic/cubits/user_cubit/user_cubit.dart';
import 'package:mulyankan/presentation/screens/auth/signin.screen.dart';
import 'package:mulyankan/presentation/screens/home/profile_screen.dart';
import 'package:mulyankan/presentation/screens/product/product_search_screen.dart';
import 'package:share_plus/share_plus.dart';

class MenuBarWidget extends StatelessWidget {
  const MenuBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // Add your menu items here
      children: [
        CupertinoButton(
            child: Column(
              children: [
                Image.asset('lib/assets/images/mobile_logo.jpg',
                    width: 35, height: 35),
                Text("Mobiles"),
              ],
            ),
            onPressed: () {
              Navigator.pushNamed(context, ProductSearchScreen.routeName,
                  arguments:
                      ProductSearchInputModel(subCategoryName: "Mobile"));
            }),
        CupertinoButton(
            child: Column(
              children: [
                Image.asset('lib/assets/images/tv_logo.jpg',
                    width: 35, height: 35),
                Text("TVs"),
              ],
            ),
            onPressed: () {
              Navigator.pushNamed(context, ProductSearchScreen.routeName,
                  arguments: ProductSearchInputModel(subCategoryName: "TV"));
            }),
      ],
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 60,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              // Add your logic for Option 1
              //Navigator.pop(context);
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
          ListTile(
            title: Text('Deals'),
            onTap: () {
              // Add your logic for Option 2
              //Navigator.pop(context);
              Navigator.pushNamed(context, ProductSearchScreen.routeName,
                  arguments: ProductSearchInputModel(
                      searchType: "ecommerce", categoryName: "deals"));
            },
          ),
          ListTile(
            title: Text('News'),
            onTap: () {
              // Add your logic for Option 2
              Navigator.pop(context);
            },
          ),
          Divider(thickness: 1),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              // Add your logic for Option 2
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Rate us'),
            onTap: () {
              // Add your logic for Option 2
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Feedback'),
            onTap: () {
              // Add your logic for Option 2
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Share this app'),
            onTap: () {
              // Add your logic for Option 2
              //Navigator.pop(context);
              _shareAppLink();
            },
          ),
          ListTile(
            title: Text('Check for updates'),
            onTap: () {
              // Add your logic for Option 2
              Navigator.pop(context);
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              // Add your logic for Option 2
              //Navigator.pop(context);
              context.read<UserCubit>().singOut();
              Navigator.popUntil(context, (route) => false);
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
          ),
          // Add more ListTile items as needed
        ],
      ),
    );
  }
}

void _shareAppLink() async {
  final appLink =
      'https://play.google.com/store/apps/details?id=org.wikipedia'; // Replace with your app's Play Store or App Store link
  final text = 'Check out this awesome app! $appLink';

  await Share.share(text);
}
