import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/hive_details/cubit/hive_details_cubit.dart';
import 'package:repositories/repositories.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';

class HiveDetailsView extends StatelessWidget {
  const HiveDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HiveDetailsCubit, HiveDetailsState>(
      builder: (context, state) {
        return switch (state) {
          HiveDetailsLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          HiveDetailsSuccess() => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'current_hive_info'.tr(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildHiveCard(state),
                  const SizedBox(height: 16),
                  _buildQueenSection(state.queen),
                ],
              ),
            ),
          HiveDetailsError() => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 48,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'failed_to_load_hive'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'please_try_again_later'.tr(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          _ => const SizedBox(),
        };
      },
    );
  }

  Widget _buildHiveCard(HiveDetailsSuccess state) {
    final formattedDate = DateFormat('MMMM d, y').format(state.hive.createdAt);
    
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.hive.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${'type'.tr()}: ${state.hive.type}',
                style: const TextStyle(fontSize: 16),
              ),
              if (state.apiary != null) ...[
                Text(
                  '${'location'.tr()}: ${state.apiary!.name}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
              Text(
                '${'order'.tr()}: ${state.hive.order}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                '${'created'.tr()}: $formattedDate',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQueenSection(Queen? queen) {
    if (queen == null) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppVectors.queen,
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Color.fromARGB(255, 201, 173, 36), 
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'queen'.tr(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'no_queen_assigned'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    return _buildQueenCard(queen);
  }

  Widget _buildQueenCard(Queen queen) {
    final formattedBirthDate = DateFormat('MMMM d, y').format(queen.birthDate);
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppVectors.queen,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    Color.fromARGB(255, 218, 165, 32),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'queen'.tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '${'breed'.tr()}: ${queen.breed}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              '${'origin'.tr()}: ${queen.origin}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'birth_date_format'.tr(args: [formattedBirthDate]),
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              '${'status'.tr()}: ${queen.isAlive ? 'active'.tr() : 'inactive_status'.tr()}',
              style: TextStyle(
                fontSize: 16,
                color: queen.isAlive ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
