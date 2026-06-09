import 'package:flutter/material.dart';
import '../data/models/product.dart';
import '../data/repositories/product_repository.dart';

class ProductProvider with ChangeNotifier {
  final ProductRepository _repository = ProductRepository();

  List<Product> _products = [];
  final List<Product> _cartItems = [];

  List<Product> get products => _products;
  List<Product> get cartItems => _cartItems;

  int get totalStockCount => _products.length;
  int get favoriteCount => _products.where((p) => p.isFavorite).length;
  int get categoryCount => _products.map((p) => p.category).toSet().length;

  double get totalCartPrice {
    double total = 0;
    for (var item in _cartItems) { total += item.price; }
    return total;
  }

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  Future<void> toggleFavorite(Product product) async {
    product.isFavorite = !product.isFavorite;
    await _repository.updateFavorite(product.id!, product.isFavorite);
    notifyListeners();
  }

  Future<void> loadProducts() async {
    try {
      _products = await _repository.fetchProducts();

      if (_products.isEmpty) {
        debugPrint("DATABASE IS EMPTY. SEEDING 108 PRODUCTS...");
        await _seedInitialData();
        _products = await _repository.fetchProducts();
      }

      debugPrint("TOTAL PRODUCTS IN DB: ${_products.length}");
      notifyListeners();
    } catch (e) {
      debugPrint("Load Error: $e");
    }
  }

  Future<void> addProduct(Product product) async {
    await _repository.addProduct(product);
    await loadProducts();
  }

  Future<void> deleteProduct(int id) async {
    await _repository.removeProduct(id);
    await loadProducts();
  }

  Future<void> updateProduct(Product product) async {
    await _repository.updateProduct(product);
    await loadProducts();
  }

  //ALL PRODUCTS
  Future<void> _seedInitialData() async {
    List<Product> seeds = [
      // DINNERWARE
      Product(name: "VICO NORDIC RIBBED", category: "DINNERWARE", price: 5200.0, imageUrl: "assets/images/dinner1.png"),
      Product(name: "VICO AUTUMN BLOSSOM", category: "DINNERWARE", price: 4850.0, imageUrl: "assets/images/dinner2.png"),
      Product(name: "VICO REGAL PEONY", category: "DINNERWARE", price: 6100.0, imageUrl: "assets/images/dinner3.png"),
      Product(name: "VICO EMERALD GARDEN", category: "DINNERWARE", price: 7400.0, imageUrl: "assets/images/dinner4.png"),
      Product(name: "VICO MODERNO SCRIPT", category: "DINNERWARE", price: 3900.0, imageUrl: "assets/images/dinner5.png"),
      Product(name: "VICO GREENLAND BOTANIC", category: "DINNERWARE", price: 8250.0, imageUrl: "assets/images/dinner6.png"),

      // BREAKFAST SETS
      Product(name: "VICO BLOOM SQUARE", category: "BREAKFAST SETS", price: 3250.0, imageUrl: "assets/images/breakfast1.png"),
      Product(name: "VICO HARMONY JAR SET", category: "BREAKFAST SETS", price: 1450.0, imageUrl: "assets/images/breakfast2.png"),
      Product(name: "VICO ROSE PORCELAIN", category: "BREAKFAST SETS", price: 4100.0, imageUrl: "assets/images/breakfast3.png"),
      Product(name: "VICO SUNFLOWER SET", category: "BREAKFAST SETS", price: 2850.0, imageUrl: "assets/images/breakfast4.png"),
      Product(name: "VICO AZURE GEOMETRY", category: "BREAKFAST SETS", price: 3600.0, imageUrl: "assets/images/breakfast5.png"),
      Product(name: "VICO BOTANIC LEAF", category: "BREAKFAST SETS", price: 3400.0, imageUrl: "assets/images/breakfast6.png"),

      // CUTLERY SETS
      Product(name: "VICO ELYSIAN SILVER", category: "CUTLERY SETS", price: 2450.0, imageUrl: "assets/images/cutlery1.png"),
      Product(name: "VICO CRIMSON FLAIR", category: "CUTLERY SETS", price: 1850.0, imageUrl: "assets/images/cutlery2.png"),
      Product(name: "VICO ARTISAN AMBER", category: "CUTLERY SETS", price: 1900.0, imageUrl: "assets/images/cutlery3.png"),
      Product(name: "VICO GEOMETRIC ROSE", category: "CUTLERY SETS", price: 3200.0, imageUrl: "assets/images/cutlery4.png"),
      Product(name: "VICO SATIN NOIR", category: "CUTLERY SETS", price: 2100.0, imageUrl: "assets/images/cutlery5.png"),
      Product(name: "VICO MODERN BRONZE", category: "CUTLERY SETS", price: 2750.0, imageUrl: "assets/images/cutlery6.png"),

      // COFFEE CUP SETS
      Product(name: "VICO ROYAL SAPPHIRE", category: "COFFEE CUP SETS", price: 1250.0, imageUrl: "assets/images/coffee1.png"),
      Product(name: "VICO AZURE GEOMETRIC", category: "COFFEE CUP SETS", price: 850.0, imageUrl: "assets/images/coffee2.png"),
      Product(name: "VICO CITRUS ORCHARD", category: "COFFEE CUP SETS", price: 1100.0, imageUrl: "assets/images/coffee3.png"),
      Product(name: "VICO AMBER RIDGE", category: "COFFEE CUP SETS", price: 950.0, imageUrl: "assets/images/coffee4.png"),
      Product(name: "VICO BLOSSOM FIESTA", category: "COFFEE CUP SETS", price: 1400.0, imageUrl: "assets/images/coffee5.png"),
      Product(name: "VICO MAJESTIC SWAN", category: "COFFEE CUP SETS", price: 1750.0, imageUrl: "assets/images/coffee6.png"),

      // GLASS & GLASSWARE
      Product(name: "VICO AMBER RIPPLE", category: "GLASS & GLASSWARE", price: 950.0, imageUrl: "assets/images/glass1.png"),
      Product(name: "VICO EMERALD FLUTE", category: "GLASS & GLASSWARE", price: 1450.0, imageUrl: "assets/images/glass2.png"),
      Product(name: "VICO AURUM DECANTER", category: "GLASS & GLASSWARE", price: 3200.0, imageUrl: "assets/images/glass3.png"),
      Product(name: "VICO CRYSTAL CASCADE", category: "GLASS & GLASSWARE", price: 2850.0, imageUrl: "assets/images/glass4.png"),
      Product(name: "VICO NOIR SMOKE", category: "GLASS & GLASSWARE", price: 2100.0, imageUrl: "assets/images/glass5.png"),
      Product(name: "VICO BAROQUE ETCHED", category: "GLASS & GLASSWARE", price: 3600.0, imageUrl: "assets/images/glass6.png"),

      // COOKING
      Product(name: "VICO SCARLET GRADIENT", category: "COOKING", price: 3850.0, imageUrl: "assets/images/cooking1.png"),
      Product(name: "VICO ANTHRACITE STONE", category: "COOKING", price: 4200.0, imageUrl: "assets/images/cooking2.png"),
      Product(name: "VICO FOREST MATTE", category: "COOKING", price: 3950.0, imageUrl: "assets/images/cooking3.png"),
      Product(name: "VICO VINTAGE ENAMEL", category: "COOKING", price: 2750.0, imageUrl: "assets/images/cooking4.png"),
      Product(name: "VICO RUBY MODERNIST", category: "COOKING", price: 3100.0, imageUrl: "assets/images/cooking5.png"),
      Product(name: "VICO EARTHEN GRANITE", category: "COOKING", price: 4500.0, imageUrl: "assets/images/cooking6.png"),

      // STORAGE & ORG.
      Product(name: "VICO CITRUS STACK", category: "STORAGE & ORG.", price: 850.0, imageUrl: "assets/images/storage1.png"),
      Product(name: "VICO BAMBOO HERMETIC", category: "STORAGE & ORG.", price: 1100.0, imageUrl: "assets/images/storage2.png"),
      Product(name: "VICO VACUUM ROUND", category: "STORAGE & ORG.", price: 450.0, imageUrl: "assets/images/storage3.png"),
      Product(name: "VICO SLATE MODULAR", category: "STORAGE & ORG.", price: 1350.0, imageUrl: "assets/images/storage4.png"),
      Product(name: "VICO ESSENTIAL GLASS", category: "STORAGE & ORG.", price: 550.0, imageUrl: "assets/images/storage5.png"),
      Product(name: "VICO CRYSTAL LOCK", category: "STORAGE & ORG.", price: 950.0, imageUrl: "assets/images/storage6.png"),

      // KNIFE SETS
      Product(name: "VICO CHAMPAGNE STEAK", category: "KNIFE SETS", price: 1850.0, imageUrl: "assets/images/knife1.png"),
      Product(name: "VICO PASTEL TRIO", category: "KNIFE SETS", price: 750.0, imageUrl: "assets/images/knife2.png"),
      Product(name: "VICO CHEF MASTER", category: "KNIFE SETS", price: 2100.0, imageUrl: "assets/images/knife3.png"),
      Product(name: "VICO COPPER WOOD", category: "KNIFE SETS", price: 3400.0, imageUrl: "assets/images/knife4.png"),
      Product(name: "VICO FRESH GREEN", category: "KNIFE SETS", price: 450.0, imageUrl: "assets/images/knife5.png"),
      Product(name: "VICO OCEAN MARBLE", category: "KNIFE SETS", price: 1950.0, imageUrl: "assets/images/knife6.png"),

      // KITCHEN TOOLS
      Product(name: "VICO PRECISION TONGS", category: "KITCHEN TOOLS", price: 250.0, imageUrl: "assets/images/tools1.png"),
      Product(name: "VICO BAMBOO SPATULA", category: "KITCHEN TOOLS", price: 150.0, imageUrl: "assets/images/tools2.png"),
      Product(name: "VICO MIDNIGHT SERVER", category: "KITCHEN TOOLS", price: 180.0, imageUrl: "assets/images/tools3.png"),
      Product(name: "VICO MASTER WHISK", category: "KITCHEN TOOLS", price: 220.0, imageUrl: "assets/images/tools4.png"),
      Product(name: "VICO RAINBOW SET", category: "KITCHEN TOOLS", price: 450.0, imageUrl: "assets/images/tools5.png"),
      Product(name: "VICO INDUSTRIAL MASHER", category: "KITCHEN TOOLS", price: 280.0, imageUrl: "assets/images/tools6.png"),

      // COFFEE MACHINES
      Product(name: "VICO AERO-DRIP", category: "COFFEE MACHINES", price: 2450.0, imageUrl: "assets/images/appliance1.png"),
      Product(name: "VICO BARISTA PRO", category: "COFFEE MACHINES", price: 8900.0, imageUrl: "assets/images/appliance2.png"),
      Product(name: "VICO SCARLET MOKA", category: "COFFEE MACHINES", price: 1200.0, imageUrl: "assets/images/appliance3.png"),
      Product(name: "VICO NOIR BREWER", category: "COFFEE MACHINES", price: 3600.0, imageUrl: "assets/images/appliance4.png"),
      Product(name: "VICO BEAN-TO-CUP", category: "COFFEE MACHINES", price: 5200.0, imageUrl: "assets/images/appliance5.png"),
      Product(name: "VICO TURKISH BREWER", category: "COFFEE MACHINES", price: 2750.0, imageUrl: "assets/images/appliance6.png"),

      // FOOD PREP
      Product(name: "VICO PRECISION SCALE", category: "FOOD PREP", price: 650.0, imageUrl: "assets/images/prep1.png"),
      Product(name: "VICO SMART-SCALE", category: "FOOD PREP", price: 1250.0, imageUrl: "assets/images/prep2.png"),
      Product(name: "VICO MASTER SHEARS", category: "FOOD PREP", price: 450.0, imageUrl: "assets/images/prep3.png"),
      Product(name: "VICO PIZZA WHEEL", category: "FOOD PREP", price: 320.0, imageUrl: "assets/images/prep4.png"),
      Product(name: "VICO CRIMSON SET", category: "FOOD PREP", price: 2100.0, imageUrl: "assets/images/prep5.png"),
      Product(name: "VICO GREEN MIXER", category: "FOOD PREP", price: 850.0, imageUrl: "assets/images/prep6.png"),

      // VACUUM CLEANERS
      Product(name: "VICO NAVY STICK", category: "VACUUM CLEANERS", price: 3850.0, imageUrl: "assets/images/vacuum1.png"),
      Product(name: "VICO BLUSH AIR", category: "VACUUM CLEANERS", price: 3400.0, imageUrl: "assets/images/vacuum2.png"),
      Product(name: "VICO RUBY CORDLESS", category: "VACUUM CLEANERS", price: 3600.0, imageUrl: "assets/images/vacuum3.png"),
      Product(name: "VICO TANGERINE TURBO", category: "VACUUM CLEANERS", price: 3200.0, imageUrl: "assets/images/vacuum4.png"),
      Product(name: "VICO PLUM ROBOT", category: "VACUUM CLEANERS", price: 4950.0, imageUrl: "assets/images/vacuum5.png"),
      Product(name: "VICO TITANIUM DUAL", category: "VACUUM CLEANERS", price: 5200.0, imageUrl: "assets/images/vacuum6.png"),

      // BEDROOM
      Product(name: "VICO NOIR VELVET", category: "BEDROOM", price: 3400.0, imageUrl: "assets/images/bedroom1.png"),
      Product(name: "VICO AMETHYST SET", category: "BEDROOM", price: 2850.0, imageUrl: "assets/images/bedroom2.png"),
      Product(name: "VICO BOTANIC LINEN", category: "BEDROOM", price: 2100.0, imageUrl: "assets/images/bedroom3.png"),
      Product(name: "VICO BLUSH QUILTED", category: "BEDROOM", price: 3200.0, imageUrl: "assets/images/bedroom4.png"),
      Product(name: "VICO SILVER RIDGE", category: "BEDROOM", price: 3600.0, imageUrl: "assets/images/bedroom5.png"),
      Product(name: "VICO AZURE STRIPE", category: "BEDROOM", price: 2450.0, imageUrl: "assets/images/bedroom6.png"),

      // DECORATION
      Product(name: "VICO ETHEREAL TOTEM", category: "DECORATION", price: 4200.0, imageUrl: "assets/images/deco1.png"),
      Product(name: "VICO GOLDEN AURA", category: "DECORATION", price: 2850.0, imageUrl: "assets/images/deco2.png"),
      Product(name: "VICO TEAL HARMONY", category: "DECORATION", price: 3100.0, imageUrl: "assets/images/deco3.png"),
      Product(name: "VICO ROYAL VASES", category: "DECORATION", price: 3600.0, imageUrl: "assets/images/deco4.png"),
      Product(name: "VICO BLUSH MOON", category: "DECORATION", price: 1250.0, imageUrl: "assets/images/deco5.png"),
      Product(name: "VICO SAPPHIRE JARS", category: "DECORATION", price: 4500.0, imageUrl: "assets/images/deco6.png"),

      // RUGS
      Product(name: "VICO ANATOLIAN RUG", category: "RUGS", price: 5200.0, imageUrl: "assets/images/rug1.png"),
      Product(name: "VICO IVORY ROUND", category: "RUGS", price: 3450.0, imageUrl: "assets/images/rug2.png"),
      Product(name: "VICO ROMANCE HEART", category: "RUGS", price: 2800.0, imageUrl: "assets/images/rug3.png"),
      Product(name: "VICO AZURE KILIM", category: "RUGS", price: 3900.0, imageUrl: "assets/images/rug4.png"),
      Product(name: "VICO AMBER SHAG", category: "RUGS", price: 3200.0, imageUrl: "assets/images/rug5.png"),
      Product(name: "VICO BOHO RUNNER", category: "RUGS", price: 2650.0, imageUrl: "assets/images/rug6.png"),

      // BATHROOM
      Product(name: "VICO BLUSH CERAMIC", category: "BATHROOM", price: 850.0, imageUrl: "assets/images/bath1.png"),
      Product(name: "VICO CRYSTAL SET", category: "BATHROOM", price: 1100.0, imageUrl: "assets/images/bath2.png"),
      Product(name: "VICO MOSAIC MAT", category: "BATHROOM", price: 1450.0, imageUrl: "assets/images/bath3.png"),
      Product(name: "VICO CHARCOAL RUG", category: "BATHROOM", price: 1250.0, imageUrl: "assets/images/bath4.png"),
      Product(name: "VICO SATIN CHROME", category: "BATHROOM", price: 2100.0, imageUrl: "assets/images/bath5.png"),
      Product(name: "VICO ROSE COPPER", category: "BATHROOM", price: 2250.0, imageUrl: "assets/images/bath6.png"),


      // SPORTS
      Product(name: "VICO SPEED ROPE", category: "SPORTS", price: 350.0, imageUrl: "assets/images/hobby1.png"),
      Product(name: "VICO CORE STRENGTH", category: "SPORTS", price: 1200.0, imageUrl: "assets/images/hobby4.png"),
      Product(name: "VICO HYDRA BLUSH", category: "SPORTS", price: 450.0, imageUrl: "assets/images/hobby2.png"),

      // KITCHEN BUNDLES
      Product(name: "VICO NOIR KITCHEN", category: "KITCHEN BUNDLES", price: 18500.0, imageUrl: "assets/images/bundle1.png"),
      Product(name: "VICO IVORY KITCHEN", category: "KITCHEN BUNDLES", price: 18500.0, imageUrl: "assets/images/bundle2.png"),
      Product(name: "VICO CITRINE KITCHEN", category: "KITCHEN BUNDLES", price: 18500.0, imageUrl: "assets/images/bundle3.png"),
      Product(name: "VICO AMETHYST KITCHEN", category: "KITCHEN BUNDLES", price: 18500.0, imageUrl: "assets/images/bundle4.png"),
      Product(name: "VICO SAPPHIRE KITCHEN", category: "KITCHEN BUNDLES", price: 18500.0, imageUrl: "assets/images/bundle5.png"),
      Product(name: "VICO RUBY KITCHEN", category: "KITCHEN BUNDLES", price: 18500.0, imageUrl: "assets/images/bundle6.png"),
    ];

    for (var p in seeds) {
      await _repository.addProduct(p);
    }
  }
}