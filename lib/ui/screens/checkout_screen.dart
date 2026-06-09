import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../business/product_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text("CHECKOUT", style: GoogleFonts.playfairDisplay(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 2)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("SHIPPING ADDRESS", style: GoogleFonts.montserrat(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: const Color(0xFFB89356))),
              const SizedBox(height: 20),
              _buildSimpleInput("Full Name", "Sara Kaya"),
              _buildSimpleInput("Address", "Levent, Istanbul, TR"),

              const SizedBox(height: 40),
              Text("PAYMENT METHOD", style: GoogleFonts.montserrat(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: const Color(0xFFB89356))),
              const SizedBox(height: 20),
              _buildSimpleInput("Card Number", "0000 0000 0000 0000", isNumber: true),
              Row(
                children: [
                  Expanded(child: _buildSimpleInput("Expiry", "MM/YY", isNumber: true)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildSimpleInput("CVV", "000", isNumber: true)),
                ],
              ),

              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 20),

              // Order Summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("SUBTOTAL", style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey)),
                  Text("\$${provider.totalCartPrice.toStringAsFixed(2)}", style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("SHIPPING", style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey)),
                  Text("FREE", style: GoogleFonts.montserrat(fontSize: 12, color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 60),

              // Complete Payment Button
              ElevatedButton(
                onPressed: () {
                  // Payment success simulation
                  _showSuccessDialog(context, provider);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 65),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: Text("COMPLETE PAYMENT", style: GoogleFonts.montserrat(color: Colors.white, letterSpacing: 2, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleInput(String label, String hint, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey),
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, ProductProvider provider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        title: const Icon(Icons.check_circle_outline, size: 60, color: Color(0xFFB89356)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("THANK YOU", style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Your order has been received and is being prepared with care.", textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              provider.clearCart(); // Clear cart
              Navigator.of(context).popUntil((route) => route.isFirst); //Return to home page
            },
            child: Text("BACK TO SHOPPING", style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}