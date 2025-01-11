import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_note/harves/bloc/harvest_bloc.dart';
import 'package:hive_note/harves/bloc/models/jar_size.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:mocktail/mocktail.dart';
import 'package:repositories/repositories.dart';

class MockApiaryRepository extends Mock implements ApiaryRepository {}
class MockHiveRepository extends Mock implements HiveRepository {}
class MockRaportRepository extends Mock implements RaportRepository {}
class MockEntryMetadataRepository extends Mock implements EntryMetadataRepository {}

void main() {
  late MockApiaryRepository apiaryRepository;
  late MockHiveRepository hiveRepository;
  late MockRaportRepository raportRepository;
  late MockEntryMetadataRepository entryMetadataRepository;
  late HarvestBloc harvestBloc;

  setUpAll(() {
    registerFallbackValue(Raport(
      id: 'test',
      raportType: RaportType.harvest,
      createdAt: DateTime.now()
    ));
  });

  setUp(() {
    apiaryRepository = MockApiaryRepository();
    hiveRepository = MockHiveRepository();
    raportRepository = MockRaportRepository();
    entryMetadataRepository = MockEntryMetadataRepository();
    
    harvestBloc = HarvestBloc(
      apiaryRepository: apiaryRepository,
      hiveRepository: hiveRepository,
      raportRepository: raportRepository,
      entryMetadataRepository: entryMetadataRepository,
    );
  });

  tearDown(() {
    harvestBloc.close();
  });

  group('HarvestBloc', () {
    final testApiary = Apiary(
      id: '1',
      name: 'Test Apiary',
      order: 0,
      isActive: true,
      createdAt: DateTime.now(),
    );
    final testHive = Hive(
      id: '1',
      apiaryId: '1',
      type: 'Langstroth',
      name: 'Test Hive',
      order: 0,
      createdAt: DateTime.now(),
    );
    final testEntryMetadata = EntryMetadata(
      id: 'honey_type',
      raportType: RaportType.harvest,
      label: 'Honey Type',
      hint: 'Type of honey',
      valueType: EntryType.text,
      order: 0,
    );

    final testHive1 = Hive(
      id: '1',
      apiaryId: '1',
      type: 'Langstroth',
      name: 'Hive1',
      order: 0,
      createdAt: DateTime.now(),
    );

    final testHive2 = Hive(
      id: '2',
      apiaryId: '1',
      type: 'Langstroth',
      name: 'Hive2',
      order: 1,
      createdAt: DateTime.now(),
    );

    final testHive3 = Hive(
      id: '3',
      apiaryId: '1',
      type: 'Langstroth',
      name: 'Hive3',
      order: 2,
      createdAt: DateTime.now(),
    );

    blocTest<HarvestBloc, HarvestState>(
      'should emit [loading, success] when LoadApiaries event is added',
      build: () {
        when(() => apiaryRepository.getApiaries())
            .thenAnswer((_) async => [testApiary]);
        when(() => hiveRepository.getHivesByApiary(any()))
            .thenAnswer((_) async => [testHive]);
        when(() => entryMetadataRepository.getEntryMetadatas(RaportType.harvest))
            .thenAnswer((_) async => [testEntryMetadata]);
        when(() => raportRepository.getHints(RaportType.harvest))
            .thenAnswer((_) async => {});
        return harvestBloc;
      },
      act: (bloc) => bloc.add(const LoadApiaries()),
      expect: () => [
        isA<HarvestState>().having((s) => s.status, 'status', Status.loading),
        isA<HarvestState>()
            .having((s) => s.status, 'status', Status.success)
            .having((s) => s.apiaries.length, 'apiaries length', 1)
            .having((s) => s.hives.length, 'hives length', 1)
            .having((s) => s.entries.length, 'entries length', 1),
      ],
    );

    blocTest<HarvestBloc, HarvestState>(
      'should update selected apiaries and hives when SelectApiaries event is added',
      build: () {
        when(() => hiveRepository.getHivesByApiary(testApiary))
            .thenAnswer((_) async => [testHive]);
        return harvestBloc;
      },
      act: (bloc) => bloc.add(SelectApiaries([testApiary])),
      expect: () => [
        isA<HarvestState>()
            .having((s) => s.selectedApiaries.length, 'selected apiaries', 1)
            .having((s) => s.hives.length, 'hives', 1)
            .having((s) => s.selectedHives.length, 'selected hives', 1),
      ],
    );

    blocTest<HarvestBloc, HarvestState>(
      'should update selected hives when SelectHives event is added',
      build: () => harvestBloc,
      act: (bloc) => bloc.add(SelectHives([testHive])),
      expect: () => [
        isA<HarvestState>()
            .having((s) => s.selectedHives.length, 'selected hives', 1),
      ],
    );

    blocTest<HarvestBloc, HarvestState>(
      'should add a jar entry when AddJarEntry event is added',
      build: () => harvestBloc,
      act: (bloc) => bloc.add(AddJarEntry(JarSize.jarSizes[1])),
      expect: () => [
        isA<HarvestState>()
            .having((s) => s.entries.length, 'entries length', 1)
            .having((s) => s.entries.first.id, 'entry id', 'jar_0.7l'),
      ],
    );

    blocTest<HarvestBloc, HarvestState>(
      'should create a raport when CreateRaport event is added',
      build: () {
        when(() => raportRepository.insertRaport(any(), any()))
            .thenAnswer((_) async {});
        return harvestBloc;
      },
      seed: () => HarvestState(
        selectedHives: [testHive],
        entries: [testEntryMetadata],
      ),
      act: (bloc) => bloc.add(const CreateRaport(entries: {'honey_type': 'Flower'})),
      verify: (_) {
        verify(() => raportRepository.insertRaport(any(), any())).called(1);
      },
    );

    blocTest<HarvestBloc, HarvestState>(
      'should distribute 14 jars among 3 hives as 5, 5, and 4 respectively',
      build: () {
        when(() => raportRepository.insertRaport(any(), any()))
          .thenAnswer((_) async {});
        return harvestBloc;
      },
      seed: () => HarvestState(
        selectedHives: [testHive1, testHive2, testHive3],
        // Just one jar metadata entry:
        entries: [
          EntryMetadata(
            id: 'jar_0.7l',
            raportType: RaportType.harvest,
            label: '0.7L jars',
            hint: 'Number of 0.7L jars',
            valueType: EntryType.number,
            order: 0,
          ),
        ],
      ),
      act: (bloc) => bloc.add(const CreateRaport(entries: {'jar_0.7l': '14'})),
      verify: (_) {
        final verification = verify(() => raportRepository.insertRaport(any(), captureAny()));
        verification.called(3);
        
        final captured = verification.captured;
        final entries = [
          captured[0] as List<Entry>,
          captured[1] as List<Entry>,
          captured[2] as List<Entry>,
        ];
        
        expect(entries[0][0].value, '5');
        expect(entries[1][0].value, '5');
        expect(entries[2][0].value, '4');
      },
    );

    blocTest<HarvestBloc, HarvestState>(
      'should distribute 2 jars among 3 hives as 1, 1, and 0 respectively',
      build: () {
        when(() => raportRepository.insertRaport(any(), any()))
          .thenAnswer((_) async {});
        return harvestBloc;
      },
      seed: () => HarvestState(
        selectedHives: [testHive1, testHive2, testHive3],
        entries: [
          EntryMetadata(
            id: 'jar_0.7l',
            raportType: RaportType.harvest,
            label: '0.7L jars',
            hint: 'Number of 0.7L jars',
            valueType: EntryType.number,
            order: 0,
          ),
        ],
      ),
      act: (bloc) => bloc.add(const CreateRaport(entries: {'jar_0.7l': '2'})),
      verify: (_) {
        final verification = verify(() => raportRepository.insertRaport(any(), captureAny()));
        verification.called(3);
        
        final captured = verification.captured;
        final entries = [
          captured[0] as List<Entry>,
          captured[1] as List<Entry>,
          captured[2] as List<Entry>,
        ];
        
        expect(entries[0][0].value, '1');
        expect(entries[1][0].value, '1');
        expect(entries[2][0].value, '0');
      },
    );
  });
}
