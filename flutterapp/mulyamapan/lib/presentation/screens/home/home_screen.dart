import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/data/models/product/products_sort_flitered_by_model.dart';
import 'package:mulyankan/logic/cubits/user_cubit/user_cubit.dart';
import 'package:mulyankan/presentation/screens/auth/signin.screen.dart';
import 'package:mulyankan/presentation/screens/home/category_screen.dart';
import 'package:mulyankan/presentation/screens/home/home_comparison_screen.dart';
import 'package:mulyankan/presentation/screens/home/profile_screen.dart';
import 'package:mulyankan/presentation/screens/home/user_feed_screen.dart';
import 'package:mulyankan/presentation/screens/product/providers/product_search_provider.dart';
import 'package:mulyankan/presentation/screens/widgets/carousel_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/menubar_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/searchbox_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) onMenuItemTap;
  final BuildContext context;
  final ProductSearchProvider productSearchProvider;

  const HomeScreen(
      {super.key,
      required this.onMenuItemTap,
      required this.context,
      required this.productSearchProvider});
  static const String routeName = "Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  bool isSubMenuOpen = false;

  @override
  void initState() {
    //var productSearchProvider = context.read<ProductSearchProvider>();
    widget.productSearchProvider.getFilteredSortedProducts(null);
    super.initState();
  }

  List<Widget> screens = [
    const HomeComparisonScreen(),
    const UserFeedScreen(),
    const CategoryScreen(),
//    ChangeNotifierProvider(
//        create: (context) => ProfileProvider(context),
//        child: const ProfileScreen()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
      if (index == 3) {
        currentIndex =
            0; // when user navigates back from profile, he should land on home
        Navigator.pushNamed(context, ProfileScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsFilterSortByModel =
        context.watch<ProductsFilterSortByModel>();

    return Scaffold(
      //AppBar of scaffold
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Logo with fixed size
            CupertinoButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => false);
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
              child: Image.asset('lib/assets/images/mulyankan_logo.jpg',
                  width: 35, height: 35),
            ),

            // Search text with icons and camera + mic buttons (closer spaced)
            Flexible(
              child: SearchBoxWidget(
                productSearchProvider: widget.productSearchProvider,
                productsFilterSortByModel: productsFilterSortByModel,
                hintText: "Search products ..",
                showDrawer: true,
                searchBoxController: TextEditingController(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: PopupMenuButton<String>(
                    icon: const Row(
                      children: [
                        Icon(Icons.person),
                      ],
                    ),
                    offset: const Offset(0, 40),
                    onSelected: (value) {
                      switch (value) {
                        case "Logout":
                          context.read<UserCubit>().singOut();
                          Navigator.popUntil(context, (route) => false);
                          Navigator.pushNamed(context, SignInScreen.routeName);
                          break;
                        default:
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'Logout',
                        child: Text('Logout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      //Body of scaffold
      drawer: MyDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              //add space
              const SizedBox(
                height: 2,
              ),

              Expanded(
                child: screens[currentIndex],
              ),
            ],
          ),
        ],
      ),
      //BottomNavigationBar of scaffold
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
