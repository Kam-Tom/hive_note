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

    if (status == ManageApiariesStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (status == ManageApiariesStatus.failure) {
      return const Failure();
    } else {
      return _buildApiariesList(context, apiaries);
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
            _buildApiaryTile(context, apiaries[index]),
          _buildAddApiaryTile(context),
        ],
      ),
    );
  }

  Widget _buildAddApiaryTile(BuildContext context) {
    return AddTile(
      key: const ValueKey("add_apiary_tile"),
      onPressed: () {
        context.read<ManageApiariesBloc>().add(InsertApiary(
              createdAt: DateTime.now(),
              isActive: false,
            ));
      },
    );
  }

  Widget _buildApiaryTile(BuildContext context, ApiaryWithHiveCount apiary) {
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
      confirmDismiss: (direction) async {
        if (apiary.hiveCount > 0) {
          _showApiaryHasHivesToast();
          return false;
        }
        return await showDeleteConfirmationDialog(context);
      },
      onDismissed: (direction) {
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
