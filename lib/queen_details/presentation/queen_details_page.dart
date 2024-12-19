import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/queen_details/cubit/queen_details_cubit.dart';
import 'package:hive_note/queen_details/presentation/queen_details_view.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';

class QueenDetailsPage extends StatelessWidget {
  const QueenDetailsPage({
    super.key,
    required this.queenId,
  });

  final String queenId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QueenDetailsCubit(
        queenRepository: context.read<QueenRepository>(),
        apiaryRepository: context.read<ApiaryRepository>(),
        hiveRepository: context.read<HiveRepository>(),
      )..loadQueenDetails(queenId),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: const QueenDetailsView(),
        bottomNavigationBar: CustomAppFooter(),
      ),
    );
  }
}