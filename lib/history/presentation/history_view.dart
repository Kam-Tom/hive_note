import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/core/configs/setup/app_router.dart';
import 'package:hive_note/history/bloc/history_bloc.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(      builder: (context, state) {
        if (state.status == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == Status.failure) {
          return Center(child: Text('history_load_failed'.tr()));
        } else {
          return ListView.builder(
            itemCount: state.historyLogs.length,
            itemBuilder: (context, index) {
              final log = state.historyLogs[index];
              return _historyTile(log, context);
            },
          );
        }
      },
    );
  }

  Widget _historyTile(HistoryLog log, BuildContext context) {
    Color borderColor;
    IconData actionIcon;

    switch (log.logType) {
      case LogType.apiary:
        borderColor = Colors.green;
        break;
      case LogType.hive:
        borderColor = Colors.blue;
        break;
      case LogType.queen:
        borderColor = Colors.purple;
        break;
      case LogType.todo:
        borderColor = Colors.orange;
        break;
      case LogType.entry_metadata:
        borderColor = Colors.red;
        break;
      case LogType.entry:
        borderColor = Colors.yellow;
        break;
      case LogType.finances:
        borderColor = Colors.brown;
        break;
      default:
        borderColor = Colors.grey;
    }

    switch (log.actionType) {
      case ActionType.create:
        actionIcon = Icons.add;
        break;
      case ActionType.update:
        actionIcon = Icons.update;
        break;
      case ActionType.delete:
        actionIcon = Icons.delete;
        break;
      default:
        actionIcon = Icons.help;
    }

    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        leading: Icon(actionIcon),
        title: Text(log.logType.toString().split('.').last.capitalize()),
        subtitle: Text(DateFormat('yyyy/MM/dd').format(log.createdAt)),
        onTap: log.actionType == ActionType.delete ? () {
          Fluttertoast.showToast(
            msg: 'history_deleted_item'.tr(),
            backgroundColor: Colors.red,
          );
        } : () {
          String route;
          switch (log.logType) {
            case LogType.apiary:
              route = AppRouter.apiaryDetailsPath;
              break;
            case LogType.hive:
              route = AppRouter.hiveDetailsPath;
              break;
            case LogType.queen:
              route = AppRouter.queenDetailsPath;
              break;
            case LogType.todo:
              route = AppRouter.todoDetailsPath;
              break;
            default:
              route = AppRouter.raportDetailsPath;
          }
          Navigator.pushNamed(
            context,
            route,
            arguments: log.referenceId,
          );
        },
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }
}
