import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:hive_note/shared/presentation/widgets/apiary_dropdown/bloc/apiary_dropdown_bloc.dart';
import 'package:repositories/repositories.dart';

class ApiaryDropdownView extends StatelessWidget {
  const ApiaryDropdownView({required this.onSelected, super.key});

  final void Function(Apiary? apiary) onSelected;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ApiaryDropdownBloc>().state;
    final status = state.status;
    final apiaries = state.apiaries;
    final selectedApiary = state.selectedApiary;

    switch (status) {
      case Status.loading:
        return const Center(
            child: CircularProgressIndicator(
          color: AppColors.secondary,
        ));
      case Status.failure:
        return _bulidFailure(context);
      case Status.success:
        return _buildDropdown(context, apiaries, selectedApiary);
      default:
        return _bulidFailure(context);
    }
  }

  Widget _bulidFailure(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: AppColors.failure),
      ),
      padding: const EdgeInsets.all(2),
      width: double.infinity,
      child:
          const Icon(Icons.error_outline, color: AppColors.failure, size: 50),
    );
  }

  Widget _buildDropdown(
      BuildContext context, List<Apiary> apiaries, Apiary? selectedApiary) {
    return Center(
      child: DropdownMenu<Apiary?>(
        dropdownMenuEntries: [
          DropdownMenuEntry(
              value: null,
              label: "unassigned".tr(),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.text,
                backgroundColor: AppColors.background,
              )),
          ...apiaries.map((apiary) => DropdownMenuEntry(
                label: apiary.name,
                value: apiary,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.text,
                  backgroundColor: AppColors.background,
                ),
              ))
        ],
        initialSelection: selectedApiary,
        onSelected: (Apiary? apiary) {
          context
              .read<ApiaryDropdownBloc>()
              .add(SelectApiary(apiary: apiary));

          onSelected(apiary);
        },
        width: double.infinity,
        menuHeight: 300,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondary),
          ),
        ),
        menuStyle: const MenuStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.backgroundDark)),
      ),
    );
  }
}