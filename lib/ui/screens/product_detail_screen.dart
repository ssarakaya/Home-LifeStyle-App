import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../business/product_provider.dart';
import '../../data/models/product.dart';
import 'add_product_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  // Intelligent Visual Selector (Asset or Network)
  Widget _buildProductImage(String url) {
    if (url.isEmpty) {
      return const Center(child: Icon(Icons.image_outlined, color: Colors.grey, size: 50));
    }
    if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(Icons.broken_image_outlined, color: Colors.grey, size: 50),
        ),
      );
    } else {
      return Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(Icons.broken_image_outlined, color: Colors.grey, size: 50),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 500,
            pinned: true,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product-${product.id}',
                child: Container(
                  color: const Color(0xFFEFEFEA),
                  child: _buildProductImage(product.imageUrl),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.category.toUpperCase(),
                        style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: const Color(0xFFB89356),
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          // CRUD: UPDATE BUTTON
                          IconButton(
                            icon: const Icon(Icons.edit_outlined, color: Colors.black54),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddProductScreen(productToEdit: product),
                                ),
                              );
                            },
                          ),
                          // CRUD: DELETE  BUTTON
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.grey),
                            onPressed: () async {
                              bool? confirmDelete = await _showDeleteDialog(context);
                              if (confirmDelete == true && product.id != null) {
                                await provider.deleteProduct(product.id!);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Piece removed from VICO inventory"))
                                  );
                                  Navigator.pop(context);
                                }
                              }
                            },
                          ),
                          // FAVORITE BUTTON
                          Consumer<ProductProvider>(
                            builder: (context, currentProvider, child) {
                              final isFav = currentProvider.products
                                  .any((p) => p.id == product.id && p.isFavorite);
                              return IconButton(
                                onPressed: () => currentProvider.toggleFavorite(product),
                                icon: Icon(
                                    isFav ? Icons.favorite : Icons.favorite_border,
                                    color: isFav ? Colors.red : Colors.black),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.name,
                    style: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 30),
                  Text("DESCRIPTION", style: GoogleFonts.montserrat(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 10),
                  Text(
                    "A masterpiece of contemporary design, this piece brings the 'Quiet Luxury' philosophy to your living space. Crafted with traditional methods and premium materials.",
                    style: GoogleFonts.montserrat(fontSize: 14, color: Colors.black54, height: 1.6),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          )
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(30),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            provider.addToCart(product);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Added to cart")));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 65),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: Text("ADD TO BAG", style: GoogleFonts.montserrat(color: Colors.white, letterSpacing: 2, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Future<bool?> _showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        title: Text("REMOVE PIECE", style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold)),
        content: Text("Are you sure you want to remove this piece?", style: GoogleFonts.montserrat(fontSize: 13)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("CANCEL")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("DELETE", style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}