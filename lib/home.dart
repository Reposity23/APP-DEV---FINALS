import 'package:flutter/material.dart';
import 'package:toy_store/data/dummy_data.dart';
import 'package:toy_store/models/toy.dart';
import 'package:toy_store/screens/search_screen.dart';
import 'package:toy_store/screens/toy_detail_screen.dart';
import 'package:toy_store/screens/toy_mall.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    ToyMallScreen(),
    Text('Messages'),
    Text('Cart'),
    Text('Account'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'For You',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_mall_directory_outlined),
            label: 'ToyMall',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        _buildSliverAppBar(context),
        SliverToBoxAdapter(child: _buildPromoBanner()),
        SliverToBoxAdapter(child: _buildQuickActions()),
        SliverToBoxAdapter(child: _buildFlashSaleSection()),
        _buildForYouSection(),
      ],
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.deepPurple,
      floating: true,
      pinned: true,
      snap: false,
      title: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchScreen()),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(
                'Search for toys',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      height: 150,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: NetworkImage('https://i.ibb.co/CbfS1zW/sale-banner.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildQuickActionItem(Icons.card_giftcard, 'Vouchers'),
          _buildQuickActionItem(Icons.local_shipping, 'Free Shipping'),
          _buildQuickActionItem(Icons.flash_on, 'Toy Deals'),
          _buildQuickActionItem(Icons.new_releases, 'New Arrivals'),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.deepPurple, size: 30),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildFlashSaleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Text(
                'ToyFlash',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              SizedBox(width: 10),
              Spacer(),
              Text('Shop All >'),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              final toy = dummyToys[index];
              return _buildProductCard(context, toy);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildForYouSection() {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final toy = dummyToys[index + 4];
            return _buildProductCard(context, toy);
          },
          childCount: dummyToys.length - 4,
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Toy toy) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ToyDetailScreen(toy: toy),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                toy.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    toy.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${toy.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      Text(' 4.8', style: TextStyle(fontSize: 12)),
                      Text(' | 74 sold', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
