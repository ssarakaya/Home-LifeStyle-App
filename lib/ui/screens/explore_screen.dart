import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_list_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedCategoryIndex = 0;

  // Identical to the left-hand menu on the screen.
  final List<String> _mainCategories = [
    "DINING", "KITCHEN", "HOME APPLIANCES", "HOME & LIVING", "HOBBY", "BUNDLES"
  ];

  final Map<String, List<String>> _subCategories = {
    "DINING": ["DINNERWARE", "BREAKFAST SETS", "CUTLERY SETS", "COFFEE CUP SETS", "GLASS & GLASSWARE"],
    "KITCHEN": ["COOKING", "STORAGE & ORG.", "KNIFE SETS", "KITCHEN TOOLS"],
    "HOME APPLIANCES": ["COFFEE MACHINES", "FOOD PREP", "VACUUM CLEANERS"],
    "HOME & LIVING": ["BEDROOM", "DECORATION", "RUGS", "BATHROOM"],
    "HOBBY": ["BOOKS", "MUSIC", "SPORTS"],
    "BUNDLES": ["KITCHEN BUNDLES"]
  };

  // Category images (Unsplash links)
  final List<String> _categoryImages = [
    "https://images.unsplash.com/photo-1550928431-ee0ec6db30d3?q=80&w=1000",
    "https://images.unsplash.com/photo-1556910103-1c02745aae4d?q=80&w=1000",
    "https://images.unsplash.com/photo-1584622650111-993a426fbf0a?q=80&w=1000",
    "https://images.unsplash.com/photo-1513519245088-0e12902e5a38?q=80&w=1000",
    "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=1000",
    "https://images.unsplash.com/photo-1616489953149-80798991a8e1?q=80&w=1000",
  ];

  @override
  Widget build(BuildContext context) {
    String currentCategory = _mainCategories[_selectedCategoryIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("VICO", style: GoogleFonts.playfairDisplay(color: Colors.black, letterSpacing: 6, fontWeight: FontWeight.bold)),
        leading: const Icon(Icons.search, color: Colors.black),
      ),
      body: Row(
        children: [
          // SIDEBAR
          Container(
            width: 110,
            decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.grey.shade100))),
            child: ListView.builder(
              itemCount: _mainCategories.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedCategoryIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategoryIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                    color: isSelected ? const Color(0xFFF9F9F7) : Colors.transparent,
                    child: Text(
                      _mainCategories[index],
                      style: GoogleFonts.montserrat(
                        fontSize: 9,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                        color: isSelected ? const Color(0xFFB89356) : Colors.grey.shade400,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // RIGHT CONTENT
          Expanded(
            child: Container(
              color: const Color(0xFFF9F9F7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(_categoryImages[_selectedCategoryIndex]), fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(currentCategory, style: GoogleFonts.playfairDisplay(fontSize: 34, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      itemCount: _subCategories[currentCategory]?.length ?? 0,
                      itemBuilder: (context, index) {
                        String title = _subCategories[currentCategory]![index];
                        return _buildSubCategoryItem(context, title);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubCategoryItem(BuildContext context, String title) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductListScreen(categoryName: title)),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 0.5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500)),
            const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}