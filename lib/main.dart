
import 'package:flutter/material.dart';

void main() {
  runApp(const KhoshkbarApp());
}

class KhoshkbarApp extends StatelessWidget {
  const KhoshkbarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'خشک بار',
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF174D32),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F6EF),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> products = [
    {'name': 'تخمه آفتابگردان', 'icon': '🌻', 'category': 'تخمه و دانه'},
    {'name': 'تخمه کدو', 'icon': '🎃', 'category': 'تخمه و دانه'},
    {'name': 'تخمه ژاپنی', 'icon': '🌱', 'category': 'تخمه و دانه'},
    {'name': 'بادام درختی', 'icon': '🥜', 'category': 'آجیل و خشکبار'},
    {'name': 'پسته', 'icon': '💚', 'category': 'آجیل و خشکبار'},
    {'name': 'بادام زمینی', 'icon': '🥜', 'category': 'آجیل و خشکبار'},
    {'name': 'نخودچی', 'icon': '🫘', 'category': 'حبوبات'},
    {'name': 'کشمش مویز', 'icon': '🍇', 'category': 'آجیل و خشکبار'},
    {'name': 'گردو', 'icon': '🌰', 'category': 'آجیل و خشکبار'},
    {'name': 'لوبیا قرمز', 'icon': '🫘', 'category': 'حبوبات'},
    {'name': 'لوبیا سفید', 'icon': '🫘', 'category': 'حبوبات'},
    {'name': 'لوبیا چیتی', 'icon': '🫘', 'category': 'حبوبات'},
    {'name': 'لوبیا چشم‌بلبلی', 'icon': '🫘', 'category': 'حبوبات'},
    {'name': 'نخود', 'icon': '🫘', 'category': 'حبوبات'},
    {'name': 'عدس', 'icon': '🌿', 'category': 'حبوبات'},
    {'name': 'لپه', 'icon': '🟡', 'category': 'حبوبات'},
    {'name': 'جو پوست‌کنده', 'icon': '🌾', 'category': 'غلات'},
    {'name': 'جو پرک', 'icon': '🌾', 'category': 'غلات'},
    {'name': 'گندم مرغی', 'icon': '🌾', 'category': 'غلات'},
    {'name': 'گندم حلیم پاک‌شده', 'icon': '🌾', 'category': 'غلات'},
  ];

  final List<String> categories = [
    'همه محصولات',
    'تخمه و دانه',
    'آجیل و خشکبار',
    'حبوبات',
    'غلات',
  ];

  String selectedCategory = 'همه محصولات';

  @override
  Widget build(BuildContext context) {
    final visibleProducts = products.where((product) {
      return selectedCategory == 'همه محصولات' ||
          product['category'] == selectedCategory;
    }).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF174D32),
          foregroundColor: const Color(0xFFFFD778),
          title: const Text(
            'خشک بار',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: selectedIndex == 0
            ? _buildHome(visibleProducts)
            : selectedIndex == 1
                ? _buildProducts(visibleProducts)
                : _buildSimplePage(
                    selectedIndex == 2 ? 'سفارش‌های من' : 'حساب کاربری من',
                    selectedIndex == 2
                        ? 'سفارش‌های شما در این بخش نمایش داده می‌شود.'
                        : 'اطلاعات حساب کاربری شما در این بخش قرار می‌گیرد.',
                  ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() => selectedIndex = index);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'خانه',
            ),
            NavigationDestination(
              icon: Icon(Icons.inventory_2_outlined),
              label: 'محصولات',
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined),
              label: 'سفارش‌ها',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: 'حساب من',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHome(List<Map<String, dynamic>> items) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'file_00000000891881f4bdbf68c947edd9bc.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: const Color(0xFFF8F6EF));
            },
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.white.withOpacity(0.78),
          ),
        ),
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFF174D32).withOpacity(0.94),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'کیفیت عالی، خرید مطمئن',
                    style: TextStyle(
                      color: Color(0xFFFFD778),
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'فروش انواع تخمه، آجیل، حبوبات و غلات',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'سفارش عمده و جزئی',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'دسته‌بندی محصولات',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map((category) {
                return ChoiceChip(
                  label: Text(category),
                  selected: selectedCategory == category,
                  onSelected: (_) {
                    setState(() => selectedCategory = category);
                  },
                  selectedColor: const Color(0xFFD8B65C),
                );
              }).toList(),
            ),
            const SizedBox(height: 22),
            const Text(
              'محصولات فروشگاه',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _productGrid(items),
          ],
        ),
      ],
    );
  }

  Widget _buildProducts(List<Map<String, dynamic>> items) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'فهرست محصولات',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((category) {
            return ChoiceChip(
              label: Text(category),
              selected: selectedCategory == category,
              onSelected: (_) {
                setState(() => selectedCategory = category);
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 18),
        _productGrid(items),
      ],
    );
  }

  Widget _productGrid(List<Map<String, dynamic>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.95,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final product = items[index];
        return Card(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFFE5DCC4)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product['icon'],
                  style: const TextStyle(fontSize: 38),
                ),
                const SizedBox(height: 12),
                Text(
                  product['name'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'قیمت: استعلام از فروشگاه',
                  style: TextStyle(
                    color: Color(0xFF777777),
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSimplePage(String title, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.storefront_outlined,
              size: 60,
              color: Color(0xFF174D32),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
