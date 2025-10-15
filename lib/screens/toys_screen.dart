import 'package:flutter/material.dart';
import 'package:toy_store/data/dummy_data.dart';
import 'package:toy_store/models/category.dart';
import 'package:toy_store/models/toy.dart';
import 'package:toy_store/screens/toy_detail_screen.dart';

class ToysScreen extends StatelessWidget {
  const ToysScreen({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final List<Toy> categoryToys = dummyToys
        .where((toy) => toy.categoryId == category.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemCount: categoryToys.length,
        itemBuilder: (context, index) {
          final toy = categoryToys[index];
          return ListTile(
            leading: Image.network(toy.imageUrl),
            title: Text(toy.name),
            subtitle: Text('\$${toy.price.toStringAsFixed(2)}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ToyDetailScreen(toy: toy),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
