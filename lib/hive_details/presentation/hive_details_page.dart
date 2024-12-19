import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/hive_details/cubit/hive_details_cubit.dart';
import 'package:hive_note/hive_details/presentation/hive_details_view.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';

class HiveDetailsPage extends StatelessWidget {
  const HiveDetailsPage({
    super.key,
    required this.hiveId,
  });

  final String hiveId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HiveDetailsCubit(
        hiveRepository: context.read<HiveRepository>(),
        apiaryRepository: context.read<ApiaryRepository>(),
        queenRepository: context.read<QueenRepository>(),
      )..loadHiveDetails(hiveId),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: const HiveDetailsView(),
        bottomNavigationBar: CustomAppFooter(),
      ),
    );
  }
}