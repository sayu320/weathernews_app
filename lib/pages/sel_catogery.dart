import 'package:flutter/material.dart';

class SelectCategoriesPage extends StatefulWidget {
  final List<String> initialSelectedCategories;
  final void Function(List<String>) onCategoriesSelected;

  const SelectCategoriesPage({
    required this.initialSelectedCategories,
    required this.onCategoriesSelected,
    super.key,
  });

  @override
  _SelectCategoriesPageState createState() => _SelectCategoriesPageState();
}

class _SelectCategoriesPageState extends State<SelectCategoriesPage> {
  late Set<String> selectedCategories;

  @override
  void initState() {
    super.initState();
    selectedCategories = widget.initialSelectedCategories.toSet();
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      'business', 'entertainment', 'general', 'health', 'science', 'sports', 'technology'
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Select Favourite Categories')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: categories.map((category) {
                  return CheckboxListTile(
                    title: Text(category),
                    value: selectedCategories.contains(category),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          if (selectedCategories.length < 4) {
                            selectedCategories.add(category);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('You can select up to 4 categories'),
                              ),
                            );
                          }
                        } else {
                          selectedCategories.remove(category);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedCategories.length < 2) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Select at least 2 categories'),
                      ),
                    );
                  } else {
                    widget.onCategoriesSelected(selectedCategories.toList());
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.all(10.0),
                ),
                child: const Text(
                  'Save Categories',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}