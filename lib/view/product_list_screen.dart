// screens/product_list_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:task2_test/provider/product_provider.dart';
import 'package:task2_test/utils/app_const.dart';
import 'package:task2_test/utils/theam_manager.dart';
import 'package:task2_test/view/product_detail_screen.dart';
import 'package:task2_test/view/widget/filter_dailog.dart';

import '../data/model/product_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  String capitalizeWords(String text) {
    return text.split(',').map((word) => capitalize(word.trim())).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;
    final filteredProducts = productProvider.filteredProducts;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    'Product List',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: width * 0.07,
                        color: colorMainTheme,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: const Icon(Icons.filter_list),
                    onTap: () {
                      _showBrandFilterDialog(context, productProvider);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.03),
            _buildCategoryFilter(productProvider, height, width),
            SizedBox(
              height: width * 0.02,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                itemCount: filteredProducts.isEmpty
                    ? products.length
                    : filteredProducts.length,
                shrinkWrap: true,
                itemExtent: height * 0.19,
                itemBuilder: (ctx, i) {
                  final Product product = filteredProducts.isEmpty
                      ? products[i]
                      : filteredProducts[i];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: width * 0.04),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(product: product),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: colorSubTittle),
                          borderRadius: BorderRadius.circular(width * 0.04),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: width * 0.02),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(width * 0.1))),
                                    width: width * 0.3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(width * 0.04)),
                                      child: Image.network(
                                        product.thumbnail,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                if (product.discountPercentage > 0)
                                  Positioned(
                                    top: 20,
                                    left: -25,
                                    child: Transform.rotate(
                                      angle: -26,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.06,
                                            vertical: width * 0.001),
                                        color: colorRed,
                                        child: Text(
                                          '${product.discountPercentage}% OFF',
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              fontSize: width * 0.03,
                                              color: colorWhite,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Container(
                              width: width * 0.61,
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.04),
                              decoration: BoxDecoration(
                                border: BorderDirectional(
                                    start: BorderSide(color: colorSubTittle)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    product.title,
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        fontSize: width * 0.045,
                                        color: colorBlack,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: width * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        product.brand,
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                            fontSize: width * 0.04,
                                            color: colorGrey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '\$${product.price.toStringAsFixed(2)}',
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                            fontSize: width * 0.042,
                                            color: colorMainTheme,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBrandFilterDialog(
      BuildContext context, ProductProvider productProvider) {
    showDialog(
      context: context,
      builder: (ctx) {
        return FilterDialog(
          productProvider: productProvider,
          ctx: ctx,
        );
      },
    );
  }

  Widget _buildCategoryFilter(
      ProductProvider productProvider, double height, double width) {
    final categories = productProvider.products
        .map((product) => product.category)
        .toSet()
        .toList();

    return SizedBox(
      height: height * 0.055,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (ctx, i) {
          final category = categories[i];
          final isSelected =
              productProvider.selectedCategories.contains(category);
          String capitalizedResponse = capitalizeWords(category);

          return GestureDetector(
            onTap: () {
              productProvider.toggleCategorySelection(category);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: height * 0.01),
              margin: EdgeInsets.symmetric(horizontal: width * 0.02),
              decoration: BoxDecoration(
                color: isSelected ? colorMainTheme : colorGrey,
                borderRadius: BorderRadius.circular(width * 0.04),
              ),
              child: Center(
                child: Text(
                  capitalizedResponse,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: width * 0.038,
                      color: colorWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
