import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/inspection/bloc/inspection_bloc.dart';
import 'package:hive_note/inspection/bloc/widgets/entry_field.dart';
import 'package:hive_note/inspection/presentation/inspection_view.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';

class InspectionPage extends StatelessWidget {
  const InspectionPage({required this.apiaryId, super.key});

  final String apiaryId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InspectionBloc(
            apiaryRepository: context.read<ApiaryRepository>(),
            hiveRepository: context.read<HiveRepository>(),
            raportRepository: context.read<RaportRepository>(),
            entryMetadataRepository: context.read<EntryMetadataRepository>(),
          )..add(LoadApiary(apiaryId: apiaryId)),
        ),
        BlocProvider(
          create: (_) => EntryFieldCubit(), // We'll initialize this properly in EntryFieldsList
        ),
      ],
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: const InspectionView(),
        bottomNavigationBar: CustomAppFooter(),
        floatingActionButton: BlocBuilder<InspectionBloc, InspectionState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                final cubitState = context.read<EntryFieldCubit>().state;
                final entries = Map<String,String?>.from(cubitState);
                entries.remove('_source');
                context.read<InspectionBloc>().add(CreateRaport(entries: entries));
              },
              child: Icon(
                state.isLastHive ? Icons.send : Icons.navigate_next,
              ),
            );
          }
        ),
      ),
    );
  }
}
