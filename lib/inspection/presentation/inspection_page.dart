import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/inspection/bloc/inspection_bloc.dart';
import 'package:hive_note/shared/features/entry_field.dart';
import 'package:hive_note/inspection/presentation/inspection_view.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';

class InspectionPage extends StatelessWidget {
  const InspectionPage({required this.apiaryId, super.key});

  final String apiaryId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InspectionBloc(
            preferencesRepository: context.read<PreferencesRepository>(),
            apiaryRepository: context.read<ApiaryRepository>(),
            hiveRepository: context.read<HiveRepository>(),
            raportRepository: context.read<RaportRepository>(),
            entryMetadataRepository: context.read<EntryMetadataRepository>(),
          )..add(LoadApiary(apiaryId: apiaryId)),
        ),
        BlocProvider(
          create: (_) => EntryFieldCubit(),
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
                final entries = context.read<EntryFieldCubit>().getValues();
                context.read<InspectionBloc>().add(CreateRaport(entries: entries));

                if (state.selectedHiveInspection?.inspected ?? false) {
                  Fluttertoast.showToast(
                    msg: 'inspection_updated'.tr(),
                    backgroundColor: Colors.blue,
                  );
                } else if (state.isLastHive) {
                  Fluttertoast.showToast(
                    msg: 'inspection_completed'.tr(),
                    backgroundColor: Colors.green,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: 'inspection_created'.tr(),
                    backgroundColor: Colors.green,
                  );
                }
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
