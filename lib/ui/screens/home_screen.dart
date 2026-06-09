import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:vico_maison/business/product_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // SLIDING WINDOW SETTINGS
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // Slider Contents
  final List<Map<String, String>> _sliderData = [
    {
      "sub": "CRAFTSMANSHIP",
      "title": "Traditional\nTouch\nfor Modern\nLiving",
      "desc": "Each piece is carefully selected according to our criteria of quality, durability, and timeless aesthetics.",
      "img": "https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=1000"
    },
    {
      "sub": "EST. 2024 — VICO MAISON",
      "title": "Quiet\nLuxury",
      "desc": "Your home is a reflection of your soul. Add character to your living space with our curated timeless pieces.",
      "img": "https://images.unsplash.com/photo-1616489953149-80798991a8e1?q=80&w=1000"
    },
    {
      "sub": "VICO LOOKBOOK",
      "title": "Inspired\nSpaces",
      "desc": "Tell a story in every corner of your home. Quality and peace in every touch.",
      "img": "https://images.unsplash.com/photo-1513519245088-0e12902e5a38?q=80&w=1000"
    },
  ];

  @override
  void initState() {
    super.initState();
    // We set a timer for automatic scrolling every 5 seconds.
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _sliderData.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 1000), // sliding speed
          curve: Curves.easeInOutQuart,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Turn off the timer to prevent memory leakage.
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("VICO", style: GoogleFonts.playfairDisplay(color: Colors.black, letterSpacing: 4, fontWeight: FontWeight.bold)),
        leading: const Icon(Icons.search, color: Colors.black),
        actions: const [Icon(Icons.shopping_bag_outlined, color: Colors.black), SizedBox(width: 15)],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                //  1. SLIDING WINDOW
                _buildAnimatedHeroSlider(),

                // 2. Vico Lookbook
                _buildLookbookSection(),

                // 3. Philosophy
                _buildPhilosophySection(),

                // 4. Newsletter
                _buildNewsletterSection(),

                // 5. Footer
                _buildFooter(),
              ],
            ),
          ),
          // Chat Button
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
              child: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 28),
            ),
          )
        ],
      ),
    );
  }

  // SLIDING WINDOW WIDGET
  Widget _buildAnimatedHeroSlider() {
    return SizedBox(
      height: 750, // maintaining the height in the design
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) => setState(() => _currentPage = page),
            itemCount: _sliderData.length,
            itemBuilder: (context, index) {
              return _buildSliderItem(_sliderData[index]);
            },
          ),
          // Page Indicators
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_sliderData.length, (index) => _buildIndicator(index)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderItem(Map<String, String> data) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(data['img']!),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.25),
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data['sub']!, style: GoogleFonts.montserrat(color: Colors.white, letterSpacing: 4, fontSize: 10, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(data['title']!, textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(fontSize: 52, color: Colors.white, height: 1.1, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500)),
            const SizedBox(height: 40),
            Text(data['desc']!, textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(color: Colors.white, fontSize: 13, height: 1.6)),
            const SizedBox(height: 50),
            Container(
              width: 250,
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Colors.white,
              child: Center(child: Text("READ OUR STORY", style: GoogleFonts.montserrat(letterSpacing: 2, fontSize: 10, fontWeight: FontWeight.bold))),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 2,
      width: _currentPage == index ? 30 : 12,
      color: _currentPage == index ? Colors.white : Colors.white54,
    );
  }


  Widget _buildLookbookSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
      child: Column(
        children: [
          Text("VICO LOOKBOOK", style: GoogleFonts.montserrat(color: const Color(0xFFB89356), fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text("Be Inspired by\nYour Living\nSpace", textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(fontSize: 48, height: 1.1, fontWeight: FontWeight.bold)),
          const SizedBox(height: 60),
          Container(
            padding: const EdgeInsets.all(40),
            color: const Color(0xFFF9F9F7),
            child: Column(
              children: [
                Text("Preparing Visual", style: GoogleFonts.playfairDisplay(fontSize: 32, fontStyle: FontStyle.italic)),
                const SizedBox(height: 20),
                Text("YOU MAY NEED TO SELECT AN API KEY TO VIEW PREMIUM VISUALS.", textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(fontSize: 10, color: Colors.grey, letterSpacing: 2)),
                const SizedBox(height: 40),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20), side: const BorderSide(color: Colors.black12)),
                  child: Text("SELECT API KEY", style: GoogleFonts.montserrat(color: Colors.black, fontSize: 10, letterSpacing: 2)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPhilosophySection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      child: Column(
        children: [
          const Text("\"", style: TextStyle(fontSize: 40, color: Color(0xFFB89356))),
          Text("Design is not just how it looks, but how it feels. Experience quality and peace in every touch with VICO Maison.",
              textAlign: TextAlign.center, style: GoogleFonts.playfairDisplay(fontSize: 28, fontStyle: FontStyle.italic, height: 1.5)),
          const SizedBox(height: 30),
          Container(height: 1, width: 60, color: const Color(0xFFB89356)),
          const SizedBox(height: 15),
          Text("VICO PHILOSOPHY", style: GoogleFonts.montserrat(fontSize: 10, color: Colors.grey, letterSpacing: 2)),
        ],
      ),
    );
  }

  Widget _buildNewsletterSection() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF9F9F7),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
      child: Column(
        children: [
          Text("NEWSLETTER", style: GoogleFonts.montserrat(color: const Color(0xFFB89356), fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text("Join Our Exclusive World", textAlign: TextAlign.center, style: GoogleFonts.playfairDisplay(fontSize: 38, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Text("Be the first to know about new collections, special invitations, and design tips.",
              textAlign: TextAlign.center, style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 13, height: 1.6)),
          const SizedBox(height: 50),
          const TextField(
            decoration: InputDecoration(hintText: "Your email address", hintStyle: TextStyle(color: Colors.grey, fontSize: 13), enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12))),
          ),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: Colors.black,
            child: Center(child: Text("SUBSCRIBE", style: GoogleFonts.montserrat(color: Colors.white, letterSpacing: 2, fontSize: 10))),
          )
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0A0A0A),
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("VICO", style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold, letterSpacing: 4)),
          const SizedBox(height: 15),
          Text("Where elegance meets quality. We offer carefully curated, timeless designs for your home.",
              style: GoogleFonts.montserrat(color: Colors.white54, fontSize: 12, height: 1.6)),
          const SizedBox(height: 30),
          Row(
            children: [
              _socialIcon(Icons.camera_alt_outlined),
              const SizedBox(width: 15),
              _socialIcon(Icons.alternate_email),
              const SizedBox(width: 15),
              _socialIcon(Icons.facebook),
            ],
          ),
          const SizedBox(height: 60),
          Text("EXPLORE", style: GoogleFonts.montserrat(color: const Color(0xFFB89356), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 25),
          _footerLink("ALL CATEGORIES"),
          _footerLink("NEW ARRIVALS"),
          _footerLink("BEST SELLERS"),
          _footerLink("ABOUT US"),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all(color: Colors.white10)),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  Widget _footerLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(text, style: GoogleFonts.montserrat(color: Colors.white70, fontSize: 11, letterSpacing: 1)),
    );
  }
}