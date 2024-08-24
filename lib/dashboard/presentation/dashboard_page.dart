import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/dashboard/bloc/bloc/dashboard_bloc.dart';
import 'package:hive_note/dashboard/presentation/dashboard_view.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';
import 'package:repositories/repositories.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isFirstScreen: true,
        isRound: false,
      ),
      body: BlocProvider(create: (context) => DashboardBloc(todoRepository: context.read<TodoRepository>()),
        child: const DashboardView(),
      ),

      bottomNavigationBar: CustomAppFooter(),
    );
  }
  
}
