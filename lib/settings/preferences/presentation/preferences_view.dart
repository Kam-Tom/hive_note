import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/settings/preferences/bloc/preferences_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PreferencesView extends StatelessWidget {
  const PreferencesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferencesState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Language selection
              _buildDropdown(
                label: 'Language',
                value: state.language,
                items: ['en', 'pl'],
                onChanged: (newValue) {
                  context.read<PreferencesBloc>().add(LanguageChanged(newValue!));
                },
              ),
              const SizedBox(height: 16.0),
              // Notification toggle
              _buildSwitch(
                label: 'Enable Notifications',
                value: state.notificationsEnabled,
                onChanged: (newValue) {
                  context.read<PreferencesBloc>().add(NotificationToggled(newValue));
                },
              ),
              const SizedBox(height: 16.0),
              // Queen preferences
              _buildCategoryLabel('Queen Preferences'),
              _buildToggleableTextField(
                context: context,
                label: 'Queen Default Breed',
                value: state.queenDefaultBreed,
                onSave: (newValue) {
                  context.read<PreferencesBloc>().add(QueenDefaultBreedChanged(newValue));
                },
              ),
              const SizedBox(height: 16.0),
              _buildToggleableTextField(
                context: context,
                label: 'Queen Default Origin',
                value: state.queenDefaultOrigin,
                onSave: (newValue) {
                  context.read<PreferencesBloc>().add(QueenDefaultOriginChanged(newValue));
                },
              ),
              const SizedBox(height: 16.0),
              // Hive preferences
              _buildCategoryLabel('Hive Preferences'),
              _buildToggleableTextField(
                context: context,
                label: 'Hive Default Name',
                value: state.hiveDefaultName,
                onSave: (newValue) {
                  context.read<PreferencesBloc>().add(HiveDefaultNameChanged(newValue));
                },
              ),
              const SizedBox(height: 16.0),
              // Apiary preferences
              _buildCategoryLabel('Apiary Preferences'),
              _buildToggleableTextField(
                context: context,
                label: 'Apiary Default Name',
                value: state.apiaryDefaultName,
                onSave: (newValue) {
                  context.read<PreferencesBloc>().add(ApiaryDefaultNameChanged(newValue));
                },
              ),
              const SizedBox(height: 16.0),
              _buildColorPicker(
                context: context,
                label: 'Apiary Default Color',
                value: state.apiaryDefaultColor,
                onSave: (newValue) {
                  context.read<PreferencesBloc>().add(ApiaryDefaultColorChanged(newValue));
                },
              ),
              // Add more preference inputs as needed
            ],
          ),
        );
      },
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButton<String>(
          value: value,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
        Divider(color: AppColors.divider),
      ],
    );
  }

  Widget _buildSwitch({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: Text(label),
          value: value,
          onChanged: onChanged,
        ),
        Divider(color: AppColors.divider),
      ],
    );
  }

  Widget _buildToggleableTextField({
    required BuildContext context,
    required String label,
    required String value,
    required ValueChanged<String> onSave,
  }) {
    TextEditingController controller = TextEditingController(text: value);
    return BlocBuilder<PreferencesBloc, PreferencesState>(
      builder: (context, state) {
        bool isEditing = state.isEditing[label] ?? false;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: isEditing
                      ? TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: 'Enter $label',
                          ),
                        )
                      : Text(value),
                ),
                IconButton(
                  icon: Icon(isEditing ? Icons.save : Icons.edit),
                  onPressed: () {
                    if (isEditing) {
                      onSave(controller.text);
                    }
                    context.read<PreferencesBloc>().add(ToggleEditing(label));
                  },
                ),
              ],
            ),
            Divider(color: AppColors.divider),
          ],
        );
      },
    );
  }

  Widget _buildColorPicker({
    required BuildContext context,
    required String label,
    required String value,
    required ValueChanged<String> onSave,
  }) {
    String formattedValue = value.startsWith('#') ? value.substring(1) : value;
    Color currentColor;
    try {
      currentColor = Color(int.parse(formattedValue, radix: 16));
    } catch (e) {
      currentColor = AppColors.primary;
    }
    return BlocBuilder<PreferencesBloc, PreferencesState>(
      builder: (context, state) {
        bool isEditing = state.isEditing[label] ?? false;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: isEditing
                      ? GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Pick a color'),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: currentColor,
                                      onColorChanged: (color) {
                                        currentColor = color;
                                      },
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('Save'),
                                      onPressed: () {
                                        onSave('#${currentColor.value.toRadixString(16).padLeft(8, '0')}');
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 50,
                            color: currentColor,
                          ),
                        )
                      : Container(
                          height: 50,
                          color: currentColor,
                        ),
                ),
                IconButton(
                  icon: Icon(isEditing ? Icons.save : Icons.edit),
                  onPressed: () {
                    if (isEditing) {
                      onSave('#${currentColor.value.toRadixString(16).padLeft(8, '0')}');
                    }
                    context.read<PreferencesBloc>().add(ToggleEditing(label));
                  },
                ),
              ],
            ),
            Divider(color: AppColors.divider),
          ],
        );
      },
    );
  }

  Widget _buildCategoryLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
