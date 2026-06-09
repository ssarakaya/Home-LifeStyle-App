import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../business/product_provider.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  // Image Uploader
  Widget _buildProductImage(String url) {
    if (url.startsWith('assets/')) {
      return Image.asset(url, fit: BoxFit.cover);
    } else {
      return Image.network(url, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.broken_image));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text("MY CART", style: GoogleFonts.playfairDisplay(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 2)),
      ),
      body: provider.cartItems.isEmpty
          ? _buildEmptyCart(context)
          : _buildCartList(context, provider),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_bag_outlined, size: 50, color: Color(0xFFB89356)),
          const SizedBox(height: 25),
          Text("YOUR BAG IS EMPTY", style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 35),
          OutlinedButton(
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            child: const Text("BROWSE COLLECTION"),
          ),
        ],
      ),
    );
  }

  Widget _buildCartList(BuildContext context, ProductProvider provider) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(25),
            itemCount: provider.cartItems.length,
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemBuilder: (context, index) {
              final product = provider.cartItems[index];
              return Container(
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                child: Row(
                  children: [

                    Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F1EB),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: _buildProductImage(product.imageUrl),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name.toUpperCase(), style: GoogleFonts.montserrat(fontSize: 11, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text("\$${product.price.toStringAsFixed(2)}", style: GoogleFonts.montserrat(fontSize: 12, color: const Color(0xFFB89356))),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18, color: Colors.grey),
                      onPressed: () => provider.removeFromCart(product),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("TOTAL ESTIMATE", style: GoogleFonts.montserrat(fontSize: 10, fontWeight: FontWeight.bold)),
                  Text("\$${provider.totalCartPrice.toStringAsFixed(2)}", style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckoutScreen())),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black, minimumSize: const Size(double.infinity, 65)),
                child: const Text("CONFIRM ORDER", style: TextStyle(color: Colors.white)),
              ),
              TextButton(onPressed: () => provider.clearCart(), child: const Text("CLEAR ALL", style: TextStyle(fontSize: 10, color: Colors.grey))),
            ],
          ),
        ),
      ],
    );
  }
}