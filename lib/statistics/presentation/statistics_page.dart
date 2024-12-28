import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:hive_note/statistics/bloc/statistics_bloc.dart';
import 'package:hive_note/statistics/presentation/statistics_view.dart';
import 'package:repositories/repositories.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dialogs/feeding_statistics_dialog.dart';
import 'dialogs/finances_statistics_dialog.dart';
import 'dialogs/harvest_statistics_dialog.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (context) => StatisticsBloc(
            apiaryRepository: context.read<ApiaryRepository>(),
            hiveRepository: context.read<HiveRepository>(),
            todoRepository: context.read<TodoRepository>(),
            raportRepository: context.read<RaportRepository>(),
            entryMetadataRepository: context.read<EntryMetadataRepository>(),
          )..add(const LoadData()),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: StatisticsView(),
        bottomNavigationBar: CustomAppFooter(),
        floatingActionButton: BlocBuilder<StatisticsBloc, StatisticsState>(
          builder: (context, state) {
            return SpeedDial(
              icon: Icons.menu,
              activeIcon: Icons.close,
              children: [
                SpeedDialChild(
                  child: const Icon(Icons.date_range),
                  label: 'Date Range',
                  onTap: () async {
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                      initialDateRange: DateTimeRange(
                        start: state.startDate ?? DateTime.now().subtract(const Duration(days: 30)),
                        end: state.endDate ?? DateTime.now(),
                      ),
                    );
                    if (picked != null) {
                      Fluttertoast.showToast(
                        msg: 'date_range_updated'.tr(),
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                      );
                      context.read<StatisticsBloc>().add(ChangeDateRange(
                        startDate: picked.start,
                        endDate: picked.end,
                      ));
                      context.read<StatisticsBloc>().add(const LoadData());
                    }
                  },
                ),
                SpeedDialChild(
                  child: const Icon(Icons.local_dining),
                  label: 'Feeding',
                  onTap: () {
                    context.read<StatisticsBloc>().add(const LoadFeedingData());
                    showDialog(
                      context: context,
                      builder: (dialogContext) => BlocProvider.value(
                        value: context.read<StatisticsBloc>(),
                        child: const FeedingStatisticsDialog(),
                      ),
                    );
                  },
                ),
                SpeedDialChild(
                  child: const Icon(Icons.attach_money),
                  label: 'Finances',
                  onTap: () {
                    context.read<StatisticsBloc>().add(const LoadFinancesData());
                    showDialog(
                      context: context,
                      builder: (dialogContext) => BlocProvider.value(
                        value: context.read<StatisticsBloc>(),
                        child: const FinancesStatisticsDialog(),
                      ),
                    );
                  },
                ),
                // SpeedDialChild(
                //   child: const Icon(Icons.medical_services),
                //   label: 'Treatment',
                //   onTap: () {
                //     // context.read<StatisticsBloc>().add(const LoadTreatmentData());
                //     showDialog(
                //       context: context,
                //       builder: (dialogContext) => BlocProvider.value(
                //         value: context.read<StatisticsBloc>(),
                //         child: const TreatmentStatisticsDialog(),
                //       ),
                //     );
                //   },
                // ),
                // SpeedDialChild(
                //   child: const Icon(Icons.search),
                //   label: 'Inspections',
                //   onTap: () {
                //     // context.read<StatisticsBloc>().add(const ChangeStatisticsType(type: 'inspections'));
                //   },
                // ),
                // SpeedDialChild(
                //   child: const Icon(Icons.note),
                //   label: 'Notes',
                //   onTap: () {
                //     // context.read<StatisticsBloc>().add(const ChangeStatisticsType(type: 'notes'));
                //   },
                // ),
                // SpeedDialChild(
                //   child: const Icon(Icons.task),
                //   label: 'Todos',
                //   onTap: () {
                //     // context.read<StatisticsBloc>().add(const ChangeStatisticsType(type: 'todos'));
                //   },
                // ),
                // SpeedDialChild(
                //   child: const Icon(Icons.home_work),
                //   label: 'Apiaries',
                //   onTap: () {
                //     // context.read<StatisticsBloc>().add(const ChangeStatisticsType(type: 'apiaries'));
                //   },
                // ),
                SpeedDialChild(
                  child: const Icon(Icons.shopping_basket),
                  label: 'Harvest',
                  onTap: () {
                    context.read<StatisticsBloc>().add(const LoadHarvestData());
                    showDialog(
                      context: context,
                      builder: (dialogContext) => BlocProvider.value(
                        value: context.read<StatisticsBloc>(),
                        child: const HarvestStatisticsDialog(),
                      ),
                    );
                  },
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}

class StatisticsOptionsDialog extends StatelessWidget {
  const StatisticsOptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Statistics Options'),
      content: SingleChildScrollView(
        child: BlocBuilder<StatisticsBloc, StatisticsState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.date_range),
                  title: const Text('Select Date Range'),
                  onTap: () async {
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                      initialDateRange: DateTimeRange(
                        start: state.startDate ?? DateTime.now().subtract(const Duration(days: 30)),
                        end: state.endDate ?? DateTime.now(),
                      ),
                    );
                    if (picked != null) {
                      Fluttertoast.showToast(
                        msg: 'date_range_updated'.tr(),
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                      );
                      context.read<StatisticsBloc>().add(ChangeDateRange(
                        startDate: picked.start,
                        endDate: picked.end,
                      ));
                      context.read<StatisticsBloc>().add(const LoadData());
                    }
                  },
                ),
                // Add more options here as needed
              ],
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
