import '../../domain/entities/rudiment_pattern.dart';
import '../../domain/entities/rudiment_playback_event.dart';
import 'rudiment_sample.dart';

class RudimentSampleMapper {
  RudimentSampleMapper._();

  static RudimentAudioHit fromEvent(RudimentPlaybackEvent event) {
    return RudimentAudioHit(
      sample: _sampleFor(event.hand, event.kind),
      velocity: event.velocity,
    );
  }

  static RudimentSample _sampleFor(Hand hand, StrokeKind kind) {
    return switch ((hand, kind)) {
      (Hand.right, StrokeKind.tap) => RudimentSample.rightTap,
      (Hand.left, StrokeKind.tap) => RudimentSample.leftTap,
      (Hand.right, StrokeKind.accent) => RudimentSample.rightAccent,
      (Hand.left, StrokeKind.accent) => RudimentSample.leftAccent,
      (Hand.right, StrokeKind.ghost) => RudimentSample.rightGhost,
      (Hand.left, StrokeKind.ghost) => RudimentSample.leftGhost,
      (Hand.right, StrokeKind.flamGrace) => RudimentSample.rightFlamGrace,
      (Hand.left, StrokeKind.flamGrace) => RudimentSample.leftFlamGrace,
      (Hand.right, StrokeKind.dragGrace) => RudimentSample.rightDragGrace,
      (Hand.left, StrokeKind.dragGrace) => RudimentSample.leftDragGrace,
    };
  }
}
