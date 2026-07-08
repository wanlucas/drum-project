import 'rudiment_sample.dart';

abstract class RudimentAudioEngine {
  Future<void> preload(Set<RudimentSample> samples);

  Future<void> play(RudimentAudioHit hit);

  Future<void> dispose();
}
