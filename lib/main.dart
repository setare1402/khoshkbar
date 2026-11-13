
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSunflower)
                SizedBox(
                  height: 125,
                  width: double.infinity,
                  child: Image.asset(
                    'file_00000000f0e081f4a087f81d600246d7 (1).png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (_, __, ___) {
                      return const Center(
                        child: Text('🌻', style: TextStyle(fontSize: 48)),
                      );
                    },
                  ),
                )
              else if (isPumpkin)
                SizedBox(
                  height: 125,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/pumpkin.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (_, __, ___) {
                      return const Center(
                        child: Text('🎃', style: TextStyle(fontSize: 48)),
                      );
                    },
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    product['icon']!,
                    style: const TextStyle(fontSize: 42),
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
                      const SizedBox(height: 6),
                      const Text(
                        'قیمت: استعلام از فروشگاه',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),
                      if (isSunflower)
                        const Text(
                          'مشاهده ۸ طعم ←',
                          style: TextStyle(
                            color: green,
                            fontWeight: FontWeight.bold,
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
            ],
          ),
        ),
      );
    },
  );
}
