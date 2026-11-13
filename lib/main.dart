
class FlavorSelectionPage extends StatefulWidget {
  final String title;
  final String productName;
  final List<Flavor> options;

  const FlavorSelectionPage({
    super.key,
    required this.title,
    required this.productName,
    required this.options,
  });

  @override
  State<FlavorSelectionPage> createState() =>
      _FlavorSelectionPageState();
}

class _FlavorSelectionPageState
    extends State<FlavorSelectionPage> {
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
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, update) {
            return Padding(
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
                        onSelected: (_) => update(() {
                          custom = false;
                          weight = kg;
                        }),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'وزن دلخواه (بیشتر از ۲۰ کیلو)',
                      suffixText: 'کیلوگرم',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (_) => update(() => custom = true),
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
            );
          },
        );
      },
    );

    controller.dispose();

    if (result != null) {
      setState(() => selected[flavor.name] = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems = selected.entries
        .map(
          (e) => CartItem(
            '${widget.productName} - ${e.key}',
            e.value,
          ),
        )
        .toList();

    final totalKg = selected.values.fold<int>(0, (a, b) => a + b);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: green,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Text(widget.title),
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
                  final isSelected =
                      selected.containsKey(flavor.name);

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
                                Image.asset(
                                  flavor.image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) {
                                    return Container(
                                      color: const Color(0xFFFFF1D9),
                                      child: Center(
                                        child: Text(
                                          '${flavor.emoji}\n${widget.productName}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
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
                                  textAlign: TextAlign.center,
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
                          : () => Navigator.pop(context, selectedItems),
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
