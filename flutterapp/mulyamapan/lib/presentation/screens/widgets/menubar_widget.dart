import 'package:flutter/material.dart';

class MenuBarWidget extends StatelessWidget {
  const MenuBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // Add your menu items here
      children: [
        PopupMenuButton<String>(
          icon: const Row(
            children: [
              Icon(Icons.menu), // Burger icon
            ],
          ),
          offset: const Offset(0, 40),
          onSelected: (value) {
            // Handle burger icon click or submenu item selection
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'BurgerOption 1',
              child: Text('BurgerSub Item 1'),
            ),
          ],
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            // Handle submenu item selection
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'Option 1',
              child: Text('Sub Item 1'),
            ),
            const PopupMenuItem(
              value: 'Option 2',
              child: Text('Sub Item 2'),
            ),
          ],
          offset: const Offset(0, 20),
          child: const Text('MenuItem1'),
        ),
        const SizedBox(
          width: 20,
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            // Handle menu item selection
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'Option 3',
              child: Text('Item 3'),
            ),
          ],
          offset: const Offset(0, 20),
          child: const Text('MenuItem2'),
        ),
      ],
    );
  }
}
