import 'rudiment_audio_engine.dart';
import 'rudiment_sample.dart';

class NoOpRudimentAudioEngine implements RudimentAudioEngine {
  const NoOpRudimentAudioEngine();

  @override
  Future<void> preload(Set<RudimentSample> samples) async {}

  @override
  Future<void> play(RudimentAudioHit hit) async {}

  @override
  Future<void> dispose() async {}
}
