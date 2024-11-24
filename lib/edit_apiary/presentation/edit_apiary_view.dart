import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive_note/core/configs/setup/app_router.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:reorderable_grid/reorderable_grid.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/edit_apiary/bloc/edit_apiary_bloc.dart';
import 'package:repositories/repositories.dart';

class EditApiaryView extends StatelessWidget {
  const EditApiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<EditApiaryBloc>().state;
    switch(state.status) {
      case Status.loading || Status.initial:
        return const Center(child: CircularProgressIndicator());
      case Status.failure:
        return Center(child: Text('failed_to_load_apiary'.tr()));
      case Status.success:
        return _buildSuccessView(context, state.apiary!, state.hives);
      default:
        return const SizedBox();
    }

  }

  Widget _buildSuccessView(BuildContext context, Apiary apiary, List<Hive> hives) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context, apiary, hives),
          const SizedBox(height: 16),
          _buildHivesGrid(context, hives),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Apiary apiary, List<Hive> hives) {
    final nameController = TextEditingController(text: apiary.name);
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'apiary_name'.tr(),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => context.read<EditApiaryBloc>().add(
                    UpdateApiaryName(name: value),
                  )
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('active'.tr()),
                Switch(
                  value: apiary.isActive,
                  onChanged: (value) => context.read<EditApiaryBloc>().add(
                        UpdateApiaryIsActive(isActive: value),
                      ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _showColorPicker(context, apiary.color),
                  icon: Icon(Icons.circle, color: apiary.color),
                  label: Text('change_color'.tr()),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final bloc = context.read<EditApiaryBloc>();
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: apiary.createdAt,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (pickedDate != null) {
                  bloc.add(UpdateApiaryCreatedAt(createdAt: pickedDate));
                }
              },
              child: Row(
                children: [
                  Text('${'created'.tr()}: ${DateFormat('yyyy-MM-dd').format(apiary.createdAt)}'),
                  const SizedBox(width: 8),
                  const Icon(Icons.edit, color: AppColors.text, size: 16),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => context.read<EditApiaryBloc>().add(
                    const AddHive(
                      defaultPrefix: 'Hive',
                      defaultType: 'Langstroth',
                    ),
                  ),
              icon: const Icon(Icons.add),
              label: Text('add_hive'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  void _showColorPicker(BuildContext context, Color currentColor) {
    Color pickedColor = currentColor;
    
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('pick_color'.tr()),
        content: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, setState) => ColorPicker(
              pickerColor: pickedColor,
              onColorChanged: (color) {
                setState(() => pickedColor = color);
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              context.read<EditApiaryBloc>().add(
                    UpdateApiaryColor(color: pickedColor),
                  );
              Navigator.of(dialogContext).pop();
            },
            child: Text('done'.tr()),
          ),
        ],
      ),
    );
  }

  Widget _buildHivesGrid(BuildContext context, List<Hive> hives) {
    return Expanded(
      child: ReorderableGridView.extent(
        maxCrossAxisExtent: 120,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
        onReorder: (oldIndex, newIndex) {
          context.read<EditApiaryBloc>().add(
                RearrangeHives(
                  oldIndex: oldIndex,
                  newIndex: newIndex,
                ),
              );
        },
        children: hives.map((hive) {
          return _buildHiveCard(context, hive);
        }).toList(),
        
      ),
    );
  }

  Widget _buildHiveCard(BuildContext context, Hive hive) {
    return InkWell(
      key: ValueKey(hive.id),
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.editHivePath,
          arguments: hive.id,
        );
      },
      child: Card(
        key: ValueKey(hive.id),
        color: AppColors.secondaryLight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hive.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '${'order'.tr()}: ${hive.order}',
            ),
          ],
        ),
      ),
    );
  }
}