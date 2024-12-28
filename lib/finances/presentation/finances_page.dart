import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/finances/bloc/finances_bloc.dart';
import 'package:hive_note/finances/presentation/finances_view.dart';
import 'package:hive_note/shared/features/entry_field.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';

class FinancesPage extends StatelessWidget {
  const FinancesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FinancesBloc(
            // apiaryRepository: context.read<ApiaryRepository>(),
            // hiveRepository: context.read<HiveRepository>(),
            raportRepository: context.read<RaportRepository>(),
            entryMetadataRepository: context.read<EntryMetadataRepository>(),
          )..add(const LoadData()),
        ),
        BlocProvider(
          create: (_) => EntryFieldCubit(), 
        ),
      ],
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: FinancesView(),
        bottomNavigationBar: CustomAppFooter(),
        floatingActionButton: BlocBuilder<FinancesBloc, FinancesState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                final entries = context.read<EntryFieldCubit>().getValues();
                if (entries.isEmpty || state.amount <= 0 || state.cost <= 0) {
                  Fluttertoast.showToast(
                    msg: 'finances_no_data'.tr(),
                    backgroundColor: Colors.red,
                  );
                  return;
                }
                context.read<FinancesBloc>().add(CreateTransaction(entries: entries));
                context.read<EntryFieldCubit>().clear();
                Fluttertoast.showToast(
                  msg: 'finances_created'.tr(),
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
