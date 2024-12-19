import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_note/raport_details/cubit/raport_details_cubit.dart';
import 'package:repositories/repositories.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';

class RaportDetailsView extends StatelessWidget {
  const RaportDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RaportDetailsCubit, RaportDetailsState>(
      builder: (context, state) {
        return switch (state) {
          RaportDetailsLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          RaportDetailsSuccess() => _buildSuccessContent(context, state),
          RaportDetailsError() => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${state.message}'),
                ],
              ),
            ),
          _ => const SizedBox(),
        };
      },
    );
  }

  Widget _buildSuccessContent(BuildContext context, RaportDetailsSuccess state) {
    final formattedDate = DateFormat('MMMM d, y').format(state.raport.createdAt);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLastUpdateInfo(state.raport.createdAt),
          const SizedBox(height: 16),
          _buildRaportCard(state, formattedDate),
          const SizedBox(height: 24),
          _buildEntriesList(state),
        ],
      ),
    );
  }

  Widget _buildLastUpdateInfo(DateTime date) {
    return Text(
      'current_raport_info'.tr(),
      style: const TextStyle(
        fontSize: 12,
        fontStyle: FontStyle.italic,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildRaportCard(RaportDetailsSuccess state, String formattedDate) {
    final raportIcon = _getRaportTypeIcon(state.raport.raportType);
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  raportIcon,
                  height: 32,
                  width: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  state.raport.raportType.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.apiary != null) ...[
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppVectors.apiary,
                        height: 20,
                        width: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'apiary_label'.tr(args: [state.apiary!.name]),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                if (state.hive != null) ...[
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppVectors.beehive,
                        height: 20,
                        width: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'hive_label'.tr(args: [state.hive!.name]),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                Row(
                  children: [
                    SvgPicture.asset(
                      AppVectors.calendar,
                      height: 20,
                      width: 20,
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'created_label'.tr(args: [formattedDate]),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getRaportTypeIcon(RaportType type) {
    return switch (type) {
      RaportType.simple => AppVectors.inspection,
      RaportType.advanced => AppVectors.inspection,
      RaportType.custom => AppVectors.other,
      RaportType.harvest => AppVectors.harvest,
      RaportType.treatment => AppVectors.treatment,
      RaportType.note => AppVectors.note,
      RaportType.finances => AppVectors.finances,
      RaportType.feeding => AppVectors.feeding,
    };
  }

  Widget _buildEntriesList(RaportDetailsSuccess state) {
    // Filter metadatas that have corresponding non-empty entries
    final nonEmptyEntries = state.metadatas.where((metadata) {
      final entry = state.entries.firstWhere(
        (e) => e.entryMetadataId == metadata.id,
        orElse: () => Entry(
          raportId: state.raport.id,
          entryMetadataId: metadata.id,
          value: '',
        ),
      );
      return entry.value.isNotEmpty;
    }).toList();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'entries_label'.tr(args: [nonEmptyEntries.length.toString()]),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (nonEmptyEntries.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'no_entries_available'.tr(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: nonEmptyEntries.length,
                itemBuilder: (context, index) {
                  final metadata = nonEmptyEntries[index];
                  final entry = state.entries.firstWhere(
                    (e) => e.entryMetadataId == metadata.id,
                  );

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    child: ListTile(
                      title: Text(
                        metadata.label.tr(),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(entry.value),
                      trailing: Text(
                        metadata.valueType.name,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
