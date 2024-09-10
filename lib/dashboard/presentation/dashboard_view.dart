import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_note/ManageApiaries/presentation/manage_apiaries_page.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/dashboard/bloc/dashboard_blocs.dart';
import 'package:hive_note/dashboard/presentation/widgets/inspections/inspections.dart';
import 'package:hive_note/dashboard/presentation/widgets/todos/todos.dart';
import 'package:hive_note/shared/presentation/pages/tmp_page.dart';
import 'package:hive_note/shared/presentation/widgets/widgets.dart';
import 'package:repositories/repositories.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _TodoCarousel(),
            _InspectionCarousel(),
            _Buttons(),
          ],
        ),
      ),
    );
  }
}

class _TodoCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todosState = context.watch<DashboardTodosBloc>().state;
    final todos = todosState.todos;
    final status = todosState.status;

    Widget todosWidget;

    switch (status) {
      case DashboardTodosStatus.loading:
        todosWidget = const TodoCardLoading();
        break;
      case DashboardTodosStatus.empty:
        todosWidget = TodoCardEmpty(onAddTodo: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TMPPage()),
        ));
        break;
      case DashboardTodosStatus.success:
        todosWidget = _buildTodoCarousel(context, todos);
        break;
      case DashboardTodosStatus.failure:
        todosWidget = TodoCardError(
          onRetry: () => context.read<DashboardTodosBloc>().add(const DashboardTodosRetryRequest()),
        );
        break;
      default:
        todosWidget = const SizedBox.shrink();
    }

    return _buildTodoCarouselContainer(todosWidget);
  }

  Widget _buildTodoCarousel(BuildContext context, List<Todo> todos) {
    return CarouselSlider.builder(
      key: ValueKey(todos.length),
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        padEnds: true,
        enableInfiniteScroll: false,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
      ),
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        final todo = todos[itemIndex];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TodoCard(
            todo: todo,
            onLongPress: (todo) => _completeTodoWithFeedback(context, todo),
            onTap: (todo) => _showTodoDetails(context, todo),
          ),
        );
      },
    );
  }

  void _completeTodoWithFeedback(BuildContext context, Todo todo) {
    HapticFeedback.vibrate();
    context.read<DashboardTodosBloc>().add(DashboardTodosToggleIsComplete(todo: todo, isCompleted: true));
    Fluttertoast.showToast(
      msg: "complete_todo".tr(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.failure,
      textColor: AppColors.white,
      fontSize: 16.0,
    );
  }

  void _showTodoDetails(BuildContext context, Todo todo) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return TodoDetailsModal(todo: todo);
      },
    );
  }

  Widget _buildTodoCarouselContainer(Widget todosWidget) {
    return Container(
      height: 225,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: todosWidget,
    );
  }
}

class _InspectionCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiariesState = context.watch<DashboardInspectionsBloc>().state;
    final apiaries = apiariesState.apiaries;
    final status = apiariesState.status;

    if (status == DashboardInspectionsStatus.loading) {
      return const InspectionCardLoading();
    } else if (status == DashboardInspectionsStatus.failure) {
      return InspectionCardError(
        onRetry: () => context.read<DashboardInspectionsBloc>().add(const DashboardInspectionsRetryRequest()),
      );
    } else if (status == DashboardInspectionsStatus.empty) {
      return InspectionCardEmpty(
        onPressed: () => _navigateToTMPPage(context),
      );
    }

    return _buildInspectionCarousel(apiaries, context);
  }

  Widget _buildInspectionCarousel(List<Apiary> apiaries, BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 125.0,
        enableInfiniteScroll: false,
      ),
      itemCount: apiaries.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        final apiary = apiaries[itemIndex];
        return InspectionCard(
          apiary: apiary,
          onPressed: (apiary) => _navigateToTMPPage(context),
        );
      },
    );
  }

  void _navigateToTMPPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TMPPage()),
    );
  }
}

class _Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMenuButtonRow(
              buttons: [
                _buildMenuButton(AppVectors.apiary, "apiaries".tr(), const ManageApiariesPage()),
                _buildMenuButton(AppVectors.statistics, "statistics".tr(), const TMPPage()),
              ],
            ),
            _buildMenuButtonRow(
              buttons: [
                _buildMenuButton(AppVectors.calendar, "calendar".tr(), const TMPPage()),
                _buildMenuButton(AppVectors.note, "records".tr(), const TMPPage()),
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

  Widget _buildMenuButton(String asset, String label, Widget newPage) {
    return MenuButton(
      newPage: newPage,
      icon: SvgPicture.asset(asset, width: 50),
      text: Text(label),
    );
  }
}