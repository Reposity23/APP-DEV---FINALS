class Toy {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryId;
  bool isFavorite;

  Toy({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    this.isFavorite = false,
  });
}
