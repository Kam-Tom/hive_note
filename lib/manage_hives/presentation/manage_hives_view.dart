import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/core/configs/setup/app_router.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/manage_hives/bloc/manage_hives_bloc.dart';
import 'package:hive_note/manage_hives/presentation/widgets/hive_tile.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:hive_note/shared/presentation/dialogs/delete_confirmation_dialog.dart';
import 'package:hive_note/shared/presentation/widgets/widgets.dart';
import 'package:repositories/repositories.dart';

class ManageHivesView extends StatelessWidget {
  const ManageHivesView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ManageHivesBloc>().state;
    final status = state.status;

    return Column(
      children: [
        ApiaryDropdown(
          onSelected: (Apiary? apiary) {
            context.read<ManageHivesBloc>().add(SelectApiary(apiary: apiary));
          },
        ),
        if (status == Status.loading) const LinearProgressIndicator(),
        if (status == Status.success || status == Status.updating)
          _bulidHiveList(context, state.hives)
        else
          const Failure()
      ],
    );
  }

  _bulidHiveList(BuildContext context, List<HiveWithQueen> hives) {
    return Expanded(
      child: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          context.read<ManageHivesBloc>().add(RearrangeHives(
                hive1: hives[oldIndex],
                hive2: hives[newIndex > oldIndex ? newIndex - 1 : newIndex],
              ));
        },
        children: [
          for (final hive in hives) _builHiveTile(context, hive),
          _bulidAddHiveTile(context, hives),
        ],
      ),
    );
  }

  Widget _builHiveTile(BuildContext context, HiveWithQueen hive) {
    return HiveTile(
      key: ValueKey(hive),
      hive: hive.hive,
      queen: hive.queen,
      color: AppColors.primary,
      onPressed: (h) {
        Navigator.pushNamed(
          context,
          AppRouter.editHivePath,
          arguments: h.id,
        );
      },
      confirmDismiss: (h) async {
        return await showDeleteConfirmationDialog(context);
      },
      onDismissed: (h) {
        context.read<ManageHivesBloc>().add(DeleteHive(hive: hive));
      },
    );
  }

  Widget _bulidAddHiveTile(BuildContext context, List<HiveWithQueen> hives) {
    return AddTile(
      key: const ValueKey('add_hive_tile'),
      onPressed: () {
        int order = (hives.lastOrNull?.hive.order ?? -1) + 1;
        String? apiaryId = hives.lastOrNull?.hive.apiaryId;
        context.read<ManageHivesBloc>().add(InsertHive(
              hive: Hive(
                  type: "default_hive_type".tr(),
                  name: "new_hive".tr(namedArgs: {"number": order.toString()}),
                  order: order,
                  apiaryId: apiaryId,
                  createdAt: DateTime.now()),
            ));
      },
    );
  }
}
