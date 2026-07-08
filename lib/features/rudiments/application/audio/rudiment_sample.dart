enum RudimentSample {
  rightTap,
  leftTap,
  rightAccent,
  leftAccent,
  rightGhost,
  leftGhost,
  rightFlamGrace,
  leftFlamGrace,
  rightDragGrace,
  leftDragGrace,
}

class RudimentAudioHit {
  const RudimentAudioHit({
    required this.sample,
    required this.velocity,
  }) : assert(velocity >= 0 && velocity <= 1);

  final RudimentSample sample;
  final double velocity;
}
