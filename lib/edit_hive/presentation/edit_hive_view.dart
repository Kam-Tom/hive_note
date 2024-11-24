import 'package:hive_note/edit_hive/bloc/edit_hive_bloc.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/shared/extenstions/models/queen_get_color.dart';
import 'package:hive_note/shared/presentation/widgets/apiary_dropdown/presentation/apiary_dropdown.dart';
import 'package:repositories/repositories.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_note/core/configs/setup/app_router.dart';
import 'package:intl/intl.dart'; // Ensure this import for DateFormat

class EditHiveView extends StatelessWidget {
  const EditHiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditHiveBloc, EditHiveState>(
      listenWhen: (previous, current) => 
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
                  TextField(
                    controller: TextEditingController(
                      text: hive.name,
                    ),
                    decoration: InputDecoration(
                      labelText: 'hive_name'.tr(),
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) => context.read<EditHiveBloc>().add(
                          UpdateHiveDetails(name: value),
                        ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: TextEditingController(
                      text: hive.type,
                    ),
                    decoration: InputDecoration(
                      labelText: 'hive_type'.tr(),
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) => context.read<EditHiveBloc>().add(
                          UpdateHiveDetails(type: value),
                        ),
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
                        DropdownMenuItem(
                          value: null,
                          child: Text('no_queen_selected'.tr()),
                        ),
                        if (queen != null &&
                            !availableQueens.any((q) => q.id == queen.id))
                          _buildSelectedQueenItem(context, queen, isCurrent: true),
                        ...availableQueens.map((q) =>
                            _buildSelectedQueenItem(context, q)).toList(),
                      ];
                    },
                    items: [
                      DropdownMenuItem(
                        value: null,
                        child: Text('no_queen_selected'.tr()),
                      ),
                      if (queen != null &&
                          !availableQueens.any((q) => q.id == queen.id))
                        _buildQueenDropdownItem(context, queen, isCurrent: true),
                      ...availableQueens.map((q) =>
                          _buildQueenDropdownItem(context, q)).toList(),
                    ],
                    onChanged: (value) => context.read<EditHiveBloc>().add(
                          UpdateHiveQueen(queenId: value),
                        ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<EditHiveBloc>().add(
                            CreateNewQueen(
                              defaultBreed: 'default_breed'.tr(),
                              defaultOrigin: 'Unknown',
                            ),
                          );
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
              children: [
                Text(
                  isCurrent ? '${queen.breed} (Current)' : queen.breed,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${queen.origin} • ${DateFormat('yyyy-MM-dd').format(queen.birthDate)}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
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
            isCurrent ? '${queen.breed} (Current)' : queen.breed,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
