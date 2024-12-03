import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/harves/bloc/harvest_bloc.dart';
import 'package:hive_note/harves/presentation/harvest_view.dart';
import 'package:hive_note/shared/features/entry_field.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';

class HarvestPage extends StatelessWidget {
  const HarvestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HarvestBloc(
            apiaryRepository: context.read<ApiaryRepository>(),
            hiveRepository: context.read<HiveRepository>(),
            raportRepository: context.read<RaportRepository>(),
            entryMetadataRepository: context.read<EntryMetadataRepository>(),
          )..add(const LoadApiaries()),
        ),
        BlocProvider(
          create: (_) => EntryFieldCubit(), 
        ),
      ],
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: HarvestView(),
        bottomNavigationBar: CustomAppFooter(),
        floatingActionButton: BlocBuilder<HarvestBloc, HarvestState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                final entries = context.read<EntryFieldCubit>().getValues();
                context.read<HarvestBloc>().add(CreateRaport(entries: entries));
                context.read<EntryFieldCubit>().clear();
              
              },
              child: const Icon(Icons.send),
            );
          }
        ),
      ),
    );
  }
}
