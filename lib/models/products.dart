class Product {
  final String id;
  final String title;
  final String description;
  final double amount;
  final String imageUrl;
  bool isFavourite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.amount,
      required this.imageUrl,
    this.isFavourite = false
      });
}
