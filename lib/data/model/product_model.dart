class Product {
  final int id;
  final String title;
  final String brand;
  final double price;
  final double discountPercentage;
  final String thumbnail;
  final String category;
  final List<Review> reviews;
  final String description;
  final double rating;
  final int stock;
  final List<String> tags;
  final String sku;
  final int weight;
  final Dimensions dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final Meta meta;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    required this.discountPercentage,
    required this.thumbnail,
    required this.category,
    required this.reviews,
    required this.description,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      brand: json['brand'] ?? '',
      price: json['price'].toDouble() ?? 0.0,
      discountPercentage: json['discountPercentage'].toDouble() ?? 0.0,
      thumbnail: json['thumbnail'] ?? '',
      category: json['category'] ?? '',
      reviews: json['reviews'] != null
          ? List<Review>.from(json['reviews'].map((x) => Review.fromJson(x)))
          : [],
      description: json['description'] ?? '',
      rating: json['rating'].toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      sku: json['sku'] ?? '',
      weight: json['weight'] ?? 0,
      dimensions: json['dimensions'] != null
          ? Dimensions.fromJson(json['dimensions'])
          : Dimensions(width: 0, height: 0, depth: 0),
      warrantyInformation: json['warrantyInformation'] ?? '',
      shippingInformation: json['shippingInformation'] ?? '',
      availabilityStatus: json['availabilityStatus'] ?? '',
      returnPolicy: json['returnPolicy'] ?? '',
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 0,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : Meta(),
      images: json['images'] != null ? List<String>.from(json['images']) : [],
    );
  }
}

class Review {
  final String user;
  final String date;
  final int rating;
  final String comment;

  Review({
    required this.user,
    required this.date,
    required this.rating,
    required this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      user: json['reviewerName'] ?? '',
      date: json['date'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
    );
  }
}

class Dimensions {
  final double width;
  final double height;
  final double depth;

  Dimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: json['width'].toDouble() ?? 0.0,
      height: json['height'].toDouble() ?? 0.0,
      depth: json['depth'].toDouble() ?? 0.0,
    );
  }
}

class Meta {
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  Meta({
    this.createdAt = '',
    this.updatedAt = '',
    this.barcode = '',
    this.qrCode = '',
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      barcode: json['barcode'] ?? '',
      qrCode: json['qrCode'] ?? '',
    );
  }
}
