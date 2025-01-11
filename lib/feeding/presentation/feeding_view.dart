import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_note/feeding/bloc/feeding_bloc.dart';
import 'package:hive_note/shared/features/entry_field.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:hive_note/shared/presentation/widgets/failure.dart';
import 'package:repositories/repositories.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/shared/presentation/widgets/multi_select_field.dart';

class FeedingView extends StatelessWidget {
  const FeedingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedingBloc, FeedingState>(
      builder: (context, state) {
        final defaultValues = context.read<EntryFieldCubit>().getValues();
        context.read<EntryFieldCubit>().setDefaultValues(defaultValues);
        
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
                      child: MultiSelectField<Apiary>(
                        initialValue: state.selectedApiaries,
                        items: state.apiaries
                            .map((e) => MultiSelectItem<Apiary>(e, e.name))
                            .toList(),
                        title: 'select_apiaries'.tr(),
                        buttonText: state.selectedApiaries.isEmpty
                            ? 'select_apiaries'.tr()
                            : '${'selected_apiaries'.tr()} ${state.selectedApiaries.length}',
                        onConfirm: (values) {
                          context.read<FeedingBloc>().add(SelectApiaries(values));
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: MultiSelectField<Hive>(
                        initialValue: state.selectedHives,
                        items: state.hives
                            .map((e) => MultiSelectItem<Hive>(e, e.name))
                            .toList(),
                        title: 'select_hives'.tr(),
                        buttonText: state.selectedHives.isEmpty
                            ? 'select_hives'.tr()
                            : '${'selected_hives'.tr()} ${state.selectedHives.length}',
                        onConfirm: (values) {
                          context.read<FeedingBloc>().add(SelectHives(values));
                        },
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
