enum Hand {
  right,
  left,
}

enum StrokeKind {
  tap,
  accent,
  ghost,
  flamGrace,
  dragGrace,
}

class GraceTiming {
  const GraceTiming({
    required this.beatFraction,
    required this.minOffset,
    required this.maxOffset,
  });

  final double beatFraction;
  final Duration minOffset;
  final Duration maxOffset;
}

class GraceTimings {
  GraceTimings._();

  static const flam = GraceTiming(
    beatFraction: 1 / 32,
    minOffset: Duration(milliseconds: 18),
    maxOffset: Duration(milliseconds: 55),
  );

  static const dragFirst = GraceTiming(
    beatFraction: 1 / 20,
    minOffset: Duration(milliseconds: 28),
    maxOffset: Duration(milliseconds: 75),
  );

  static const dragSecond = GraceTiming(
    beatFraction: 1 / 40,
    minOffset: Duration(milliseconds: 16),
    maxOffset: Duration(milliseconds: 45),
  );
}

class StrokeNote {
  const StrokeNote({
    required this.hand,
    required this.kind,
    this.velocity = 1,
    this.graceTiming,
  }) : assert(velocity >= 0 && velocity <= 1);

  final Hand hand;
  final StrokeKind kind;
  final double velocity;
  final GraceTiming? graceTiming;

  bool get isGrace =>
      kind == StrokeKind.flamGrace || kind == StrokeKind.dragGrace;
}

class StrokeGroup {
  const StrokeGroup({
    required this.tick,
    required this.notes,
  })  : assert(tick >= 0),
        assert(notes.length > 0);

  final int tick;
  final List<StrokeNote> notes;
}

class RudimentPattern {
  const RudimentPattern({
    required this.ticksPerQuarter,
    required this.beats,
    required this.groups,
  })  : assert(ticksPerQuarter > 0),
        assert(beats > 0);

  final int ticksPerQuarter;
  final int beats;
  final List<StrokeGroup> groups;

  int get totalTicks => ticksPerQuarter * beats;
}
