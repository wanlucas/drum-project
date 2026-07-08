import 'rudiment_pattern.dart';

class RudimentPlaybackEvent {
  const RudimentPlaybackEvent({
    required this.offset,
    required this.tick,
    required this.hand,
    required this.kind,
    required this.velocity,
  });

  final Duration offset;
  final int tick;
  final Hand hand;
  final StrokeKind kind;
  final double velocity;
}
