import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_note/harves/bloc/models/jar_size.dart';
import 'package:hive_note/shared/presentation/widgets/multi_select_field.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/harves/bloc/harvest_bloc.dart';
import 'package:hive_note/harves/presentation/harvest_view.dart';
import 'package:hive_note/shared/features/entry_field.dart';
import 'package:repositories/repositories.dart';

class MockHarvestBloc extends Mock implements HarvestBloc {}
class MockEntryFieldCubit extends Mock implements EntryFieldCubit {}

void main() {
  late HarvestBloc harvestBloc;
  late EntryFieldCubit entryFieldCubit;

  setUp(() {
    harvestBloc = MockHarvestBloc();
    entryFieldCubit = MockEntryFieldCubit();
    when(() => harvestBloc.stream).thenAnswer((_) => Stream.value(HarvestState()));
    when(() => harvestBloc.state).thenReturn(HarvestState());
    when(() => entryFieldCubit.stream).thenAnswer((_) => Stream.value({}));
    when(() => entryFieldCubit.getValues()).thenReturn({});
  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HarvestBloc>.value(value: harvestBloc),
        BlocProvider<EntryFieldCubit>.value(value: entryFieldCubit),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: HarvestView(),
        ),
      ),
    );
  }

  testWidgets('should render the HarvestView widget', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(HarvestView), findsOneWidget);
  });

  testWidgets('should display MultiSelectField widgets for apiaries and hives', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(MultiSelectField<Apiary>), findsOneWidget);
    expect(find.byType(MultiSelectField<Hive>), findsOneWidget);
  });

  testWidgets('should display available jar sizes', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text('select_jar_size'.tr()), findsOneWidget);
  });

  testWidgets('should update the state when selecting apiaries', (tester) async {
    final apiary = Apiary(id: '1', name: 'Apiary 1', order: 1, createdAt: DateTime.now());
    when(() => harvestBloc.state).thenReturn(HarvestState(apiaries: [apiary]));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.text('select_apiaries'.tr()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Apiary 1').first);
    await tester.tap(find.text('OK').first);
    await tester.pumpAndSettle();

    verify(() => harvestBloc.add(SelectApiaries([apiary]))).called(1);
  });

  testWidgets('should update the state when selecting hives', (tester) async {
    final hive = Hive(id: '1', name: 'Hive 1', type: 'Type 1', order: 1, createdAt: DateTime.now());
    when(() => harvestBloc.state).thenReturn(HarvestState(hives: [hive]));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.text('select_hives'.tr()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Hive 1').first);
    await tester.tap(find.text('OK').first);
    await tester.pumpAndSettle();

    verify(() => harvestBloc.add(SelectHives([hive]))).called(1);
  });

  testWidgets('should add a jar entry when tapping on jar size', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.text('X'));
    await tester.pumpAndSettle();
    
    verify(() => harvestBloc.add(AddJarEntry(JarSize.jarSizes.first))).called(1);
  });
}
