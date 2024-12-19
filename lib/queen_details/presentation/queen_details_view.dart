import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/queen_details/cubit/queen_details_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';

class QueenDetailsView extends StatelessWidget {
  const QueenDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueenDetailsCubit, QueenDetailsState>(
      builder: (context, state) {
        return switch (state) {
          QueenDetailsLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          QueenDetailsSuccess() => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'current_queen_info'.tr(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildQueenCard(state),
                  const SizedBox(height: 16),
                  _buildHiveSection(state),
                ],
              ),
            ),
          QueenDetailsError() => Center(
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
                    'failed_to_load_queen'.tr(),
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

  Widget _buildQueenCard(QueenDetailsSuccess state) {
    final formattedBirthDate = DateFormat('MMMM d, y').format(state.queen.birthDate);
    
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
                    state.queen.breed,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '${'origin'.tr()}: ${state.queen.origin}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'birth_date_format'.tr(args: [formattedBirthDate]),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    state.queen.isAlive ? Icons.check_circle : Icons.cancel,
                    color: state.queen.isAlive ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${'status'.tr()}: ${state.queen.isAlive ? 'active'.tr() : 'inactive_status'.tr()}',
                    style: TextStyle(
                      fontSize: 16,
                      color: state.queen.isAlive ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHiveSection(QueenDetailsSuccess state) {
    if (state.hive == null) {
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
                  'hives'.tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
        ),
      );
    }

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
                'current_hive'.tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${'hive_name'.tr()}: ${state.hive!.name}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                '${'type'.tr()}: ${state.hive!.type}',
                style: const TextStyle(fontSize: 16),
              ),
              if (state.apiary != null)
                Text(
                  '${'location'.tr()}: ${state.apiary!.name}',
                  style: const TextStyle(fontSize: 16),
                ),
              Text(
                '${'order'.tr()}: ${state.hive!.order}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
