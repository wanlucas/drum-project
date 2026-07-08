import '../entities/rudiment_pattern.dart';
import '../entities/rudiment_playback_event.dart';

class RudimentPatternTimeline {
  RudimentPatternTimeline._();

  static List<RudimentPlaybackEvent> build({
    required RudimentPattern pattern,
    required int bpm,
  }) {
    assert(bpm > 0);

    final cycleDuration = durationForTicks(
      ticks: pattern.totalTicks,
      ticksPerQuarter: pattern.ticksPerQuarter,
      bpm: bpm,
    );

    final events = <RudimentPlaybackEvent>[];

    for (final group in pattern.groups) {
      final groupOffset = durationForTicks(
        ticks: group.tick,
        ticksPerQuarter: pattern.ticksPerQuarter,
        bpm: bpm,
      );

      for (final note in group.notes) {
        final noteOffset = groupOffset - _graceOffset(note, bpm);
        final normalizedOffset = _normalizeOffset(noteOffset, cycleDuration);

        events.add(
          RudimentPlaybackEvent(
            offset: normalizedOffset,
            tick: group.tick,
            hand: note.hand,
            kind: note.kind,
            velocity: note.velocity,
          ),
        );
      }
    }

    events.sort((a, b) => a.offset.compareTo(b.offset));
    return events;
  }

  static Duration cycleDuration({
    required RudimentPattern pattern,
    required int bpm,
  }) {
    assert(bpm > 0);

    return durationForTicks(
      ticks: pattern.totalTicks,
      ticksPerQuarter: pattern.ticksPerQuarter,
      bpm: bpm,
    );
  }

  static Duration durationForTicks({
    required int ticks,
    required int ticksPerQuarter,
    required int bpm,
  }) {
    assert(ticks >= 0);
    assert(ticksPerQuarter > 0);
    assert(bpm > 0);

    final microsecondsPerQuarter =
        Duration.microsecondsPerSecond * Duration.secondsPerMinute ~/ bpm;
    final microseconds = microsecondsPerQuarter * ticks / ticksPerQuarter;

    return Duration(microseconds: microseconds.round());
  }

  static Duration _graceOffset(StrokeNote note, int bpm) {
    final graceTiming = note.graceTiming;

    if (graceTiming == null) {
      return Duration.zero;
    }

    final microsecondsPerQuarter =
        Duration.microsecondsPerSecond * Duration.secondsPerMinute ~/ bpm;
    final proportionalOffset = Duration(
      microseconds: (microsecondsPerQuarter * graceTiming.beatFraction).round(),
    );

    if (proportionalOffset < graceTiming.minOffset) {
      return graceTiming.minOffset;
    }

    if (proportionalOffset > graceTiming.maxOffset) {
      return graceTiming.maxOffset;
    }

    return proportionalOffset;
  }

  static Duration _normalizeOffset(Duration offset, Duration cycleDuration) {
    if (offset >= Duration.zero && offset < cycleDuration) {
      return offset;
    }

    final cycleMicroseconds = cycleDuration.inMicroseconds;
    final normalizedMicroseconds = offset.inMicroseconds % cycleMicroseconds;

    return Duration(microseconds: normalizedMicroseconds);
  }
}
