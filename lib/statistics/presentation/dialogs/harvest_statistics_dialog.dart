import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:repositories/repositories.dart';
import '../../../statistics/bloc/statistics_bloc.dart';
import 'base_statistics_dialog.dart';

class HarvestStatisticsDialog extends StatelessWidget {
  const HarvestStatisticsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsBloc, StatisticsState>(
      builder: (context, s) {
        if (s is HarvestStatisticsState) {
          final state = s;
          return BaseStatisticsDialog(
            onShowGraph: () {
              context.read<StatisticsBloc>().add(ShowHarvestGraph(
                filters: {
                  'honey_type': state.selectedHarvestTypes,
                  'jar_type': state.selectedJarTypes,
                  
                },
                jarTypes: state.selectedJarTypes,
              ));
              Navigator.of(context).pop();
            },
            title: 'Harvest Statistics',
            content: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6, // 60% of screen height
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MultiSelectDialogField<Apiary>(
                      initialValue: state.selectedApiaries,
                      items: state.apiaries
                          .map((e) => MultiSelectItem<Apiary>(e, e.name))
                          .toList(),
                      title: const Text('Select Apiaries'),
                      buttonText: state.selectedApiaries.isEmpty 
                          ? const Text('Select Apiaries')
                          : Text('Selected Apiaries (${state.selectedApiaries.length})'),
                      onConfirm: (values) {
                        context.read<StatisticsBloc>().add(SelectApiaries(apiaries: values));
                      },
                      chipDisplay: MultiSelectChipDisplay.none(),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      dialogHeight: 200,
                      dialogWidth: 200,
                      searchable: false,
                      selectedColor: AppColors.secondary,
                      checkColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    MultiSelectDialogField<Hive>(
                      initialValue: state.selectedHives,
                      items: state.hives
                          .map((e) => MultiSelectItem<Hive>(e, e.name))
                          .toList(),
                      title: const Text('Select Hives'),
                      buttonText: state.selectedHives.isEmpty 
                          ? const Text('Select Hives')
                          : Text('Selected Hives (${state.selectedHives.length})'),
                      onConfirm: (values) {
                        context.read<StatisticsBloc>().add(SelectHives(hives: values));
                      },
                      chipDisplay: MultiSelectChipDisplay.none(),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      dialogHeight: 200,
                      dialogWidth: 200,
                      searchable: false,
                      selectedColor: AppColors.secondary,
                      checkColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    MultiSelectDialogField<String>(
                      initialValue: state.selectedHarvestTypes,
                      items: state.harvestTypes
                          .map((type) => MultiSelectItem<String>(type, type))
                          .toList(),
                      title: const Text('Select Harvest Types'),
                      buttonText: state.selectedHarvestTypes.isEmpty 
                          ? const Text('Select Harvest Types')
                          : Text('Selected Harvest Types (${state.selectedHarvestTypes.length})'),
                      onConfirm: (values) {
                        context.read<StatisticsBloc>().add(SelectHarvestTypes(harvestTypes: values));
                      },
                      chipDisplay: MultiSelectChipDisplay.none(),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      dialogHeight: 200,
                      dialogWidth: 200,
                      searchable: false,
                      selectedColor: AppColors.secondary,
                      checkColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    MultiSelectDialogField<String>(
                      initialValue: state.selectedJarTypes,
                      items: state.jarTypes
                          .map((type) => MultiSelectItem<String>(type, type))
                          .toList(),
                      title: const Text('Select Jar Types'),
                      buttonText: state.selectedJarTypes.isEmpty 
                          ? const Text('Select Jar Types')
                          : Text('Selected Jar Types (${state.selectedJarTypes.length})'),
                      onConfirm: (values) {
                        context.read<StatisticsBloc>().add(SelectJarTypes(jarTypes: values));
                      },
                      chipDisplay: MultiSelectChipDisplay.none(),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      dialogHeight: 200,
                      dialogWidth: 200,
                      searchable: false,
                      selectedColor: AppColors.secondary,
                      checkColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
