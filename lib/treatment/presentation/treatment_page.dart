import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/shared/features/entry_field.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:hive_note/treatment/bloc/treatment_bloc.dart';
import 'package:hive_note/treatment/presentation/treatment_view.dart';
import 'package:repositories/repositories.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';

class TreatmentPage extends StatelessWidget {
  const TreatmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TreatmentBloc(
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
        body: const TreatmentView(),
        bottomNavigationBar: CustomAppFooter(),
        floatingActionButton: BlocBuilder<TreatmentBloc, TreatmentState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                final entries = context.read<EntryFieldCubit>().getValues();
                if (entries.isEmpty || state.selectedHives.isEmpty) {
                  Fluttertoast.showToast(
                    msg: state.selectedHives.isEmpty 
                      ? 'treatment_no_selection'.tr()
                      : 'treatment_no_data'.tr(),
                    backgroundColor: Colors.red,
                  );
                  return;
                }
                context.read<TreatmentBloc>().add(CreateTreatmentRaport(entries: entries));
                context.read<EntryFieldCubit>().clear();
                Fluttertoast.showToast(
                  msg: 'treatment_created'.tr(),
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
