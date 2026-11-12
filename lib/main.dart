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
      title: 'خوشکبار و تخمه اعلا',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF39764B),
        useMaterial3: true,
        fontFamily: 'Arial',
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

  final pages = const [
    Center(child: Text('به خوشکبار و تخمه اعلا خوش آمدید')),
    Center(child: Text('فهرست محصولات')),
    Center(child: Text('سفارش‌های من')),
    Center(child: Text('حساب کاربری من')),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('خوشکبار و تخمه اعلا'),
          backgroundColor: const Color(0xFF39764B),
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F1E8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Text(
                    'کیفیت اعلا، خرید آسان، حساب شفاف',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('سفارش آسان و مشاهده حساب اختصاصی شما'),
                ],
              ),
            ),
            Expanded(child: pages[selectedIndex]),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() => selectedIndex = index);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'خانه',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag_outlined),
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
}
