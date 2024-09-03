import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task2_test/data/model/product_model.dart';
import 'package:task2_test/utils/app_const.dart';
import 'package:task2_test/utils/theam_manager.dart';

import '../../provider/product_provider.dart';

class FilterDialog extends StatefulWidget {
  final ProductProvider productProvider;
  final BuildContext ctx;

  FilterDialog({required this.productProvider, required this.ctx});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  List<Product> products = [];
  List<Product> filteredProducts = [];

  @override
  void initState() {
    products = widget.productProvider.products;
    filteredProducts = widget.productProvider.filteredProducts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Filter by Brand',
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          fontSize: width * 0.06,
          color: colorMainTheme,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: products
              .where(
                  (product) => product.brand != '' && product.brand.isNotEmpty)
              .map((product) => CheckboxListTile(
                    title: Text(
                      product.brand,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.04,
                        color: colorBlack,
                      ),
                    ),
                    value: Provider.of<ProductProvider>(context, listen: true)
                        .selectedBrands
                        .contains(product.brand),
                    onChanged: (val) {
                      Provider.of<ProductProvider>(context, listen: false)
                          .toggleBrandSelection(product.brand);
                    },
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(widget.ctx).pop(),
          child: Text('OK',
              style: GoogleFonts.lato(
                  color: colorSubTittle,
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.04)),
        ),
      ],
    );
  }
}
