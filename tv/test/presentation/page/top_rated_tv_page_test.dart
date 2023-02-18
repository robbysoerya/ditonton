import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_page_test.mocks.dart';

@GenerateMocks([TopRatedTVBloc])
void main() {
  late MockTopRatedTVBloc mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedTVBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTVBloc>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(TopRatedTVLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(const TopRatedTVSuccess(<TV>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(const TopRatedTVError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedTVPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('should return TV Card when Request State is Loaded',
      (tester) async {
    when(mockNotifier.stream).thenAnswer((_) => Stream.fromIterable([]));
    when(mockNotifier.state).thenReturn(TopRatedTVSuccess([testTV]));

    await tester.pumpWidget(makeTestableWidget(const TopRatedTVPage()));

    expect(find.byType(TVCard), findsOneWidget);
  });
}
