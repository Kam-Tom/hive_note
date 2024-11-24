import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/core/configs/setup/app_router.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/manage_queens/bloc/manage_queens_bloc.dart';
import 'package:hive_note/manage_queens/presentation/widgets/queen_tile.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:hive_note/shared/presentation/dialogs/delete_confirmation_dialog.dart';
import 'package:hive_note/shared/presentation/widgets/add_tile.dart';
import 'package:hive_note/shared/presentation/widgets/apiary_dropdown/presentation/apiary_dropdown.dart';
import 'package:hive_note/shared/presentation/widgets/failure.dart';
import 'package:repositories/repositories.dart';

class ManageQueensView extends StatelessWidget {
  const ManageQueensView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ManageQueensBloc>().state;
    final status = state.status;

    return Column(
      children: [
        const SizedBox(height: 8),
        ApiaryDropdown(
          onSelected: (Apiary? apiary) {
            context.read<ManageQueensBloc>().add(SelectApiary(apiary: apiary));
          },
        ),
        if (status == Status.loading || status == Status.initial) 
          const LinearProgressIndicator()
        else if (status == Status.success || status == Status.updating)
          _bulidQueenList(context, state.queens, state.selectedApiary)
        else
          const Failure()
      ],
    );
  }

  _bulidQueenList(BuildContext context, List<QueenWithHive> queens, Apiary? selectedApiary) {
    return Expanded(
      child: ReorderableListView(
        onReorder: (_, __) {
          //Just for consistency with ManageHives and ManageApiaries
        },
        children: [
          for (final queen in queens) _bulidQueenTile(context, queen),
          if(selectedApiary == null) _bulidAddQueenTile(context),
        ],
      ),
    );
  }

  Widget _bulidQueenTile(BuildContext context, QueenWithHive queen) {
    return QueenTile(
      key: ValueKey(queen),
      queen: queen.queen,
      hive: queen.hive,
      color: AppColors.primary,
      onPressed: (h) {
        Navigator.pushNamed(
          context,
          AppRouter.editQueenPath,
          arguments: h.id,
        );
      },
      confirmDismiss: (q) async {
        return await showDeleteConfirmationDialog(context);
      },
      onDismissed: (q) {
        context.read<ManageQueensBloc>().add(DeleteQueen(queen: queen));
      },
    );
  }

  Widget _bulidAddQueenTile(BuildContext context) {
    return AddTile(
      key: const ValueKey('add_hive_tile'),
      onPressed: () {
        context.read<ManageQueensBloc>().add(InsertQueen(
              queen: Queen(breed: 'default_breed'.tr(), 
              origin: 'default_origin'.tr(), 
              isAlive: true, 
              birthDate: DateTime.now())));
      },
    );
  }
}
