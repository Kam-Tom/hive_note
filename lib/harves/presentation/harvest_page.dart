import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/harves/bloc/harvest_bloc.dart';
import 'package:hive_note/harves/presentation/harvest_view.dart';
import 'package:hive_note/shared/features/entry_field.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';

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
                if (entries.isEmpty) {
                  Fluttertoast.showToast(
                    msg: 'harvest_no_data'.tr(),
                    backgroundColor: Colors.red,
                  );
                  return;
                }
                if (state.selectedHives.isEmpty && state.selectedApiaries.isEmpty) {
                  Fluttertoast.showToast(
                    msg: 'harvest_no_selection'.tr(),
                    backgroundColor: Colors.red,
                  );
                  return;
                }
                context.read<HarvestBloc>().add(CreateRaport(entries: entries));
                context.read<EntryFieldCubit>().clear();
                Fluttertoast.showToast(
                  msg: 'harvest_created'.tr(),
                  backgroundColor: Colors.green,
                );
              },
              child: const Icon(Icons.send),
            );
          }
        ),
      ),
    );
  }
}
