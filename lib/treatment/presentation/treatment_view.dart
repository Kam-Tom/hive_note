import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:hive_note/shared/features/entry_field.dart';
import 'package:hive_note/shared/presentation/widgets/failure.dart';
import 'package:hive_note/treatment/bloc/treatment_bloc.dart';
import 'package:repositories/repositories.dart';

class TreatmentView extends StatelessWidget {
  const TreatmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TreatmentBloc, TreatmentState>(
      builder: (context, state) {
        if (state.status == Status.loading || state.status == Status.initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == Status.failure) {
          return const Failure();
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MultiSelectDialogField<Apiary>(
                        initialValue: state.selectedApiaries,
                        items: state.apiaries
                            .map((e) => MultiSelectItem<Apiary>(e, e.name))
                            .toList(),
                        title: Text('select_apiaries'.tr()),
                        buttonText: Text(
                          state.selectedApiaries.isEmpty
                              ? 'select_apiaries'.tr()
                              : '${'selected_apiaries'.tr()} ${state.selectedApiaries.length}',
                        ),
                        buttonIcon: const Icon(Icons.arrow_drop_down),
                        selectedItemsTextStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        onConfirm: (values) {
                          context
                              .read<TreatmentBloc>()
                              .add(SelectApiaries(values));
                        },
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        chipDisplay: MultiSelectChipDisplay.none(),
                        dialogHeight: 200,
                        dialogWidth: 200,
                        searchable: false,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: MultiSelectDialogField<Hive>(
                        initialValue: state.selectedHives,
                        items: state.hives
                            .map((e) => MultiSelectItem<Hive>(e, e.name))
                            .toList(),
                        title: Text('select_hives'.tr()),
                        buttonText: Text(
                          state.selectedHives.isEmpty
                              ? 'select_hives'.tr()
                              : '${'selected_hives'.tr()} ${state.selectedHives.length}',
                        ),
                        buttonIcon: const Icon(Icons.arrow_drop_down),
                        selectedItemsTextStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        onConfirm: (values) {
                          context
                              .read<TreatmentBloc>()
                              .add(SelectHives(values));
                        },
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        chipDisplay: MultiSelectChipDisplay.none(),
                        dialogHeight: 200,
                        dialogWidth: 200,
                        searchable: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...state.entries.map((metadata) => Column(
                              children: [
                                EntryField(entryMetadata: metadata),
                                const Divider(),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
