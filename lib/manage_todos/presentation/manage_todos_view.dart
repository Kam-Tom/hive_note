import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/core/configs/icon_mappers/todo_category_icons.dart';
import 'package:hive_note/core/configs/setup/flutter_notifications.dart';
import 'package:hive_note/core/configs/theme/app_colors.dart';
import 'package:hive_note/manage_todos/bloc/manage_todos_bloc.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:hive_note/shared/presentation/dialogs/delete_confirmation_dialog.dart';
import 'package:repositories/repositories.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:easy_localization/easy_localization.dart';

class ManageTodosView extends StatelessWidget {
  const ManageTodosView({super.key});
  
  static const int maxCirclesInCalendar = 3;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ManageTodosBloc>().state;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTodoForm(context, state),
            SizedBox(
              height: 100,
              child: _buildTodoList(context, state),
            ),
            _buildCalendar(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoForm(BuildContext context, ManageTodosState state) {
    if (state.editingTodo != null && state.isEditing) {
      return _buildTodoInputForm(context, state);
    } else if (state.editingTodo != null) {
      return _buildTodoDetails(context, state);
    } else {
      return _buildEmptyCard();
    }
  }

  Widget _buildEmptyCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text('no_todo_selected'.tr()),
      ),
    );
  }

  Widget _buildTodoInputForm(BuildContext context, ManageTodosState state) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField<CategoryType>(
                    value: state.todoForm.categoryType,
                    decoration: InputDecoration(
                      labelText: 'category'.tr(),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: CategoryType.values.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: TodoCategoryIcons.categoryIcons[category]!,
                            ),
                            const SizedBox(width: 8),
                            Text(category.name, style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      context.read<ManageTodosBloc>().add(
                            UpdateTodoFormEvent(categoryType: value),
                          );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'location'.tr(),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    onChanged: (value) {
                      context.read<ManageTodosBloc>().add(
                            UpdateTodoFormEvent(location: value),
                          );
                    },
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: state.todoForm.location,
                        selection: TextSelection.collapsed(offset: state.todoForm.location.length),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int?>(
              value: null,
              decoration: InputDecoration(
                labelText: 'reminder'.tr(),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: [
                DropdownMenuItem(
                  value: null, 
                  child: Text(
                    'no_reminder'.tr(),
                    style: const TextStyle(fontSize: 13),
                  )
                ),
                DropdownMenuItem(
                  value: 1, 
                  child: Text(
                    'day_before_1'.tr(),
                    style: const TextStyle(fontSize: 13),
                  )
                ),
                DropdownMenuItem(
                  value: 2, 
                  child: Text(
                    'day_before_2'.tr(),
                    style: const TextStyle(fontSize: 13),
                  )
                ),
                DropdownMenuItem(
                  value: 3, 
                  child: Text(
                    'day_before_3'.tr(),
                    style: const TextStyle(fontSize: 13),
                  )
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  final notificationDay = state.selectedDate.subtract(Duration(days: value));
                  final notificationDate = DateTime(
                    notificationDay.year,
                    notificationDay.month,
                    notificationDay.day,
                    8,
                    0,
                  );
                  NotificationService.unscheduleNotification(
                    state.todoForm.id.hashCode,
                  );
                  NotificationService.scheduleNotification(
                    state.todoForm.id.hashCode,
                    'todo_reminder'.tr(),
                    'todo_reminder_description'.tr(args: [
                      state.todoForm.description,
                      state.todoForm.location,
                    ]),
                    notificationDate,
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'description'.tr(),
                alignLabelWithHint: true,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<ManageTodosBloc>().add(
                      UpdateTodoFormEvent(description: value),
                    );
              },
              controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: state.todoForm.description,
                  selection: TextSelection.collapsed(offset: state.todoForm.description.length),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (state.todoForm.isCompleted)
              Text(
                'todo_completed_message'.tr(),
                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (state.isEditing)
                  TextButton(
                    onPressed: () {
                      context.read<ManageTodosBloc>().add(CancelEditTodoEvent());
                    },
                    child: const Text('Cancel'),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (state.isEditing) {
                      context.read<ManageTodosBloc>().add(
                            UpdateTodo(
                              todo: state.todoForm.copyWith(
                                id: state.editingTodo!.id,
                                dueTo: state.selectedDate,
                                isCompleted: state.editingTodo!.isCompleted,
                              ),
                            ),
                          );
                    } else {
                      context.read<ManageTodosBloc>().add(
                            CreateTodo(
                              todo: state.todoForm.copyWith(
                                dueTo: state.selectedDate,
                              ),
                            ),
                          );
                    }
                  },
                  child: Text(state.isEditing ? 'update'.tr() : 'save'.tr()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoDetails(BuildContext context, ManageTodosState state) {
    final todo = state.editingTodo!;
    final bool isOverdue = !todo.isCompleted && todo.dueTo.isBefore(DateTime.now());

    return Card(
      margin: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'location_label'.tr(),
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        todo.location,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatDate(todo.dueTo),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: TodoCategoryIcons.categoryIcons[todo.categoryType]!,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            todo.categoryType.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.edit, color: AppColors.textBackground),
                        onPressed: () {
                          context.read<ManageTodosBloc>().add(StartEditTodoEvent());
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'description_label'.tr(),
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Container(
                constraints: const BoxConstraints(maxHeight: 70),
                child: SingleChildScrollView(
                  child: Text(
                    todo.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (todo.isCompleted)
                Text(
                  'todo_completed_message'.tr(),
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              if (isOverdue)
                Text(
                  'todo_overdue_message'.tr(),
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    final confirmed = await showDeleteConfirmationDialog(context);
                    if (confirmed == true) {
                      context.read<ManageTodosBloc>().add(DeleteTodo(todo: todo));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Use DateFormat for consistent date formatting
    return DateFormat('MM/dd/yyyy').format(date);
  }

  Widget _buildTodoList(BuildContext context, ManageTodosState state) {
    if (state.status == Status.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.status == Status.success) {
      final todosOnSelectedDate = state.todos
          .where((todo) => isSameDay(todo.dueTo, state.selectedDate))
          .toList();

      return ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          for (var todo in todosOnSelectedDate)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: InkWell(
                onTap: () {
                  context.read<ManageTodosBloc>().add(EditTodoEvent(todo: todo));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getCategoryColor(todo.categoryType).withOpacity(todo.isCompleted ? 0.5 : 1.0),
                        border: todo == state.editingTodo
                            ? Border.all(color: Colors.blue, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: TodoCategoryIcons.categoryIcons[todo.categoryType]!,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 60,
                      child: Text(
                        todo.location,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                final newTodo = Todo(
                  description: '',
                  location: '',
                  categoryType: CategoryType.other,
                  dueTo: state.selectedDate,
                  isCompleted: false,
                );
                context.read<ManageTodosBloc>().add(CreateTodo(
                  todo: newTodo,
                ));
                context.read<ManageTodosBloc>().add(EditTodoEvent(
                  todo: newTodo,
                ));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: const Center(
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 60,
                    child: Text(
                      'add_todo'.tr(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    return const SizedBox();
  }

  Widget _buildCalendar(BuildContext context, ManageTodosState state) {

    return TableCalendar(
      firstDay: DateTime.utc(2000, 1, 1),
      lastDay: DateTime.utc(2100, 12, 31),
      focusedDay: state.focusedDate,
      calendarFormat: CalendarFormat.month, // Add this line
      onFormatChanged: (format) {
        // Add this callback
        // You can handle format changes here if needed
      },
      selectedDayPredicate: (day) {
        return isSameDay(state.selectedDate, day);
      },
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          final todosOnDay = state.todos
              .where((todo) => isSameDay(todo.dueTo, day))
              .toList();
          
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${day.day}'),
              if (todosOnDay.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...todosOnDay.take(maxCirclesInCalendar).map((todo) =>
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(right: 2),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(todo.categoryType),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    if (todosOnDay.length > maxCirclesInCalendar)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            '+',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 6,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          );
        },
      ),
      onDaySelected: (selectedDay, focusedDay) {
        // Ensure consistent date format by converting to UTC
        final normalizedDay = DateTime.utc(
          selectedDay.year,
          selectedDay.month,
          selectedDay.day,
        );
        context.read<ManageTodosBloc>().add(SelectDate(selectedDate: normalizedDay));
      },
    );
  }

  Color _getCategoryColor(CategoryType category) {
    switch (category) {
      case CategoryType.feeding:
        return Colors.green;
      case CategoryType.inspection:
        return Colors.blue;
      case CategoryType.harvest:
        return Colors.deepOrange;
      case CategoryType.winterize:
        return Colors.cyan;
      case CategoryType.sell:
        return Colors.indigo;
      case CategoryType.buy:
        return Colors.purple;
      case CategoryType.queen:
        return Colors.pink;
      case CategoryType.treatment:
        return Colors.red;
      case CategoryType.other:
        return Colors.grey;
    }
  }
}
