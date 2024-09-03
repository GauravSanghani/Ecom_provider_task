import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task2_test/provider/product_provider.dart';
import 'package:task2_test/view/widget/star_rating.dart';

import 'package:task2_test/utils/theam_manager.dart';
import 'package:intl/intl.dart';

import '../data/model/product_model.dart';
import '../utils/app_const.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    String day = DateFormat('d').format(dateTime); // Day without leading zeros
    String suffix;

    // Determine the suffix (st, nd, rd, th)
    if (day.endsWith('1') && !day.endsWith('11')) {
      suffix = 'st';
    } else if (day.endsWith('2') && !day.endsWith('12')) {
      suffix = 'nd';
    } else if (day.endsWith('3') && !day.endsWith('13')) {
      suffix = 'rd';
    } else {
      suffix = 'th';
    }

    return DateFormat("d'$suffix' MMMM yyyy").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: colorMainTheme,
                        size: width * 0.055,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    SizedBox(
                      width: width * 0.75,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        widget.product.title,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: width * 0.06,
                            color: colorMainTheme,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              SizedBox(
                height: height * 0.55,
                width: width,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.product.images.length,
                        onPageChanged: (index) {
                          Provider.of<ProductProvider>(context, listen: false)
                              .changeIndex(index);
                        },
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: height * 0.5,
                            child: Image.network(
                              widget.product.images[index],
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),
                    ),
                    widget.product.images.length != 1
                        ? _buildDots(
                            context,
                            Provider.of<ProductProvider>(context, listen: true)
                                .currentIndex)
                        : const SizedBox(),
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: Row(
                  children: [
                    Text(
                      "-${widget.product.discountPercentage} %  ",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: width * 0.055,
                          color: colorRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "\$ ${widget.product.price.toString()}",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: width * 0.055,
                          color: colorBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Row(
                  children: [
                    Text(
                      widget.product.availabilityStatus == "In Stock"
                          ? "Currently Available"
                          : widget.product.availabilityStatus,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: width * 0.05,
                          color: widget.product.availabilityStatus == "In Stock"
                              ? colorGreen
                              : colorRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "  (${widget.product.stock} qty.)",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: width * 0.04,
                          color: colorBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                height: 1,
                width: width,
                color: colorLightGrey,
              ),
              SizedBox(height: height * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Text(
                  "Product Details",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: width * 0.055,
                      color: colorSubTittle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              Container(
                height: 1,
                width: width,
                color: colorLightGrey,
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductDetail(
                        context, "Product", widget.product.title, 0),
                    SizedBox(height: height * 0.01),
                    _buildProductDetail(
                        context, "Brand", widget.product.brand, 0),
                    SizedBox(height: height * 0.01),
                    _buildProductDetail(context, "Min. Order",
                        "${widget.product.minimumOrderQuantity} Qty.", 0),
                    SizedBox(height: height * 0.01),
                    _buildProductDetail(
                        context,
                        "Size",
                        "${widget.product.dimensions.height} x ${widget.product.dimensions.width} x ${widget.product.dimensions.depth} unit³  (h x w x d)",
                        0),
                    SizedBox(height: height * 0.01),
                    _buildProductDetail(
                        context, "Weight", "${widget.product.weight} unit", 0),
                    SizedBox(height: height * 0.01),
                    _buildProductDetail(
                        context,
                        "Rating",
                        "${widget.product.rating}",
                        widget.product.rating.toInt()),
                    SizedBox(height: height * 0.01),
                    _buildProductDetail(
                        context, "●", widget.product.description, 0),
                    SizedBox(height: height * 0.01),
                    _buildProductDetail(context, "Warranty",
                        widget.product.warrantyInformation, 0),
                    SizedBox(height: height * 0.01),
                    _buildProductDetail(context, "Shipping",
                        widget.product.shippingInformation, 0),
                    SizedBox(height: height * 0.01),
                    _buildProductDetail(context, "Return Policy",
                        widget.product.returnPolicy, 0),
                    SizedBox(height: height * 0.03),
                  ],
                ),
              ),
              _buildReviews(context, widget.product),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDots(BuildContext context, int currentIndex) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.product.images.length,
        (index) => Padding(
          padding: EdgeInsets.all(width * 0.015),
          child: Container(
            width: currentIndex == index ? width * 0.055 : width * 0.025,
            height: width * 0.025,
            decoration: BoxDecoration(
              border: Border.all(color: colorMainTheme),
              borderRadius: BorderRadius.circular(21),
              color: currentIndex == index ? colorMainTheme : colorBackground,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetail(
      BuildContext context, String title, String subTitle, int rating) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: title == "Return Policy"
              ? width * 0.28
              : title != "●"
                  ? width * 0.22
                  : width * 0.07,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: title == "Product" ? width * 0.045 : width * 0.04,
                    color: title != "●" ? colorBlack : colorGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title != "●"
                  ? Text(
                      ":",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize:
                              title == "Product" ? width * 0.045 : width * 0.04,
                          color: colorBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        title != "Rating"
            ? SizedBox(
                width: title == "Return Policy"
                    ? width * 0.62
                    : title != "●"
                        ? width * 0.68
                        : width * 0.85,
                child: Text(
                  overflow: TextOverflow.fade,
                  subTitle,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize:
                          title == "Product" ? width * 0.045 : width * 0.04,
                      color: title != "●" ? colorBlack : colorGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            : SizedBox(
                width: width * 0.68,
                child: StarRating(
                  rating: rating.toDouble(),
                  starSize: width * 0.07, // Adjust the star size as needed
                  filledStarColor: colorSubTittle,
                  unfilledStarColor: colorLightGrey,
                ),
              ),
      ],
    );
  }

  Widget _buildReviews(BuildContext context, Product product) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          width: width,
          color: colorLightGrey,
        ),
        SizedBox(height: height * 0.01),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Text(
            "Reviews",
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontSize: width * 0.055,
                color: colorSubTittle,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: height * 0.01),
        Container(
          height: 1,
          width: width,
          color: colorLightGrey,
        ),
        SizedBox(height: height * 0.01),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            children: product.reviews
                .map((review) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "👤 ${review.user}",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: width * 0.045,
                            color: colorBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reviewed on ${formatDate(review.date)}",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: width * 0.038,
                                color: colorGrey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          StarRating(
                            rating: review.rating.toDouble(),
                            starSize:
                                width * 0.07, // Adjust the star size as needed
                            filledStarColor: colorSubTittle,
                            unfilledStarColor: colorLightGrey,
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            review.comment,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: width * 0.038,
                                color: colorBlack,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
