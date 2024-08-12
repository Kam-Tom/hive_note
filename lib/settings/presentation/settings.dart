import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/settings/bloc/bottom_navigation_cubit.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(initialIndex: 1),
      child: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, state) {
          return Scaffold(
            appBar: const CustomAppBar(),
            body: Builder(
              builder: (context) {
                switch (state) {
                  case 0:
                    return Container(color: Colors.red,);
                  case 1:
                    return Container(color: Colors.green,);
                  case 2:
                    return Container(color: Colors.blue,);
                  default:
                    return Container(color: Colors.red,);
                }
              },
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: state,
              onDestinationSelected: (index) => context.read<BottomNavigationCubit>().changeTab(index),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.sync), label: 'Sync'),
                NavigationDestination(icon: Icon(Icons.room_preferences), label: 'Preferences'),
                NavigationDestination(icon: Icon(Icons.edit), label: 'Inspections'),
              ],
              backgroundColor: AppColors.primary,
              indicatorColor: AppColors.primaryLight,
              surfaceTintColor: AppColors.white,


            ),
          );
        },
      ),
    );
  }
}