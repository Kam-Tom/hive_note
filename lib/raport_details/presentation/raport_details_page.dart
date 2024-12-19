import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/raport_details/cubit/raport_details_cubit.dart';
import 'package:hive_note/raport_details/presentation/raport_details_view.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';

class RaportDetailsPage extends StatelessWidget {
  const RaportDetailsPage({
    super.key,
    required this.raportId,
  });

  final String raportId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RaportDetailsCubit(
        raportRepository: context.read<RaportRepository>(),
        metadataRepository: context.read<EntryMetadataRepository>(), 
        apiaryRepository: context.read<ApiaryRepository>(), 
        hiveRepository: context.read<HiveRepository>(),
      )..loadRaportDetails(raportId),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: const RaportDetailsView(),
        bottomNavigationBar: CustomAppFooter(),
      ),
    );
  }
}