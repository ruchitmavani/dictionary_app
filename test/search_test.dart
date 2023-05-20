import 'package:dictionary_app/controllers/search_controller.dart';
import 'package:dictionary_app/models/found_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNewService extends Mock implements SearchProvider {}

void main() {
  late SearchProvider sut;
  late MockNewService mockNewService;

  setUp(() {
    mockNewService = MockNewService();
    sut = SearchProvider();
  });

  test("initial values are correct", () async {
    expect(SearchProvider().isFound, false);
    expect(SearchProvider().isLoading, false);
    expect(SearchProvider().isSearched, false);
  });

  group("search function", () {
    test(
      "search using service",
      () async {
        when(
          () => mockNewService.search("hello"),
        ).thenAnswer((_) async => FoundModel(
            word: "hello",
            phonetics: [],
            meanings: [],
            license: License(name: "", url: ""),
            sourceUrls: []));
        await sut.search("hello");
        verify(
          () => mockNewService.search("hello"),
        ).called(1);
      },
    );
  });
}
