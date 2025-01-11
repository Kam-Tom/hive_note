import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/harves/bloc/harvest_bloc.dart';
import 'package:hive_note/harves/bloc/models/jar_size.dart';
import 'package:hive_note/shared/features/entry_field.dart';
import 'package:repositories/repositories.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/shared/presentation/widgets/multi_select_field.dart';

class HarvestView extends StatelessWidget {

  const HarvestView({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HarvestBloc, HarvestState>(
      builder: (context, state) {
        final defaultValues = context.read<EntryFieldCubit>().getValues();
        context.read<EntryFieldCubit>().setDefaultValues(defaultValues);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: MultiSelectField<Apiary>(
                      initialValue: state.selectedApiaries,
                      items: state.apiaries
                          .map((e) => MultiSelectItem<Apiary>(e, e.name))
                          .toList(),
                      title: 'select_apiaries'.tr(),
                      buttonText: state.selectedApiaries.isEmpty
                          ? 'select_apiaries'.tr()
                          : '${'selected_apiaries'.tr()} ${state.selectedApiaries.length}',
                      onConfirm: (values) {
                        context.read<HarvestBloc>().add(SelectApiaries(values));
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: MultiSelectField<Hive>(
                      initialValue: state.selectedHives,
                      items: state.hives
                          .map((e) => MultiSelectItem<Hive>(e, e.name))
                          .toList(),
                      title: 'select_hives'.tr(),
                      buttonText: state.selectedHives.isEmpty
                          ? 'select_hives'.tr()
                          : '${'selected_hives'.tr()} ${state.selectedHives.length}',
                      onConfirm: (values) {
                        context.read<HarvestBloc>().add(SelectHives(values));
                      },
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
                  itemCount: JarSize.jarSizes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () => context.read<HarvestBloc>().add(AddJarEntry(JarSize.jarSizes[index])),
                        child: Card(
                          child: Container(
                            width: 80,
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  JarSize.jarSizes[index].size == -1 ? 'X' : '${JarSize.jarSizes[index].size}',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  JarSize.jarSizes[index].size == -1 ? '' : JarSize.jarSizes[index].unit,
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

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...state.entries.map((metadata) => Column(
                        children: [
                          EntryField(entryMetadata: metadata,
                            hints: state.hints[metadata.id],
                          ),
                          const Divider(),
                        ],
                      )),
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
