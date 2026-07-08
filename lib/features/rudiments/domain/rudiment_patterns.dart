import 'entities/rudiment_pattern.dart';

class RudimentPatterns {
  RudimentPatterns._();

  static const ticksPerQuarter = 480;
  static const sixteenthNote = ticksPerQuarter ~/ 4;

  static const singleStrokeRoll = RudimentPattern(
    ticksPerQuarter: ticksPerQuarter,
    beats: 1,
    groups: [
      StrokeGroup(
        tick: 0,
        notes: [
          StrokeNote(hand: Hand.right, kind: StrokeKind.tap),
        ],
      ),
      StrokeGroup(
        tick: sixteenthNote,
        notes: [
          StrokeNote(hand: Hand.left, kind: StrokeKind.tap),
        ],
      ),
      StrokeGroup(
        tick: sixteenthNote * 2,
        notes: [
          StrokeNote(hand: Hand.right, kind: StrokeKind.tap),
        ],
      ),
      StrokeGroup(
        tick: sixteenthNote * 3,
        notes: [
          StrokeNote(hand: Hand.left, kind: StrokeKind.tap),
        ],
      ),
    ],
  );

  static const flam = RudimentPattern(
    ticksPerQuarter: ticksPerQuarter,
    beats: 2,
    groups: [
      StrokeGroup(
        tick: 0,
        notes: [
          StrokeNote(
            hand: Hand.left,
            kind: StrokeKind.flamGrace,
            velocity: 0.35,
            graceTiming: GraceTimings.flam,
          ),
          StrokeNote(hand: Hand.right, kind: StrokeKind.accent),
        ],
      ),
      StrokeGroup(
        tick: ticksPerQuarter,
        notes: [
          StrokeNote(
            hand: Hand.right,
            kind: StrokeKind.flamGrace,
            velocity: 0.35,
            graceTiming: GraceTimings.flam,
          ),
          StrokeNote(hand: Hand.left, kind: StrokeKind.accent),
        ],
      ),
    ],
  );

  static const drag = RudimentPattern(
    ticksPerQuarter: ticksPerQuarter,
    beats: 2,
    groups: [
      StrokeGroup(
        tick: 0,
        notes: [
          StrokeNote(
            hand: Hand.left,
            kind: StrokeKind.dragGrace,
            velocity: 0.3,
            graceTiming: GraceTimings.dragFirst,
          ),
          StrokeNote(
            hand: Hand.left,
            kind: StrokeKind.dragGrace,
            velocity: 0.3,
            graceTiming: GraceTimings.dragSecond,
          ),
          StrokeNote(hand: Hand.right, kind: StrokeKind.accent),
        ],
      ),
      StrokeGroup(
        tick: ticksPerQuarter,
        notes: [
          StrokeNote(
            hand: Hand.right,
            kind: StrokeKind.dragGrace,
            velocity: 0.3,
            graceTiming: GraceTimings.dragFirst,
          ),
          StrokeNote(
            hand: Hand.right,
            kind: StrokeKind.dragGrace,
            velocity: 0.3,
            graceTiming: GraceTimings.dragSecond,
          ),
          StrokeNote(hand: Hand.left, kind: StrokeKind.accent),
        ],
      ),
    ],
  );
}
