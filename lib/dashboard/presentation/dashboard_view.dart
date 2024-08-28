import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Center(

    ),
  );
}
  // Widget _buildTopCarousel() {
  //   return Container(
  //     height: 225,
  //     decoration: const BoxDecoration(
  //       color: AppColors.primary,
  //       borderRadius: BorderRadius.only(
  //         bottomLeft: Radius.circular(25),
  //         bottomRight: Radius.circular(25),
  //       ),
  //     ),
  //     child: CarouselSlider.builder(
  //       options: CarouselOptions(
  //         height: 200.0,
  //         enlargeCenterPage: true,
  //       ),
  //       itemCount: _toDos.length,
        
  //       itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          
  //         final toDo = _toDos[itemIndex];
  //         return ToDoCard(
  //           toDo: toDo,
  //           onPressed: (toDo) {},
  //         );
  //       },
  //     ),
  //   );
  // }

  // Widget _buildInspectionCarousel() {
  //   return CarouselSlider.builder(
  //     options: CarouselOptions(
  //       height: 125.0,
  //     ),
  //     itemCount: _hives.length,
  //     itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
  //       final hive = _hives[itemIndex];
  //       return InspectionCard(
  //         hive: hive,
  //         onPressed: (hive) {},
  //       );
  //     },
  //   );
  // }

  // Widget _buildMenuButtons() {
  //   return Expanded(
  //     child: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           _buildMenuButtonRow(
  //             buttons: [
  //               _buildMenuButton(AppVectors.apiary, 'Apiary', const ApiaryPage()),
  //               _buildMenuButton(AppVectors.statistics, 'Statistics', const StatisticsPage()),
  //             ],
  //           ),
  //           _buildMenuButtonRow(
  //             buttons: [
  //               _buildMenuButton(AppVectors.calendar, 'ToDo', const CalendarPage()),
  //               _buildMenuButton(AppVectors.note, 'Records', const RecordsPage()),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildMenuButtonRow({required List<Widget> buttons}) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: buttons,
  //   );
  // }

  // Widget _buildMenuButton(String asset, String label, Widget newPage) {
  //   return MenuButton(
  //     newPage: newPage,
  //     icon: SvgPicture.asset(asset, width: 50),
  //     text: Text(label),
      
  //   );
  // }

  
}