import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mulyankan/logic/cubits/category_cubit/category_cubit.dart';
import 'package:mulyankan/logic/cubits/category_cubit/category_state.dart';
import 'package:mulyankan/presentation/screens/widgets/menubar_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
      if (state is CategoryLoadingState && state.categories.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is CategoryErrorState && state.categories.isEmpty) {
        return Center(
          child: Text(state.message.toString()),
        );
      }

      return Scrollbar(
        interactive: true, // Set to true to always show the scrollbar
        controller: _scrollController,
        thickness: 20.0, // Adjust the thickness of the scrollbar
        child: ListView.builder(
            controller: _scrollController,
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              final category = state.categories[index];
              return ListTile(
                onTap: () {},
                leading: const Icon(Icons.category),
                title: Text("${category.categoryName}"),
                trailing: const Icon(Icons.keyboard_arrow_right),
              );
            }),
      );
    });
  }
}
