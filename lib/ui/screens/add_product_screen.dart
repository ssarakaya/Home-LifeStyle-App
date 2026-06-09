import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../business/product_provider.dart';
import '../../data/models/product.dart';

class AddProductScreen extends StatefulWidget {
  final Product? productToEdit; // It adds if it's empty, and edits if it's full.

  const AddProductScreen({super.key, this.productToEdit});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _category;
  late double _price;
  late String _imageFileName;

  final List<String> _categories = [
    "DINNERWARE", "BREAKFAST SETS", "CUTLERY SETS", "COFFEE CUP SETS",
    "GLASS & GLASSWARE", "COOKING", "STORAGE & ORG.", "KNIFE SETS",
    "KITCHEN TOOLS", "COFFEE MACHINES", "FOOD PREP", "VACUUM CLEANERS",
    "BEDROOM", "DECORATION", "RUGS", "BATHROOM", "KITCHEN BUNDLES", "SPORTS"
  ];

  @override
  void initState() {
    super.initState();
    // If we are in edit mode, populate the form fields with old data.
    _name = widget.productToEdit?.name ?? '';
    _category = widget.productToEdit?.category ?? 'DINNERWARE';
    _price = widget.productToEdit?.price ?? 0;
    _imageFileName = widget.productToEdit?.imageUrl.replaceAll('assets/images/', '') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    bool isEditMode = widget.productToEdit != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(isEditMode ? "EDIT PIECE" : "ADD TO INVENTORY",
            style: GoogleFonts.playfairDisplay(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: "PIECE NAME"),
                validator: (value) => value!.isEmpty ? "Enter a name" : null,
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _category,
                items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (value) => setState(() => _category = value!),
                decoration: InputDecoration(labelText: "CATEGORY"),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _price > 0 ? _price.toString() : "",
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "PRICE (USD)"),
                validator: (value) => double.tryParse(value!) == null ? "Enter valid price" : null,
                onSaved: (value) => _price = double.parse(value!),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _imageFileName,
                decoration: InputDecoration(labelText: "IMAGE NAME (e.g. dinner1.png)"),
                onSaved: (value) => _imageFileName = value!,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final fullPath = _imageFileName.startsWith('http')
                        ? _imageFileName : 'assets/images/$_imageFileName';

                    final product = Product(
                      id: widget.productToEdit?.id, //Protect ID if there is one
                      name: _name,
                      category: _category,
                      price: _price,
                      imageUrl: fullPath,
                      isFavorite: widget.productToEdit?.isFavorite ?? false,
                    );

                    final provider = Provider.of<ProductProvider>(context, listen: false);

                    if (isEditMode) {
                      await provider.updateProduct(product);
                    } else {
                      await provider.addProduct(product);
                    }

                    if (mounted) Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: Text(isEditMode ? "UPDATE PIECE" : "SAVE PIECE",
                    style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}