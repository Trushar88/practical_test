// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:practical_test/ui/home/components/category_widget.dart';
import 'package:practical_test/ui/home/components/multiselect_dialog.dart';
import 'package:practical_test/ui/home/home_provider.dart';
import 'package:practical_test/app/config/app_colors.dart';
import 'package:practical_test/app/config/app_strings.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: APPCOLOR.BlACKCOLOR,
        title: const Text(
          APPSTRING.product_List,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: () {
              _showBrandFilterDialog(context);
            },
            child: Container(
              height: 30,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    APPSTRING.filter,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const CategoryWidget(),
          Expanded(
            child: productProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : productProvider.errorMessage.isNotEmpty
                    ? Center(child: Text(productProvider.errorMessage))
                    : Container(
                        decoration: BoxDecoration(color: APPCOLOR.PRIMARYCOLOR.withOpacity(0.2)),
                        child: ListView.builder(
                          itemCount: productProvider.products.length,
                          itemBuilder: (context, index) {
                            final product = productProvider.products[index];
                            return InkWell(
                              onTap: () {
                                productProvider.navidateToReview(context: context, data: product);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Banner(
                                  location: BannerLocation.topStart,
                                  color: (product.discountPercentage != null && double.parse(product.discountPercentage!) > 0) ? Colors.red : Colors.transparent,
                                  message: (product.discountPercentage != null && double.parse(product.discountPercentage!) > 0)
                                      ? '${APPSTRING.sale} ${double.parse(product.discountPercentage!).toStringAsFixed(0)}%'
                                      : "",
                                  child: Container(
                                    decoration: const BoxDecoration(color: Colors.white),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(8),
                                      leading: Image.network(product.thumbnail ?? '', fit: BoxFit.cover, width: 80),
                                      title: Text(
                                        product.title ?? APPSTRING.no_Title,
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text('\$${product.price?.toStringAsFixed(2) ?? APPSTRING.no_Price}'),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => productProvider.fetchProducts(),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Fetch products when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  void _showBrandFilterDialog(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Brands'),
          content: SizedBox(
            height: 400,
            width: 500,
            child: MultiSelectDialog(
              items: productProvider.uniqueBrands,
              onSelectionChanged: (selectedBrands) {
                for (var brand in selectedBrands) {
                  productProvider.selectBrand(brand);
                }
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
