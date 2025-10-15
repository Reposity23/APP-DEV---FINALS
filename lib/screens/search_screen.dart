import 'package:flutter/material.dart';
import 'package:toy_store/data/dummy_data.dart';
import 'package:toy_store/models/toy.dart';
import 'package:toy_store/screens/toy_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Toy> _searchResults = [];

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _searchResults = dummyToys
          .where((toy) => toy.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Toys'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _performSearch,
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final toy = _searchResults[index];
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
          ),
        ],
      ),
    );
  }
}
