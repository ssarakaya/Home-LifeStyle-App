import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F7),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text("PERSONALIZATION", style: GoogleFonts.montserrat(fontSize: 10, color: const Color(0xFFB89356), letterSpacing: 1.5, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Settings", style: GoogleFonts.playfairDisplay(fontSize: 42, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),

            _buildSectionTitle("PROFILE INFORMATION"),
            _buildSettingItem("ACCOUNT INFORMATION", "Sara Kaya"),
            _buildSettingItem("DELIVERY ADDRESS", "Istanbul, Turkey"),

            const SizedBox(height: 30),
            _buildSectionTitle("APP SETTINGS"),
            _buildSettingItem("NOTIFICATIONS", "Enabled"),
            _buildSettingItem("CURRENCY", "USD (\$)"),
            _buildSettingItem("LANGUAGE", "English"),

            const SizedBox(height: 40),
            Center(
              child: Text("VICO MAISON v1.0.0", style: GoogleFonts.montserrat(fontSize: 10, color: Colors.grey)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(title, style: GoogleFonts.montserrat(fontSize: 10, color: Colors.grey.shade400, fontWeight: FontWeight.bold, letterSpacing: 1)),
    );
  }

  Widget _buildSettingItem(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
              const SizedBox(height: 4),
              Text(subtitle, style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}