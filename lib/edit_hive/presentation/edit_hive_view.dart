import 'package:hive_note/edit_hive/bloc/edit_hive_bloc.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/shared/extenstions/models/queen_get_color.dart';
import 'package:hive_note/shared/presentation/widgets/apiary_dropdown/presentation/apiary_dropdown.dart';
import 'package:repositories/repositories.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_note/core/configs/setup/app_router.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';

class EditHiveView extends StatelessWidget {
  const EditHiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditHiveBloc, EditHiveState>(      listenWhen: (previous, current) => 
        previous.insertedQueenId != current.insertedQueenId && 
        current.insertedQueenId != null,
      listener: (context, state) {
        Navigator.pushNamed(
          context,
          AppRouter.editQueenPath,
          arguments: state.insertedQueenId,
        );
      },
      child: Builder(
        builder: (context) {
          var state = context.select((EditHiveBloc bloc) => bloc.state);

          switch (state.status) {
            case Status.loading || Status.initial:
              return const Center(child: CircularProgressIndicator());
            case Status.failure:
              return Center(child: Text('failed_to_load_hive'.tr()));
            case Status.success:
              if (state.hive != null) {
                return _buildSuccessView(
                    context, state.hive!, state.queen, state.availableQueens);
              } else {
                return const SizedBox();
              }
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildSuccessView(BuildContext context, Hive hive, Queen? queen,
      List<Queen> availableQueens) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildToggleableTextField(
                    context: context,
                    label: 'hive_name'.tr(),
                    value: hive.name,
                    onSave: (newValue) {
                      context.read<EditHiveBloc>().add(UpdateHiveDetails(name: newValue));
                    },
                  ),
                  const SizedBox(height: 16.0),
                  _buildToggleableTextField(
                    context: context,
                    label: 'hive_type'.tr(),
                    value: hive.type,
                    onSave: (newValue) {
                      context.read<EditHiveBloc>().add(UpdateHiveDetails(type: newValue));
                    },
                  ),
                  const SizedBox(height: 16),
                  ApiaryDropdown(
                    defaultApiaryId: hive.apiaryId,
                    onSelected: (Apiary? apiary) {
                      context.read<EditHiveBloc>().add(SelectApiary(apiary: apiary));
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String?>(
                    value: queen?.id,
                    alignment: Alignment.bottomCenter,
                    isExpanded: true,
                    selectedItemBuilder: (BuildContext context) {
                      return [
                        DropdownMenuItem<String?>(
                          value: null,
                          child: Text(
                            'no_queen_selected'.tr(),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13),
                          ),
                        ),
                        if (queen != null)
                          _buildSelectedQueenItem(context, queen, isCurrent: true),
                        ...availableQueens
                            .where((q) => q.id != queen?.id)
                            .map((q) => _buildSelectedQueenItem(context, q)),
                      ];
                    },
                    items: [
                      DropdownMenuItem<String?>(
                        value: null,
                        child: Text(
                          'no_queen_selected'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13),
                        ),
                      ),
                      if (queen != null)
                        _buildQueenDropdownItem(context, queen, isCurrent: true),
                      ...availableQueens
                          .where((q) => q.id != queen?.id)
                          .map((q) => _buildQueenDropdownItem(context, q)),
                    ],
                    onChanged: (value) => context.read<EditHiveBloc>().add(
                          UpdateHiveQueen(queenId: value),
                        ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<EditHiveBloc>().add(const CreateNewQueen());
                    },
                    icon: const Icon(Icons.add),
                    label: Text('create_new_queen'.tr()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleableTextField({
    required BuildContext context,
    required String label,
    required String value,
    required ValueChanged<String> onSave,
  }) {
    TextEditingController controller = TextEditingController(text: value);
    return BlocBuilder<EditHiveBloc, EditHiveState>(      builder: (context, state) {
        bool isEditing = state.isEditing[label] ?? false;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: isEditing
                      ? TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: '${'enter'.tr()} $label',
                          ),
                        )
                      : Text(value),
                ),
                IconButton(
                  icon: Icon(isEditing ? Icons.save : Icons.edit),
                  onPressed: () {
                    if (isEditing) {
                      onSave(controller.text);
                    }
                    context.read<EditHiveBloc>().add(ToggleEditing(label));
                  },
                ),
              ],
            ),
            Divider(color: AppColors.divider),
          ],
        );
      },
    );
  }

  DropdownMenuItem<String> _buildQueenDropdownItem(
      BuildContext context, Queen queen,
      {bool isCurrent = false}) {
    return DropdownMenuItem(
      value: queen.id,
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: queen.color,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isCurrent ? '${queen.breed} ${'current_queen'.tr()}' : queen.breed,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13),
                ),
                Text(
                  '${queen.origin} • ${DateFormat('yyyy-MM-dd').format(queen.birthDate)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedQueenItem(
      BuildContext context, Queen queen,
      {bool isCurrent = false}) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: queen.color,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            isCurrent ? '${queen.breed} ${'current_queen'.tr()}' : queen.breed,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
