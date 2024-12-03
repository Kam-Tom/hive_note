import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/harves/bloc/harvest_bloc.dart';
import 'package:hive_note/shared/features/entry_field.dart';
import 'package:repositories/repositories.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';



class HarvestView extends StatelessWidget {
  static const List<JarSize> jarSizes = [
    JarSize('Undefined', -1, 'l'), // Add undefined option
    JarSize('Small Jar', 0.7, 'l'),
    JarSize('Standard Jar', 1.0, 'l'),
    JarSize('Large Jar', 1.5, 'l'),
    JarSize('XL Jar', 2.0, 'l'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HarvestBloc, HarvestState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdowns section
              Row(
                children: [
                  Expanded(
                    child: MultiSelectDialogField<Apiary>(
                      initialValue: state.selectedApiaries,
                      items: state.apiaries
                          .map((e) => MultiSelectItem<Apiary>(e, e.name))
                          .toList(),
                      title: const Text('Select Apiaries'),
                      buttonText: const Text('Select Apiaries'),
                      buttonIcon: const Icon(Icons.arrow_drop_down),
                      selectedItemsTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                      onConfirm: (values) {
                        context.read<HarvestBloc>().add(SelectApiaries(values));
                      },
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      chipDisplay: MultiSelectChipDisplay.none(),
                      dialogHeight: 200,
                      dialogWidth: 200,
                      searchable: false,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: MultiSelectDialogField<Hive>(
                      initialValue: state.selectedHives,
                      items: state.hives
                          .map((e) => MultiSelectItem<Hive>(e, e.name))
                          .toList(),
                      title: const Text('Select Hives'),
                      buttonText: const Text('Select Hives'),
                      buttonIcon: const Icon(Icons.arrow_drop_down),
                      selectedItemsTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                      onConfirm: (values) {
                        context.read<HarvestBloc>().add(SelectHives(values));
                      },
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      chipDisplay: MultiSelectChipDisplay.none(),
                      dialogHeight: 200,
                      dialogWidth: 200,
                      searchable: false,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
          
              // Jar sizes section
              Text('select_jar_size'.tr(), style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: HarvestView.jarSizes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () => context.read<HarvestBloc>().add(AddJarEntry(HarvestView.jarSizes[index])),
                        child: Card(
                          child: Container(
                            width: 80,
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  HarvestView.jarSizes[index].size == -1 ? 'X' : '${HarvestView.jarSizes[index].size}',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  HarvestView.jarSizes[index].size == -1 ? '' : HarvestView.jarSizes[index].unit,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Entry fields section
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...state.entries.map((metadata) => Column(
                        children: [
                          EntryField(entryMetadata: metadata),
                          const Divider(),
                        ],
                      )).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
