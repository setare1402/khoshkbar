
import 'package:flutter/material.dart';

void main() => runApp(const KhoshkbarApp());

const green = Color(0xFF174D32);
const gold = Color(0xFFFFD778);

class CartItem {
  final String name;
  final int kg;
  const CartItem(this.name, this.kg);
}

class Flavor {
  final String name;
  final String image;
  final String emoji;
  const Flavor(this.name, this.image, this.emoji);
}

const flavors = [
  Flavor('لیمو', '', '🍋'),
  Flavor('گلپر لیمو', '', '🌻'),
  Flavor('سس رنچ', '', '🥣'),
  Flavor('پنیری', '', '🧀'),
  Flavor('گلپر', '', '🌿'),
  Flavor('شکری', '', '🍬'),
  Flavor('نمکی ساده', '', '🌻'),
  Flavor('خام', '', '🌱'),
];

const pumpkinFlavors = [
  Flavor('ساده شور', 'assets/images/pumpkin_simple_salted.png', '🎃'),
  Flavor('دوآتیشه شور', 'assets/images/pumpkin_double_roasted.png', '🎃'),
  Flavor('خام', 'assets/images/pumpkin_raw.png', '🌱'),
];

class KhoshkbarApp extends StatelessWidget {
  const KhoshkbarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'خشک بار',
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: green),
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
  String selectedCategory = 'همه محصولات';

  final List<CartItem> cart = [];

  final categories = [
    'همه محصولات',
    'تخمه و دانه',
    'آجیل و خشکبار',
    'حبوبات',
    'غلات',
  ];

  final List<Map<String, String>> products = [
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

  Future<void> openFlavorPage({
    required String productName,
    required String pageTitle,
    required List<Flavor> options,
  }) async {
    final result = await Navigator.push<List<CartItem>>(
      context,
      MaterialPageRoute(
        builder: (_) => FlavorPage(
          productName: productName,
          pageTitle: pageTitle,
          options: options,
        ),
      ),
    );

    if (!mounted || result == null || result.isEmpty) return;

    setState(() {
      for (final item in result) {
        final i = cart.indexWhere((e) => e.name == item.name);

        if (i < 0) {
          cart.add(item);
        } else {
          cart[i] = CartItem(item.name, cart[i].kg + item.kg);
        }
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('محصولات به سبد خرید اضافه شدند'),
      ),
    );
  }

  Future<void> openCart() async {
    final result = await Navigator.push<List<CartItem>>(
      context,
      MaterialPageRoute(
        builder: (_) => CartPage(items: List.of(cart)),
      ),
    );

    if (result == null || !mounted) return;

    setState(() {
      cart
        ..clear()
        ..addAll(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    final visible = products.where((p) =>
      selectedCategory == 'همه محصولات' ||
      p['category'] == selectedCategory
    ).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: green,
          foregroundColor: gold,
          centerTitle: true,
          title: const Text('خشک بار'),
          actions: [
            IconButton(
              onPressed: openCart,
              icon: Badge(
                isLabelVisible: cart.isNotEmpty,
                label: Text('${cart.length}'),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ],
        ),
        body: selectedIndex == 0
            ? homeBody(visible)
            : selectedIndex == 1
                ? productBody(visible)
                : Center(
                    child: Text(
                      selectedIndex == 2
                          ? 'سفارش‌های من'
                          : 'حساب کاربری من',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (i) {
            setState(() => selectedIndex = i);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
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

  Widget homeBody(List<Map<String, String>> items) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/sunflower_field.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Container(color: const Color(0xFFF8F6EF));
            },
          ),
        ),
        Positioned.fill(
          child: Container(color: Colors.white.withOpacity(.35)),
        ),
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: green.withOpacity(.94),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'کیفیت عالی، خرید مطمئن',
                    style: TextStyle(
                      color: gold,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'فروش انواع تخمه، آجیل، حبوبات و غلات',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'سفارش عمده و جزئی',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'دسته‌بندی محصولات',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            categoryChips(),
            const SizedBox(height: 22),
            const Text(
              'محصولات فروشگاه',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            productGrid(items),
          ],
        ),
      ],
    );
  }

  Widget productBody(List<Map<String, String>> items) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'فهرست محصولات',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        categoryChips(),
        const SizedBox(height: 18),
        productGrid(items),
      ],
    );
  }

  Widget categoryChips() {
    return Wrap(
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
    );
  }

  Widget productGrid(List<Map<String, String>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .95,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final product = items[index];
        final name = product['name']!;

        final isSunflower = name == 'تخمه آفتابگردان';
        final isPumpkin = name == 'تخمه کدو';

        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFFE5DCC4)),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: isSunflower
                ? () => openFlavorPage(
                      productName: name,
                      pageTitle: 'انتخاب طعم تخمه آفتابگردان',
                      options: flavors,
                    )
                : isPumpkin
                    ? () => openFlavorPage(
                          productName: name,
                          pageTitle: 'انتخاب مدل تخمه کدو',
                          options: pumpkinFlavors,
                        )
                    : null,
            child: isSunflower
                ? Column(
                    children: [
                      SizedBox(
                        height: 88,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/123Gallery.jpg',
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          errorBuilder: (_, __, ___) {
                            return const Center(
                              child: Text(
                                '🌻',
                                style: TextStyle(fontSize: 48),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'قیمت: استعلام از فروشگاه',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                              ),
                              const Text(
                                'مشاهده ۸ طعم ←',
                                style: TextStyle(
                                  color: green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isPumpkin)
                          SizedBox(
                            height: 105,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/images/pumpkin.png',
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) {
                                return const Center(
                                  child: Text(
                                    '🎃',
                                    style: TextStyle(fontSize: 48),
                                  ),
                                );
                              },
                            ),
                          )
                        else
                          Text(
                            product['icon']!,
                            style: const TextStyle(fontSize: 42),
                          ),
                        const SizedBox(height: 10),
                        Text(
                          name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'قیمت: استعلام از فروشگاه',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                        if (isPumpkin)
                          const Text(
                            'مشاهده ۳ مدل ←',
                            style: TextStyle(
                              color: green,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class FlavorPage extends StatefulWidget {
  final String productName;
  final String pageTitle;
  final List<Flavor> options;

  const FlavorPage({
    super.key,
    required this.productName,
    required this.pageTitle,
    required this.options,
  });

  @override
  State<FlavorPage> createState() => _FlavorPageState();
}

class _FlavorPageState extends State<FlavorPage> {
  final Map<String, int> selected = {};

  Future<void> chooseFlavor(Flavor flavor) async {
    int weight = selected[flavor.name] ?? 5;
    bool custom = false;
    final controller = TextEditingController();

    final result = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, update) => Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            24,
            20,
            MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'وزن ${flavor.name}',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: green,
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                children: [5, 10, 20].map((kg) {
                  return ChoiceChip(
                    label: Text('$kg کیلو'),
                    selected: !custom && weight == kg,
                    onSelected: (_) {
                      update(() {
                        custom = false;
                        weight = kg;
                        controller.clear();
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  labelText: 'وزن دلخواه (بیشتر از ۲۰ کیلو)',
                  suffixText: 'کیلوگرم',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (_) {
                  update(() => custom = true);
                },
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: green,
                    padding: const EdgeInsets.all(14),
                  ),
                  onPressed: () {
                    if (custom) {
                      final value = int.tryParse(controller.text);
                      if (value == null || value <= 20) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'وزن دلخواه باید بیشتر از ۲۰ کیلو باشد',
                            ),
                          ),
                        );
                        return;
                      }
                      Navigator.pop(sheetContext, value);
                    } else {
                      Navigator.pop(sheetContext, weight);
                    }
                  },
                  child: const Text(
                    'تأیید وزن',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    controller.dispose();

    if (!mounted || result == null) return;

    setState(() {
      selected[flavor.name] = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems = selected.entries.map((e) {
      return CartItem('${widget.productName} - ${e.key}', e.value);
    }).toList();

    final totalKg = selected.values.fold<int>(0, (a, b) => a + b);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: green,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Text(widget.pageTitle),
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: widget.options.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .78,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final flavor = widget.options[index];
                  final isSelected = selected.containsKey(flavor.name);

                  return InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => chooseFlavor(flavor),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: isSelected ? 5 : 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                          color: isSelected
                              ? green
                              : const Color(0xFFE5DCC4),
                          width: isSelected ? 3 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                if (flavor.image.isNotEmpty)
                                  Image.asset(
                                    flavor.image,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) {
                                      return Container(
                                        color: const Color(0xFFFFF1D9),
                                        child: Center(
                                          child: Text(
                                            flavor.emoji,
                                            style: const TextStyle(
                                              fontSize: 48,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                else
                                  Container(
                                    color: const Color(0xFFFFF1D9),
                                    child: Center(
                                      child: Text(
                                        flavor.emoji,
                                        style: const TextStyle(
                                          fontSize: 48,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (isSelected)
                                  const Positioned(
                                    top: 8,
                                    left: 8,
                                    child: CircleAvatar(
                                      backgroundColor: green,
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            color: isSelected
                                ? green
                                : const Color(0xFFFFE5BD),
                            padding: const EdgeInsets.all(9),
                            child: Column(
                              children: [
                                Text(
                                  flavor.name,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                if (isSelected)
                                  Text(
                                    '${selected[flavor.name]} کیلو',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFE5DCC4)),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'انتخاب شده: ${selected.length} مدل | مجموع وزن: $totalKg کیلو',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: green,
                        padding: const EdgeInsets.all(15),
                      ),
                      onPressed: selected.isEmpty
                          ? null
                          : () {
                              Navigator.pop(context, selectedItems);
                            },
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'افزودن انتخاب‌ها به سبد خرید',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const Text(
                    'حداقل سفارش هر مدل ۵ کیلوگرم است',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final List<CartItem> items;

  const CartPage({super.key, required this.items});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<CartItem> items;

  @override
  void initState() {
    super.initState();
    items = List.of(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    final total = items.fold<int>(0, (sum, item) => sum + item.kg);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('سبد خرید'),
          backgroundColor: green,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Expanded(
              child: items.isEmpty
                  ? const Center(
                      child: Text('سبد خرید خالی است'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Card(
                          child: ListTile(
                            title: Text(item.name),
                            subtitle: Text('${item.kg} کیلوگرم'),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  items.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'مجموع وزن: $total کیلوگرم',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: green,
                        padding: const EdgeInsets.all(15),
                      ),
                      onPressed: () {
                        Navigator.pop(context, items);
                      },
                      child: const Text(
                        'ثبت تغییرات سبد خرید',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
