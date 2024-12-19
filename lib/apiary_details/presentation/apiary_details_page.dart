import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/apiary_details/cubit/apiary_details_cubit.dart';
import 'package:hive_note/apiary_details/presentation/apiary_details_view.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';

class ApiaryDetailsPage extends StatelessWidget {
  const ApiaryDetailsPage({super.key,
  required this.apiaryId});

  final String apiaryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApiaryDetailsCubit(
        apiaryRepository: context.read<ApiaryRepository>(), 
        hiveRepository: context.read<HiveRepository>(),
      )..loadApiaryDetails(apiaryId),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: const ApiaryDetailsView(),
        bottomNavigationBar: CustomAppFooter(),
      ),
    );
  }
}