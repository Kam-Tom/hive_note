import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:repositories/repositories.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../statistics/bloc/statistics_bloc.dart';
import 'base_statistics_dialog.dart';

class FeedingStatisticsDialog extends StatelessWidget {
  const FeedingStatisticsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsBloc, StatisticsState>(
      builder: (context, s) {
        if (s is FeedingStatisticsState) {
          final state = s;
          return BaseStatisticsDialog(
            onShowGraph: () {
              context.read<StatisticsBloc>().add(ShowFeedingGraph(
                filters: {'feed_type':state.selectedFeedingTypes}
              ));
              Navigator.of(context).pop();
            },
            title: 'feeding'.tr(),
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
                      title: Text('select_apiaries'.tr()),
                      buttonText: state.selectedApiaries.isEmpty 
                          ? Text('select_apiaries'.tr())
                          : Text('selected_apiaries'.tr() + ' ${state.selectedApiaries.length}'),
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
                      title: Text('select_hives'.tr()),
                      buttonText: state.selectedHives.isEmpty 
                          ? Text('select_hives'.tr())
                          : Text('selected_hives'.tr() + ' ${state.selectedHives.length}'),
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
                      initialValue: state.selectedFeedingTypes,
                      items: state.feedingTypes
                          .map((type) => MultiSelectItem<String>(type, type))
                          .toList(),
                      title: Text('select_type'.tr()),
                      buttonText: state.selectedFeedingTypes.isEmpty 
                          ? Text('select_type'.tr())
                          : Text('select_type'.tr() + ' ${state.selectedFeedingTypes.length}'),
                      onConfirm: (values) {
                        context.read<StatisticsBloc>().add(SelectFeedingTypes(feedingTypes: values));
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
