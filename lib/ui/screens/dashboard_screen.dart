import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../business/product_provider.dart';
import 'add_product_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We are pulling the data live from the Provider. (State Management)
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "VICO",
          style: GoogleFonts.playfairDisplay(
            color: Colors.black,
            letterSpacing: 4,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: const Icon(Icons.search, color: Colors.black),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        tooltip: "Add New Piece",
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductScreen()),
          );
        },
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ANALYSIS",
              style: GoogleFonts.montserrat(
                fontSize: 10,
                color: const Color(0xFFB89356),
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Maison\nDashboard",
              style: GoogleFonts.playfairDisplay(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                height: 1.1,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 35),

            // STATISTICAL CARDS
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1.15,
              children: [
                _buildStatCard(
                    "TOTAL CATALOG",
                    "${provider.totalStockCount}", // dynamic data
                    "Products",
                    Icons.inventory_2_outlined
                ),
                _buildStatCard(
                    "TOTAL STOCK",
                    "${provider.totalStockCount * 4}", // Example stock multiplier
                    "Units",
                    Icons.layers_outlined
                ),
                _buildStatCard(
                    "FAVORITE PIECES",
                    "${provider.favoriteCount}", // dynamic data
                    "Items",
                    Icons.star_border
                ),
                _buildStatCard(
                    "SEGMENTATION",
                    "${provider.categoryCount}", // dynamic data
                    "Categories",
                    Icons.bar_chart_outlined
                ),
              ],
            ),

            const SizedBox(height: 35),

            // STRATEGIC SUMMARY (Emphasis on Layered Architecture)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Strategic Summary",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "The VICO Maison digital ecosystem combines timeless design with modern technology. Data is managed through a professional Layered Architecture (UI -> Repository -> DAO -> SQLite).",
                    style: GoogleFonts.montserrat(
                      color: Colors.grey.shade600,
                      height: 1.6,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Status Bars
                  Row(
                    children: [
                      Expanded(child: _buildMiniStatus("DATA LAYER: ACTIVE", Colors.green)),
                      const SizedBox(width: 20),
                      Expanded(child: _buildMiniStatus("UI SYNC: STABLE", const Color(0xFFB89356))),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // Statistics Card Generator
  Widget _buildStatCard(String title, String value, String unit, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFFB89356), size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 8,
              color: Colors.grey.shade500,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStatus(String label, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 7,
            color: Colors.grey.shade400,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 2,
          width: double.infinity,
          color: color,
        ),
      ],
    );
  }
}