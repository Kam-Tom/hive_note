import 'package:hive_note/edit_queen/bloc/edit_queen_bloc.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:hive_note/shared/extenstions/models/queen_get_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';
import 'package:easy_localization/easy_localization.dart';

class EditQueenView extends StatelessWidget {
  const EditQueenView({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<EditQueenBloc>().state;

    if (state.status == Status.loading || state.status == Status.initial) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.status == Status.failure) {
      return Center(child: Text('failed_to_load_queen'.tr()));
    } else if (state.status == Status.success && state.queen != null) {
      return _buildSuccessView(context, state.queen!);
    } else {
      return const SizedBox();
    }
  }

  Widget _buildSuccessView(BuildContext context, Queen queen) {
    final breedController = TextEditingController(text: queen.breed);
    final originController = TextEditingController(text: queen.origin);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 24,
                    color: queen.color,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: breedController,
                          decoration: InputDecoration(
                            labelText: 'breed'.tr(),
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (value) => context.read<EditQueenBloc>().add(
                                UpdateQueenDebounced(breed: value),
                              ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: originController,
                          decoration: InputDecoration(
                            labelText: 'origin'.tr(),
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (value) => context.read<EditQueenBloc>().add(
                                UpdateQueenDebounced(origin: value),
                              ),
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          title: Text('is_alive'.tr()),
                          value: queen.isAlive,
                          onChanged: (value) => context.read<EditQueenBloc>().add(
                                UpdateQueenImmediate(isAlive: value),
                              ),
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          title: Text('birth_date'.tr()),
                          subtitle: Text(queen.birthDate.toString().split(' ')[0]),
                          trailing: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () async {
                              final bloc = context.read<EditQueenBloc>();
                              final date = await showDatePicker(
                                context: context,
                                initialDate: queen.birthDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                              );
                              if (date != null) {
                                bloc.add(UpdateQueenImmediate(birthDate: date));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}