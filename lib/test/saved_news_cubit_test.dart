import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weathernews_app/cubit/saved_news_cubit.dart';
import 'package:weathernews_app/models/saved_news_model.dart';
import 'package:weathernews_app/services/database_service.dart';

class MockDatabaseService extends Mock implements DatabaseService {}

void main() {
  late SavedNewsCubit savedNewsCubit;
  late MockDatabaseService mockDatabaseService;

  setUp(() {
    mockDatabaseService = MockDatabaseService();
    savedNewsCubit = SavedNewsCubit(mockDatabaseService);
  });

  tearDown(() {
    savedNewsCubit.close();
  });

  final testNews = SavedNewsModel(
    id: 1,
    title: 'Test Title',
    description: 'Test Description',
    url: 'https://example.com',
    urlToImage: 'https://example.com/image.jpg',
    publishedAt: DateTime.parse('2023-01-01'),
  );

  blocTest<SavedNewsCubit, SavedNewsState>(
    'emits [SavedNewsState.loading, SavedNewsState.loaded] when loadSavedNews is called',
    build: () {
      when(() => mockDatabaseService.getSavedNews())
          .thenAnswer((_) async => [testNews]);
      return savedNewsCubit;
    },
    act: (cubit) => cubit.loadSavedNews(),
    expect: () => [
      const SavedNewsState.loading(),
      SavedNewsState.loaded([testNews]),
    ],
  );

  blocTest<SavedNewsCubit, SavedNewsState>(
    'emits [SavedNewsState.loading, SavedNewsState.error] when loadSavedNews fails',
    build: () {
      when(() => mockDatabaseService.getSavedNews()).thenThrow(Exception('Failed to load news'));
      return savedNewsCubit;
    },
    act: (cubit) => cubit.loadSavedNews(),
    expect: () => [
      const SavedNewsState.loading(),
      const SavedNewsState.error('Exception: Failed to load news'),
    ],
  );

  blocTest<SavedNewsCubit, SavedNewsState>(
    'calls insertNews and loadSavedNews when saveNews is called',
    build: () {
      when(() => mockDatabaseService.insertNews(testNews))
          .thenAnswer((_) async => {});
      when(() => mockDatabaseService.getSavedNews())
          .thenAnswer((_) async => [testNews]);
      return savedNewsCubit;
    },
    act: (cubit) => cubit.saveNews(testNews),
    verify: (_) {
      verify(() => mockDatabaseService.insertNews(testNews)).called(1);
      verify(() => mockDatabaseService.getSavedNews()).called(1);
    },
  );

  blocTest<SavedNewsCubit, SavedNewsState>(
    'calls deleteNews and loadSavedNews when deleteNews is called',
    build: () {
      when(() => mockDatabaseService.deleteNews(1))
          .thenAnswer((_) async => {});
      when(() => mockDatabaseService.getSavedNews())
          .thenAnswer((_) async => []);
      return savedNewsCubit;
    },
    act: (cubit) => cubit.deleteNews(1),
    verify: (_) {
      verify(() => mockDatabaseService.deleteNews(1)).called(1);
      verify(() => mockDatabaseService.getSavedNews()).called(1);
    },
  );
}