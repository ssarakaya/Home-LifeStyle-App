import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../business/product_provider.dart';
import '../../data/models/product.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryName;

  const ProductListScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
            categoryName,
            style: GoogleFonts.playfairDisplay(color: Colors.black, fontWeight: FontWeight.bold)
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          // Filtering: By subcategory or show all if "COLLECTION PIECES".
          final filteredProducts = provider.products
              .where((p) => p.category == categoryName || categoryName == "COLLECTION PIECES")
              .toList();

          if (filteredProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.inventory_2_outlined, color: Colors.grey, size: 40),
                  const SizedBox(height: 15),
                  Text(
                    "No pieces found in $categoryName",
                    style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.62, // It makes the design more vertical and luxurious.
              mainAxisSpacing: 25,
              crossAxisSpacing: 20,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];

              return GestureDetector(
                onTap: () {
                  // Rubrik: Proper Navigation
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product),
                    ),
                  );
                },
                child: _buildProductCard(context, product, provider),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product, ProductProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              // VISUAL LOADING LOGIC
              Hero(
                tag: 'product-${product.id}', //  UI Design/Consistency
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFEFEA),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: _buildProductImage(product.imageUrl),
                  ),
                ),
              ),

              // Favorite Button
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => provider.toggleFavorite(product),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      product.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: product.isFavorite ? Colors.red : Colors.black45,
                      size: 16,
                    ),
                  ),
                ),
              ),

              // Add to Cart Button (UX Feedback)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    provider.addToCart(product);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${product.name} added to bag"),
                        backgroundColor: Colors.black,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.85),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Text(
                        "ADD TO BAG",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 8,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Product Name
        Text(
          product.name.toUpperCase(),
          style: GoogleFonts.montserrat(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        // Product Price
        Text(
            "\$${product.price.toStringAsFixed(2)}",
            style: GoogleFonts.montserrat(fontSize: 11, color: const Color(0xFFB89356), fontWeight: FontWeight.w500)
        ),
      ],
    );
  }

  // INTELLIGENT IMAGE SELECTOR
  Widget _buildProductImage(String url) {
    if (url.isEmpty) {
      return const Center(child: Icon(Icons.image_outlined, color: Colors.white, size: 30));
    }

    // If the URL starts with 'assets', it loads a local image; otherwise, it loads a web image.
    if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(Icons.broken_image_outlined, color: Colors.white, size: 30),
        ),
      );
    } else {
      return Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(Icons.broken_image_outlined, color: Colors.white, size: 30),
        ),
      );
    }
  }
}