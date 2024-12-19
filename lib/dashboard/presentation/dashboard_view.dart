import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_note/core/configs/setup/app_router.dart';
import 'package:hive_note/core/configs/assets/app_vectors.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/dashboard/bloc/dashboard_blocs.dart';
import 'package:hive_note/dashboard/presentation/widgets/inspections/inspections.dart';
import 'package:hive_note/dashboard/presentation/widgets/todos/todos.dart';
import 'package:hive_note/shared/presentation/widgets/widgets.dart';
import 'package:repositories/repositories.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
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

class _TodoCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todosState = context.watch<DashboardTodosBloc>().state;
    final todos = todosState.todos;
    final status = todosState.status;

    return _buildTodoCarouselContainer(_buildTodoContent(context, status, todos));
  }

  Widget _buildTodoContent(
      BuildContext context, DashboardTodosStatus status, List<Todo> todos) {
    switch (status) {
      case DashboardTodosStatus.loading:
        return const TodoCardLoading();
      case DashboardTodosStatus.empty:
        return TodoCardEmpty(
            onAddTodo: () =>
                Navigator.pushNamed(context, AppRouter.manageTodosPath));
      case DashboardTodosStatus.success:
        return _buildTodoCarousel(context, todos);
      case DashboardTodosStatus.failure:
        return TodoCardError(
          onRetry: () => context
              .read<DashboardTodosBloc>()
              .add(const DashboardTodosRetryRequest()),
        );
      default:
        return const SizedBox.shrink();
    }
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
      itemBuilder: (context, itemIndex, pageViewIndex) {
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

  Widget _buildTodoCarouselContainer(Widget content) => Container(
        height: 225,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: content,
      );

  void _completeTodoWithFeedback(BuildContext context, Todo todo) {
    HapticFeedback.heavyImpact();
    context
        .read<DashboardTodosBloc>()
        .add(DashboardTodosToggleIsComplete(todo: todo, isCompleted: true));
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
      builder: (context) => TodoDetailsModal(todo: todo),
    );
  }
}

class _InspectionCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiariesState = context.watch<DashboardInspectionsBloc>().state;
    return _buildContent(context, apiariesState);
  }

  Widget _buildContent(BuildContext context, DashboardInspectionsState state) {
    switch (state.status) {
      case DashboardInspectionsStatus.loading:
        return const InspectionCardLoading();
      case DashboardInspectionsStatus.failure:
        return InspectionCardError(
          onRetry: () => context
              .read<DashboardInspectionsBloc>()
              .add(const DashboardInspectionsRetryRequest()),
        );
      case DashboardInspectionsStatus.empty:
        return InspectionCardEmpty(
          onPressed: () =>
              Navigator.pushNamed(context, AppRouter.manageApiariesPath),
        );
      default:
        return _buildInspectionCarousel(state.apiaries, context);
    }
  }

  Widget _buildInspectionCarousel(
          List<ApiaryWithHiveCount> apiaries, BuildContext context) =>
      CarouselSlider.builder(
        options: CarouselOptions(
          height: 170.0,
          enableInfiniteScroll: false,
        ),
        itemCount: apiaries.length,
        itemBuilder: (context, itemIndex, pageViewIndex) {
          final apiary = apiaries[itemIndex];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: InspectionCard(
              apiary: apiary,
              onPressed: (apiary) => Navigator.pushNamed(
                context,
                AppRouter.inspectionPath,
                arguments: apiary.id,
              ),
            ),
          );
        },
      );
}

class _Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMenuButtonRow(
                buttons: [
                  _buildMenuButton(
                      AppVectors.apiary, "apiaries".tr(), AppRouter.manageApiariesPath),
                  _buildMenuButton(
                      AppVectors.statistics, "statistics".tr(), AppRouter.statisticsPath),
                ],
              ),
              const SizedBox(height: 20),
              _buildMenuButtonRow(
                buttons: [
                  _buildMenuButton(
                      AppVectors.calendar, "calendar".tr(), AppRouter.manageTodosPath),
                  _buildMenuButton(
                      AppVectors.note, "records".tr(), AppRouter.recordsPath),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _buildMenuButtonRow({required List<Widget> buttons}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buttons[0],
          const SizedBox(width: 20),
          buttons[1],
        ],
      );

  Widget _buildMenuButton(String asset, String label, String newPage) =>
      MenuButton(
        newPage: newPage,
        icon: SvgPicture.asset(asset, width: 50),
        text: Text(label),
      );
}
