import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui'; // Blur effect
import '../main_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. BACKGROUND
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?q=80&w=1000"), // modern interior
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. 2. DARKEN LAYER
          Container(color: Colors.black.withOpacity(0.3)),

          // 3. Contents
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                // TOP SECTION: Brand Identity
                _buildHeader(),

                const Spacer(), // Push the form down

                // 4. 4. INPUT PANEL
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.92),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, -5))
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Maison Portal", style: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text("Experience the curation of timeless aesthetics.",
                            style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey.shade600)),

                        const SizedBox(height: 35),

                        // Form Fields
                        _buildInputField("EMAIL ADDRESS", Icons.alternate_email, false),
                        const SizedBox(height: 25),
                        _buildInputField("PASSWORD", Icons.lock_outline, true),

                        const SizedBox(height: 35),

                        // LOGIN BUTTON
                        _buildLoginButton(context),

                        const SizedBox(height: 30),

                        // SOCIAL ACCESS AND SUB-SECTIONS
                        _buildSocialSection(),

                        const SizedBox(height: 20),
                        Center(
                          child: Text("By continuing, you agree to VICO's Terms of Service.",
                              style: GoogleFonts.montserrat(fontSize: 9, color: Colors.grey.shade400)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Brand Header Widget
  Widget _buildHeader() {
    return Column(
      children: [
        Text("VICO", style: GoogleFonts.playfairDisplay(fontSize: 60, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 12)),
        const SizedBox(height: 5),
        Container(height: 1, width: 100, color: const Color(0xFFB89356)),
        const SizedBox(height: 10),
        Text("ESTABLISHED 2024", style: GoogleFonts.montserrat(color: Colors.white70, fontSize: 10, letterSpacing: 4)),
      ],
    );
  }

  // Modern Input Design
  Widget _buildInputField(String label, IconData icon, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.montserrat(fontSize: 9, color: const Color(0xFFB89356), fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        TextFormField(
          obscureText: isPassword && !_isPasswordVisible,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18, color: Colors.black54),
            suffixIcon: isPassword ? IconButton(
              icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, size: 18),
              onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
            ) : null,
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFB89356))),
          ),
        ),
      ],
    );
  }

  // Login Button
  Widget _buildLoginButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: const Color(0xFFB89356).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainNavigation())),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: Text("ENTER THE MAISON", style: GoogleFonts.montserrat(color: Colors.white, letterSpacing: 3, fontWeight: FontWeight.bold, fontSize: 12)),
      ),
    );
  }

  // Social icons and  Divider
  Widget _buildSocialSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade200)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text("QUICK ACCESS", style: GoogleFonts.montserrat(fontSize: 8, color: Colors.grey.shade400, fontWeight: FontWeight.bold)),
            ),
            Expanded(child: Divider(color: Colors.grey.shade200)),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialCircle(Icons.apple),
            const SizedBox(width: 25),
            _socialCircle(Icons.fingerprint),
            const SizedBox(width: 25),
            _socialCircle(Icons.face),
          ],
        ),
      ],
    );
  }

  Widget _socialCircle(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Icon(icon, size: 22, color: Colors.black87),
    );
  }
}