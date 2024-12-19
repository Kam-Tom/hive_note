import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/history/bloc/history_bloc.dart';
import 'package:hive_note/history/presentation/history_view.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (context) => HistoryBloc(
            historyLogRepository: context.read<HistoryLogRepository>(),
            hiveRepository: context.read<HiveRepository>(),
            apiaryRepository: context.read<ApiaryRepository>(),
            queenRepository: context.read<QueenRepository>(),
            
          )..add(const LoadData()),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: const HistoryView(),
        bottomNavigationBar: CustomAppFooter(),
        floatingActionButton: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            return SpeedDial(
              icon: Icons.menu,
              activeIcon: Icons.close,
              children: [
                SpeedDialChild(
                  child: const Icon(Icons.date_range),
                  label: 'Change Date Range',
                  onTap: () async {
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                      initialDateRange: DateTimeRange(
                        start: state.startDate,
                        end: state.endDate,
                      ),
                    );
                    if (picked != null) {
                      context.read<HistoryBloc>().add(ChangeDate(
                        startDate: picked.start,
                        endDate: picked.end,
                       ));
                      Fluttertoast.showToast(
                        msg: 'history_date_changed'.tr(),
                        backgroundColor: Colors.green,
                      );
                    }
                  },
                ),
                SpeedDialChild(
                  child: const Icon(Icons.filter_list),
                  label: 'Filter Types',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => BlocProvider.value(
                        value: context.read<HistoryBloc>(),
                        child: const TableTypesDialog(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TableTypesDialog extends StatelessWidget {
  const TableTypesDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Types'),
      content: SingleChildScrollView(
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: LogType.values
                  .where((type) => type != LogType.entry && type != LogType.entry_metadata)
                  .map((type) {
                return CheckboxListTile(
                  title: Text(type.toString().split('.').last),
                  value: state.logTypes.contains(type),
                  onChanged: (bool? value) {
                    if (value != null) {
                      context.read<HistoryBloc>().add(
                        ChangeType(
                          logType: type,
                          selected: value,
                        ),
                      );
                    }
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
