
Widget homeBody(List<Map<String, String>> items) {
  return Stack(
    children: [
      // تصویر پس‌زمینه مزرعه آفتابگردان
      Positioned.fill(
        child: Image.asset(
          'assets/images/sunflower_field.png',
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFF8F6EF),
            );
          },
        ),
      ),

      // لایه روشن برای خوانایی نوشته‌ها
      Positioned.fill(
        child: Container(
          color: Colors.white.withOpacity(0.35),
        ),
      ),

      // محتوای صفحه اصلی
      ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: green.withOpacity(0.94),
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
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: green,
            ),
          ),
          const SizedBox(height: 12),
          categoryChips(),
          const SizedBox(height: 22),
          const Text(
            'محصولات فروشگاه',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: green,
            ),
          ),
          const SizedBox(height: 12),
          productGrid(items),
        ],
      ),
    ],
  );
}
