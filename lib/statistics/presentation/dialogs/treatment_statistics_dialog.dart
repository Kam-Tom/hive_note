import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../../../statistics/bloc/statistics_bloc.dart';
import 'base_statistics_dialog.dart';

class TreatmentStatisticsDialog extends StatelessWidget {
  const TreatmentStatisticsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsBloc, StatisticsState>(
      builder: (context, state) {
        return BaseStatisticsDialog(
          onShowGraph: () => {},
          title: 'Treatment Statistics',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MultiSelectDialogField<String>(
                items: [
                  MultiSelectItem('varroa', 'Varroa Treatment'),
                  MultiSelectItem('nosema', 'Nosema Treatment'),
                  MultiSelectItem('other', 'Other Treatments'),
                ],
                title: const Text('Treatment Types'),
                buttonText: const Text('Select Treatment Types'),
                onConfirm: (values) {
                  // Add event handler
                },
              ),
              // Add apiary/hive selectors similar to feeding dialog
            ],
          ),
        );
      },
    );
  }
}
