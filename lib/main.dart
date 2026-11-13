
                  ? const Center(child: Text('سبد خرید خالی است'))
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
