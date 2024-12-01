import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/inspection/bloc/inspection_bloc.dart';
import 'package:hive_note/inspection/presentation/inspection_view.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';

class InspectionPage extends StatelessWidget {
  const InspectionPage({required this.apiaryId, super.key});

  final String apiaryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocProvider(
        create: (context) => InspectionBloc(
            ),
        child: const InspectionView(),
      ),
      bottomNavigationBar: CustomAppFooter(),
    );
  }
}
