import 'package:flutter/material.dart';
import 'package:hive_note/ManageApiaries/presentation/manage_apiaries_view.dart';
import 'package:hive_note/shared/presentation/widgets/widgets.dart';

class ManageApiariesPage extends StatelessWidget {
  const ManageApiariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
      ),
      body: const ManageApiariesView(),
      bottomNavigationBar: CustomAppFooter(),
    );
  }

}