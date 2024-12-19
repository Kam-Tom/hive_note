import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/apiary_details/cubit/apiary_details_cubit.dart';
import 'package:repositories/repositories.dart';

class ApiaryDetailsView extends StatelessWidget {
  const ApiaryDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiaryDetailsCubit, ApiaryDetailsState>(
      builder: (context, state) {
        if (state is ApiaryDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ApiaryDetailsSuccess) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLastUpdateInfo(state.apiary.createdAt),
                const SizedBox(height: 16),
                _buildApiaryCard(state),
                const SizedBox(height: 24),
                _buildHivesList(state.hives),
              ],
            ),
          );
        } else if (state is ApiaryDetailsError) {
          return Center(
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
                  'failed_to_load_apiary'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'please_try_again_later'.tr(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildLastUpdateInfo(DateTime date) {
    return Text(
      'current_apiary_info'.tr(),
      style: const TextStyle(
        fontSize: 12,
        fontStyle: FontStyle.italic,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildApiaryCard(ApiaryDetailsSuccess state) {
    final formattedDate = DateFormat('MMMM d, y').format(state.apiary.createdAt);
    
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
                state.apiary.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'total_hives'.tr(args: [state.hives.length.toString()]),
                style: const TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  Icon(
                    state.apiary.isActive ? Icons.check_circle : Icons.cancel,
                    color: state.apiary.isActive ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${'status'.tr()}: ${state.apiary.isActive ? 'active'.tr() : 'inactive_status'.tr()}',
                    style: TextStyle(
                      fontSize: 16,
                      color: state.apiary.isActive ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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

  Widget _buildHivesList(List<Hive> hives) {
    return Expanded(
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
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: hives.length,
              itemBuilder: (context, index) {
                final hive = hives[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(hive.order.toString()),
                    ),
                    title: Text(
                      hive.name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(hive.type),
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
