import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../business/product_provider.dart';
import 'screens/home_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/wishlist_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/settings_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const DashboardScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // We securely load the database as soon as the application reaches the main page.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFB89356),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "EXPLORE"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "DASHBOARD"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "WISHLIST"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "CART"),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: "SETTINGS"),
        ],
      ),
    );
  }
}