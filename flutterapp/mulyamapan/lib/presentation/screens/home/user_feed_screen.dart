import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/core/ui.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_cubit.dart';
import 'package:mulyankan/logic/cubits/product_cubit/product_state.dart';
import 'package:mulyankan/presentation/screens/product/product_detail_screen.dart';
import 'package:mulyankan/presentation/screens/widgets/gap_widget.dart';
import 'package:mulyankan/presentation/screens/widgets/menubar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      if (state is ProductLoadingState && state.products.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is ProductErrorState && state.products.isEmpty) {
        return Center(
          child: Text(state.message),
        );
      }

      return Scrollbar(
        interactive: true, // Set to true to always show the scrollbar
        controller: _scrollController,
        thickness: 20.0, // Adjust the thickness of the scrollbar
        child: ListView.builder(
            controller: _scrollController,
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return CupertinoButton(
                onPressed: () {
                  Navigator.pushNamed(context, ProductDetailScreen.routeName,
                      arguments: product);
                },
                child: Container(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        width: 100, //MediaQuery.of(context).size.width / 3,
                        height: 100,
                        imageUrl: "${product.imageUrl}",
                      ),
                      const GapWidget(),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product.productName}",
                              style: TextStyles.body1
                                  .copyWith(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${product.dealMessage}",
                              style: TextStyles.body2
                                  .copyWith(color: AppColors.textLight),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const GapWidget(),
                            Text(
                              "${product.priceDiscount}",
                              style: TextStyles.body2,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.cart)),
                    ],
                  ),
                ),
              );
            }),
      );
    });
  }

  Future<void> _launchURL(String url) async {
    try {
      await canLaunchUrl(Uri.parse(url));
      launchUrl(Uri.parse(url));
    } catch (ex) {
      throw ex.toString();
    }
  }
}
