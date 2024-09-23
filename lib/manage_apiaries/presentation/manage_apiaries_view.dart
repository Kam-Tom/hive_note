import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_note/core/configs/setup/app_router.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/manage_apiaries/bloc/manage_apiaries_bloc.dart';
import 'package:hive_note/manage_apiaries/presentation/widgets/apiary_tile.dart';
import 'package:hive_note/shared/presentation/dialogs/delete_confirmation_dialog.dart';
import 'package:hive_note/shared/presentation/widgets/widgets.dart';
import 'package:repositories/repositories.dart';

class ManageApiariesView extends StatelessWidget {
  const ManageApiariesView({super.key});

  @override
  Widget build(BuildContext context) {
    final manageApiariesState = context.watch<ManageApiariesBloc>().state;
    final status = manageApiariesState.status;
    final apiaries = manageApiariesState.apiaries;

    switch (status) {
      case ManageApiariesStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case ManageApiariesStatus.failure:
        return const Failure();
      case ManageApiariesStatus.success || ManageApiariesStatus.pending:
        return _buildApiariesList(context, apiaries);
      default:
        return const Failure();
    }
  }

  Widget _buildApiariesList(
      BuildContext context, List<ApiaryWithHiveCount> apiaries) {
    return Center(
      child: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          context.read<ManageApiariesBloc>().add(RearrangeApiaries(
                apiary1: apiaries[oldIndex],
                apiary2:
                    apiaries[newIndex > oldIndex ? newIndex - 1 : newIndex],
              ));
        },
        children: [
          for (int index = 0; index < apiaries.length; index++)
            _builApiaryTile(context, apiaries[index]),
          _buildAddApiaryTile(context, apiaries),
        ],
      ),
    );
  }

  Widget _buildAddApiaryTile(
      BuildContext context, List<ApiaryWithHiveCount> apiaries) {
    return AddTile(
      key: const ValueKey("add_apiary_tile"),
      onPressed: () {
        int order = (apiaries.lastOrNull?.apiary.order ?? -1) + 1;
        context.read<ManageApiariesBloc>().add(InsertApiary(
              apiary: Apiary(
                  name:
                      "new_apiary".tr(namedArgs: {"number": order.toString()}),
                  order: order,
                  createdAt: DateTime.now()),
            ));
      },
    );
  }

  Widget _builApiaryTile(BuildContext context, ApiaryWithHiveCount apiary) {
    return ApiaryTile(
      key: ValueKey(apiary),
      apiary: apiary.apiary,
      hiveCount: apiary.hiveCount,
      onPressed: (apiary) {
        Navigator.pushNamed(
          context,
          AppRouter.editApiaryPath,
          arguments: apiary.id,
        );
      },
      confirmDismiss: (a) async {
        if (apiary.hiveCount > 0) {
          _showApiaryHasHivesToast();
          return false;
        }
        return await showDeleteConfirmationDialog(context);
      },
      onDismissed: (a) {
        context.read<ManageApiariesBloc>().add(DeleteApiary(apiary: apiary));
      },
    );
  }



  void _showApiaryHasHivesToast() {
    Fluttertoast.showToast(
      msg: "apiary_has_hives".tr(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.failure,
      textColor: AppColors.background,
    );
  }
}
