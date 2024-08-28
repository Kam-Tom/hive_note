import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/dashboard/bloc/bloc/dashboard_todos_bloc.dart';
import 'package:hive_note/shared/presentation/widgets/widgets.dart';
import 'package:repositories/repositories.dart';
import 'dashboard_view.dart';
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isFirstScreen: true,
        isRound: false,
      ),
      body:MultiBlocProvider(
        providers: [
          BlocProvider<DashboardTodosBloc>(
            create: (_) => DashboardTodosBloc(
              todoRepository: context.read<TodoRepository>(),
            )..add(const DashboardTodosSubscriptionRequested()),
          ),
        ],
        child: const DashboardView(),
      ),
      bottomNavigationBar: CustomAppFooter(),
    );
  }
  
}
