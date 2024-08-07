import 'package:flutter/material.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isFirstScreen: true, // Updated parameter name
      ),
      body: ListView.builder(
        itemCount: 100, // Large number of items to make the body bigger than the screen
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
      bottomNavigationBar: CustomAppFooter(


      ),
    );
  }
}