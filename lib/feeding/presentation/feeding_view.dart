import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_note/feeding/bloc/feeding_bloc.dart';
import 'package:hive_note/shared/features/entry_field.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:hive_note/shared/presentation/widgets/failure.dart';
import 'package:repositories/repositories.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class FeedingView extends StatelessWidget {
  const FeedingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedingBloc, FeedingState>(
      builder: (context, state) {
        if (state.status == Status.loading || state.status == Status.initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == Status.failure) {
          return const Failure();
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: MultiSelectDialogField<Apiary>(
                          initialValue: state.selectedApiaries,
                          items: state.apiaries
                              .map((e) => MultiSelectItem<Apiary>(e, e.name))
                              .toList(),
                          title: Text('select_apiaries'.tr()),
                          buttonText: Text(
                            state.selectedApiaries.isEmpty && state.selectedHives.isEmpty
                                ? 'select_apiaries'.tr()
                                : '${'selected_apiaries'.tr()} ${state.selectedApiaries.length}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          buttonIcon: const Icon(Icons.arrow_drop_down),
                          selectedItemsTextStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          onConfirm: (values) {
                            context.read<FeedingBloc>().add(SelectApiaries(values));
                          },
                          chipDisplay: MultiSelectChipDisplay.none(),
                          dialogHeight: 200,
                          dialogWidth: 200,
                          searchable: false,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
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
                            overflow: TextOverflow.ellipsis,
                          ),
                          buttonIcon: const Icon(Icons.arrow_drop_down),
                          selectedItemsTextStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          onConfirm: (values) {
                            context.read<FeedingBloc>().add(SelectHives(values));
                          },
                          chipDisplay: MultiSelectChipDisplay.none(),
                          dialogHeight: 200,
                          dialogWidth: 200,
                          searchable: false,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Column(
                    children: [
                      ...state.entries.map((metadata) => Column(
                        children: [
                          EntryField(
                            entryMetadata: metadata,
                            hints: state.hints[metadata.id],
                          ),
                          const Divider(),
                        ],
                      )),
                    ],
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
