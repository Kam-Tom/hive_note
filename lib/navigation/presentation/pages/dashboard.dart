import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/navigation/models/hive.dart';
import 'package:hive_note/navigation/models/todo.dart';
import 'package:hive_note/navigation/presentation/widgets/inspection_card.dart';
import 'package:hive_note/navigation/presentation/widgets/menu_button.dart';
import 'package:hive_note/navigation/presentation/widgets/todo_card.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_bar.dart';
import 'package:hive_note/shared/presentation/widgets/custom_app_footer.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  // Dummy data for Hives
  final List<Hive> _hives = [
    Hive(id: 1, name: 'Białystok', count: 10),
    Hive(id: 2, name: 'Biała Podlaska', count: 40),
    Hive(id: 3, name: 'Hive 3', count: 50),
  ];

  // Dummy data for ToDo
  final List<ToDo> _toDos = [
    ToDo(
      apiaryName: 'Apiary 1',
      date: DateTime.now(),
      description: 'Inspect Hive 1',
    ),
    ToDo(
      apiaryName: 'Apiary 2',
      date: DateTime.now().add(Duration(days: 1)),
      description: 'Check Hive 2 for honey',
    ),
    ToDo(
      apiaryName: 'Apiary 3',
      date: DateTime.now().add(Duration(days: 2)),
      description: 'Clean Hive 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isFirstScreen: true,
        isRound: false,
      ),
      body: Column(
        children: [
          _buildTopCarousel(),
          _buildInspectionCarousel(),
          _buildMenuButtons(),
        ],
      ),
      bottomNavigationBar: CustomAppFooter(),
    );
  }

  Widget _buildTopCarousel() {
    return Container(
      height: 225,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 200.0,
          enlargeCenterPage: true,
        ),
        itemCount: _toDos.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          final toDo = _toDos[itemIndex];
          return ToDoCard(
            toDo: toDo,
            onPressed: (toDo) {},
          );
        },
      ),
    );
  }

  Widget _buildInspectionCarousel() {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 125.0,
      ),
      itemCount: _hives.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        final hive = _hives[itemIndex];
        return InspectionCard(
          hive: hive,
          onPressed: (hive) {},
        );
      },
    );
  }

  Widget _buildMenuButtons() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMenuButtonRow(
              buttons: [
                _buildMenuButton(AppVectors.apiary, 'Apiary'),
                _buildMenuButton(AppVectors.statistics, 'Statistics'),
              ],
            ),
            _buildMenuButtonRow(
              buttons: [
                _buildMenuButton(AppVectors.calendar, 'ToDo'),
                _buildMenuButton(AppVectors.note, 'Records'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButtonRow({required List<Widget> buttons}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }

  Widget _buildMenuButton(String asset, String label) {
    return MenuButton(
      onPressed: () {},
      icon: SvgPicture.asset(asset, width: 50),
      text: Text(label),
    );
  }
}
