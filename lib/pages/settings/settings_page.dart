import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathernews_app/cubit/settings/settings_cubit.dart';
import 'package:weathernews_app/cubit/settings/settings_state.dart';
import 'package:weathernews_app/cubit/theme/theme_cubit.dart';
import 'package:weathernews_app/cubit/theme/theme_state.dart';
import 'package:weathernews_app/pages/sel_catogery.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          nameController.text = state.name;
          cityController.text = state.city;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  controller: nameController,
                ),
                const SizedBox(height: 16.0),
                ListTile(
                  title: const Text('Favorite Categories'),
                  subtitle: Text(state.favoriteCategories.join(', ')),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectCategoriesPage(
                          initialSelectedCategories: state.favoriteCategories,
                          onCategoriesSelected: (categories) {
                            context.read<SettingsCubit>().updateFavoriteCategories(categories);
                            Navigator.pop(context, true);
                          },
                        ),
                      ),
                    ).then((updated) {
                      if (updated == true) {
                        // Optionally handle any specific actions after update
                      }
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextField(
                  decoration: const InputDecoration(labelText: 'City'),
                  controller: cityController,
                ),
                const SizedBox(height: 16.0),
                SwitchListTile(
                  title: const Text('Dark Theme'),
                  value: context.read<ThemeCubit>().state == ThemeState.dark(),
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleTheme(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    context.read<SettingsCubit>().updateName(nameController.text);
                    context.read<SettingsCubit>().updateCity(cityController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Settings saved')),
                    );
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
