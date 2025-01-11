import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../statistics/bloc/statistics_bloc.dart';
import 'base_statistics_dialog.dart';

class FinancesStatisticsDialog extends StatelessWidget {
  const FinancesStatisticsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsBloc, StatisticsState>(
      builder: (context, s) {
        if (s is FinancesStatisticsState) {
          final state = s;
          return BaseStatisticsDialog(
            onShowGraph: () {
              context.read<StatisticsBloc>().add(ShowFinancesGraph(
                filters: {
                  'transaction_item': state.selectedTransactionItems,
                },
              ));
              Navigator.of(context).pop();
            },
            title: 'finances'.tr(),
            content: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MultiSelectDialogField<String>(
                      initialValue: state.selectedTransactionItems,
                      items: state.transactionItems
                          .map((type) => MultiSelectItem<String>(type, type))
                          .toList(),
                      title: Text('select_transaction_items'.tr()),
                      buttonText: state.selectedTransactionItems.isEmpty 
                          ? Text('select_transaction_items'.tr())
                          : Text('selected_transaction_items'.tr() + ' ${state.selectedTransactionItems.length}'),
                      onConfirm: (values) {
                        context.read<StatisticsBloc>().add(SelectTransactionItems(transactionItems: values));
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
