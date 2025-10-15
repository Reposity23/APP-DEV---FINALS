import 'package:flutter/material.dart';
import 'package:toy_store/data/dummy_data.dart';
import 'package:toy_store/models/toy.dart';

class ToyDetailScreen extends StatefulWidget {
  final Toy toy;

  const ToyDetailScreen({Key? key, required this.toy}) : super(key: key);

  @override
  State<ToyDetailScreen> createState() => _ToyDetailScreenState();
}

class _ToyDetailScreenState extends State<ToyDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageGallery(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildToyInfo(),
            ),
            const Divider(thickness: 8, color: Color(0xFFF5F5F5)),
            _buildSellerInfo(),
            const Divider(thickness: 8, color: Color(0xFFF5F5F5)),
            _buildReviewsSection(),
            const Divider(thickness: 8, color: Color(0xFFF5F5F5)),
            _buildRecommendationsSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  Widget _buildImageGallery() {
    return Container(
      height: 300,
      color: Colors.grey.shade200,
      child: Center(
        child: Image.network(
          widget.toy.imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildToyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$${widget.toy.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.toy.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          widget.toy.description,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            const Text(
              '4.8',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            const Text('(23 Reviews)'),
            const Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.toy.isFavorite = !widget.toy.isFavorite;
                });
              },
              icon: Icon(
                widget.toy.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSellerInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage('https://i.ibb.co/2S0C9mp/avatar.png'),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Toy Kingdom', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Official Store', style: TextStyle(color: Colors.grey)),
            ],
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: () {},
            child: const Text('Follow'),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reviews & Ratings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const CircleAvatar(radius: 15),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('John Doe', style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: List.generate(
                        5, (index) => const Icon(Icons.star, size: 16, color: Colors.amber)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('This is the best toy ever! My kids love it.'),
        ],
      ),
    );
  }

  Widget _buildRecommendationsSection() {
    final recommendedToys = dummyToys.where((t) => t.id != widget.toy.id).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'You Might Also Like',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recommendedToys.length,
            itemBuilder: (context, index) {
              final toy = recommendedToys[index];
              return SizedBox(
                width: 150,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ToyDetailScreen(toy: toy),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 120,
                          width: double.infinity,
                          child: Image.network(toy.imageUrl, fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(toy.name, overflow: TextOverflow.ellipsis),
                              Text(
                                '\$${toy.price.toStringAsFixed(2)}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  Widget _buildBottomAppBar() {
    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.store_mall_directory_outlined)),
                const VerticalDivider(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.chat_bubble_outline)),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade300),
                  child: const Text('Add to Cart'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  child: const Text('Buy Now'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
