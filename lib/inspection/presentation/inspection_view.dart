import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/inspection/bloc/inspection_bloc.dart';
import 'package:hive_note/shared/features/entry_field.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:hive_note/shared/presentation/widgets/failure.dart';
import 'package:repositories/repositories.dart';

class InspectionView extends StatelessWidget {
  const InspectionView({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<InspectionBloc>().state;
    if (state.status == Status.loading || state.status == Status.initial) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.status == Status.failure) {
      return const Failure();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InspectionHeader(state: state),
          const Divider(),
          HiveInspectionList(state: state),
          const Divider(),
          Expanded(
            child: EntryFieldsList(entryMetadatas: state.entryMetadatas, currentInspection: state.selectedHiveInspection),
          ),
        ],
      );
    }
  }
}

class InspectionHeader extends StatelessWidget {
  final InspectionState state;

  const InspectionHeader({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            state.apiary!.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          if (state.selectedHiveInspection != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.selectedHiveInspection!.hive.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppVectors.bee,
                      width: 24,
                      height: 24,
                      colorFilter: state.selectedHiveInspection!.queen == null
                          ? const ColorFilter.mode(
                              Color.fromARGB(60, 0, 0, 0), BlendMode.srcIn)
                          : const ColorFilter.mode(
                              Color.fromARGB(190, 0, 0, 0), BlendMode.srcIn),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      state.selectedHiveInspection!.queen?.breed ??
                          'no_queen'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: state.selectedHiveInspection!.queen == null
                                ? AppColors.text.withAlpha(60)
                                : AppColors.text,
                          ),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class HiveInspectionList extends StatelessWidget {
  final InspectionState state;

  const HiveInspectionList({required this.state});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, // Fixed height for the squares
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: state.hiveInspections.length,
        itemBuilder: (context, index) {
          final hiveInspection = state.hiveInspections[index];
          return GestureDetector(
            onTap: () {
              context
                  .read<InspectionBloc>()
                  .add(SelectHive(hiveInspection: hiveInspection));
            },
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _getColorForHive(hiveInspection),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$index',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }

  Color _getColorForHive(HiveInspection hiveInspection) {
    if (hiveInspection == state.selectedHiveInspection) {
      return Colors.blue;
    } else if (hiveInspection.inspected) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }
}

class EntryFieldsList extends StatelessWidget {
  final List<EntryMetadata> entryMetadatas;
  final List<EntryField> entryFields;
  final HiveInspection? currentInspection;

  EntryFieldsList({super.key, required this.entryMetadatas, this.currentInspection})
      : entryFields = entryMetadatas.map((entryMetadata) => EntryField(entryMetadata: entryMetadata)).toList();

  @override
  Widget build(BuildContext context) {
    var defaultValues = Map.fromEntries(entryMetadatas.map((e) => MapEntry(e.id, e.valueType.defaultValue)));
    if(currentInspection?.raport != null) {
      defaultValues = Map.fromEntries(currentInspection!.entries.map((e) => MapEntry(e.entryMetadataId, e.value)));
    }
    
    context.read<EntryFieldCubit>().setDefaultValues(defaultValues);
    
    return ListView(
      shrinkWrap: true,
      children: [
        ...entryMetadatas.map((entryMetadata) => Column(
              children: [
                entryFields[entryMetadatas.indexOf(entryMetadata)],
                const Divider(height: 1),
              ],
            )),
      ],
    );
  }
}


extension EntryTypeDefaultValue on EntryType {
  String get defaultValue {
    switch (this) {
      case EntryType.slider0to5:
        return '1';
      case EntryType.slider0to3:
        return '1';
      case EntryType.slider0to7:
        return '1';
      case EntryType.slider0to11:
        return '1';
      case EntryType.text:
        return '';
      case EntryType.number:
        return '0';
      case EntryType.checkbox:
        return 'false';
      case EntryType.decimal:
        return '0.0';
      case EntryType.intNeg:
        return '0';
      case EntryType.decNeg:
        return '0.0';
      case EntryType.toggle:
        return 'false';
    }
  }
}
