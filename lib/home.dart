import 'dart:async';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
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
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'For You',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.store_mall_directory_outlined),
            activeIcon: Icon(Icons.store_mall_directory),
            label: 'ToyMall',
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
              badgeContent: const Text('3', style: TextStyle(color: Colors.white)),
              child: const Icon(Icons.message_outlined),
            ),
            activeIcon: badges.Badge(
              badgeContent: const Text('3', style: TextStyle(color: Colors.white)),
              child: const Icon(Icons.message),
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
              badgeContent: const Text('9+', style: TextStyle(color: Colors.white)),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            activeIcon: badges.Badge(
              badgeContent: const Text('9+', style: TextStyle(color: Colors.white)),
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      child: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(context),
          SliverToBoxAdapter(child: _buildPromoBanner()),
          SliverToBoxAdapter(child: _buildBiggestSavings()),
          SliverToBoxAdapter(child: _buildFlashSaleSection()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('For You', style: Theme.of(context).textTheme.headline6),
            ),
          ),
          _buildForYouSection(),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.deepPurple,
      expandedHeight: 50,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                Icon(Icons.search, color: Colors.grey.shade600, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Red Bull Jacket',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: NetworkImage('https://i.ibb.co/CbfS1zW/sale-banner.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBiggestSavings() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Biggest Savings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('More Vouchers >', style: TextStyle(color: Colors.grey)),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Text('₱800.00', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('Toy Voucher', style: TextStyle(color: Colors.black54))
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Text('₱75.00', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('Free Shipping', style: TextStyle(color: Colors.black54))
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, shape: const StadiumBorder()),
              child: const Text('Collect All'),
            )
          ],
        )
      ],
    ),
  );
}


  Widget _buildFlashSaleSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'ToyFlash',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const SizedBox(width: 10),
              const _FlashSaleCountdown(),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('Up to 90% Off >', style: TextStyle(color: Colors.grey)),
              )
            ],
          ),
          const SizedBox(height: 10),
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
      ),
    );
  }

  SliverGrid _buildForYouSection() {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.65,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final toy = dummyToys[index + 4];
            return _buildProductCard(context, toy, isForYou: true);
          },
          childCount: dummyToys.length - 4,
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Toy toy, {bool isForYou = false}) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.network(
                    toy.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  if (isForYou)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.8),
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10))
                    ),
                    child: const Text('25% OFF', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ],
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
                  if (isForYou) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('\$${(toy.price * 1.25).toStringAsFixed(2)}', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 12)),
                        const SizedBox(width: 4),
                        const Text('-25%', style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const Text(' 4.8', style: TextStyle(fontSize: 12)),
                      const Text(' | 74 sold', style: TextStyle(fontSize: 12)),
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


class _FlashSaleCountdown extends StatefulWidget {
  const _FlashSaleCountdown({Key? key}) : super(key: key);

  @override
  _FlashSaleCountdownState createState() => _FlashSaleCountdownState();
}

class _FlashSaleCountdownState extends State<_FlashSaleCountdown> {
  late Timer _timer;
  Duration _duration = const Duration(hours: 23, minutes: 42, seconds: 13);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _duration = _duration - const Duration(seconds: 1);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(_duration.inHours.remainder(24));
    String minutes = twoDigits(_duration.inMinutes.remainder(60));
    String seconds = twoDigits(_duration.inSeconds.remainder(60));

    return Row(
      children: [
        _buildTimeBox(hours),
        const SizedBox(width: 2),
        _buildTimeBox(minutes),
        const SizedBox(width: 2),
        _buildTimeBox(seconds),
      ],
    );
  }

  Widget _buildTimeBox(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        time,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
