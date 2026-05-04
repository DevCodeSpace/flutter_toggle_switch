import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_toggle_switch/flutter_toggle_switch.dart';

void main() {
  testWidgets('renders aurora track and liquid pill styles', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: FlutterToggle(
              totalSwitches: 3,
              labels: ['Auto', 'Manual', 'Eco'],
              initialLabelIndex: 1,
              animate: true,
              slidingPill: true,
              decorationStyle: ToggleDecorationStyle.aurora,
              pillStyle: TogglePillStyle.liquid,
              activeBgColor: [Color(0xFF14B8A6), Color(0xFF6366F1)],
            ),
          ),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 120));

    expect(find.text('Auto'), findsOneWidget);
    expect(find.text('Manual'), findsOneWidget);
    expect(find.text('Eco'), findsOneWidget);
  });

  testWidgets('keyboard navigation skips disabled options', (tester) async {
    final focusNode = FocusNode();
    final semantics = tester.ensureSemantics();
    addTearDown(focusNode.dispose);

    int? selected;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: FlutterToggle(
              focusNode: focusNode,
              totalSwitches: 3,
              labels: const ['One', 'Two', 'Three'],
              semanticLabels: const [
                'First option',
                'Second option',
                'Third option',
              ],
              states: const [true, false, true],
              initialLabelIndex: 0,
              animate: false,
              slidingPill: true,
              decorationStyle: ToggleDecorationStyle.tonal,
              pillStyle: TogglePillStyle.soft,
              onToggle: (index) => selected = index,
            ),
          ),
        ),
      ),
    );

    focusNode.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();

    expect(selected, 2);
    expect(find.bySemanticsLabel(RegExp('Third option')), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('new binary switch components render with semantics and toggle', (
    tester,
  ) async {
    bool prism = true;
    bool orbit = false;
    bool wave = true;
    bool flip = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PrismToggleSwitch(
                      value: prism,
                      semanticLabel: 'Prism switch',
                      onChanged: (value) => setState(() => prism = value),
                    ),
                    OrbitToggleSwitch(
                      value: orbit,
                      semanticLabel: 'Orbit switch',
                      onChanged: (value) => setState(() => orbit = value),
                    ),
                    WaveToggleSwitch(
                      value: wave,
                      semanticLabel: 'Wave switch',
                      onChanged: (value) => setState(() => wave = value),
                    ),
                    FlipCardToggleSwitch(
                      value: flip,
                      semanticLabel: 'Flip switch',
                      onChanged: (value) => setState(() => flip = value),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );

    expect(find.bySemanticsLabel('Prism switch'), findsOneWidget);
    expect(find.bySemanticsLabel('Orbit switch'), findsOneWidget);
    expect(find.bySemanticsLabel('Wave switch'), findsOneWidget);
    expect(find.bySemanticsLabel('Flip switch'), findsOneWidget);

    await tester.tap(find.byType(PrismToggleSwitch));
    await tester.tap(find.byType(OrbitToggleSwitch));
    await tester.tap(find.byType(WaveToggleSwitch));
    await tester.tap(find.byType(FlipCardToggleSwitch));
    await tester.pumpAndSettle();

    expect(prism, isFalse);
    expect(orbit, isTrue);
    expect(wave, isFalse);
    expect(flip, isTrue);
  });

  testWidgets('newly added binary switches render with semantics and toggle', (
    tester,
  ) async {
    bool pulse = true;
    bool dayNight = false;
    bool power = true;
    bool segment = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PulseToggleSwitch(
                      value: pulse,
                      semanticLabel: 'Pulse switch',
                      onChanged: (value) => setState(() => pulse = value),
                    ),
                    DayNightToggleSwitch(
                      value: dayNight,
                      semanticLabel: 'Day night switch',
                      onChanged: (value) => setState(() => dayNight = value),
                    ),
                    PowerToggleSwitch(
                      value: power,
                      semanticLabel: 'Power switch',
                      onChanged: (value) => setState(() => power = value),
                    ),
                    SegmentBarToggleSwitch(
                      value: segment,
                      semanticLabel: 'Segment switch',
                      onChanged: (value) => setState(() => segment = value),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 80));

    expect(find.bySemanticsLabel('Pulse switch'), findsOneWidget);
    expect(find.bySemanticsLabel('Day night switch'), findsOneWidget);
    expect(find.bySemanticsLabel('Power switch'), findsOneWidget);
    expect(find.bySemanticsLabel('Segment switch'), findsOneWidget);

    await tester.tap(find.byType(PulseToggleSwitch));
    await tester.tap(find.byType(DayNightToggleSwitch));
    await tester.tap(find.byType(PowerToggleSwitch));
    await tester.tap(find.byType(SegmentBarToggleSwitch));
    await tester.pump(const Duration(milliseconds: 500));

    expect(pulse, isFalse);
    expect(dayNight, isTrue);
    expect(power, isFalse);
    expect(segment, isTrue);
  });

  testWidgets('new tab components select tabs and fire callbacks', (
    tester,
  ) async {
    int underline = 0;
    int cards = 0;
    int blob = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UnderlineTabBar(
                      tabs: const ['One', 'Two', 'Three'],
                      semanticLabels: const ['One tab', 'Two tab', 'Three tab'],
                      selectedIndex: underline,
                      onChanged: (i) => setState(() => underline = i),
                    ),
                    const SizedBox(height: 12),
                    StackedCardsTabBar(
                      tabs: const ['Alpha', 'Beta', 'Gamma'],
                      semanticLabels: const [
                        'Alpha tab',
                        'Beta tab',
                        'Gamma tab',
                      ],
                      selectedIndex: cards,
                      onChanged: (i) => setState(() => cards = i),
                    ),
                    const SizedBox(height: 12),
                    MagneticBlobTabBar(
                      tabs: const ['Red', 'Green', 'Blue'],
                      semanticLabels: const [
                        'Red tab',
                        'Green tab',
                        'Blue tab',
                      ],
                      selectedIndex: blob,
                      onChanged: (i) => setState(() => blob = i),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 80));

    expect(find.text('Two'), findsOneWidget);
    expect(find.text('Beta'), findsOneWidget);
    expect(find.text('Green'), findsOneWidget);

    await tester.tap(find.text('Three'));
    await tester.tap(find.text('Gamma'));
    await tester.tap(find.text('Blue'));
    await tester.pumpAndSettle();

    expect(underline, 2);
    expect(cards, 2);
    expect(blob, 2);
  });
}
