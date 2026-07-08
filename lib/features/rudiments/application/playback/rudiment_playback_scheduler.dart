import 'dart:async';

import '../../domain/entities/rudiment_pattern.dart';
import '../../domain/entities/rudiment_playback_event.dart';
import '../../domain/services/rudiment_pattern_timeline.dart';
import '../audio/rudiment_audio_engine.dart';
import '../audio/rudiment_sample_mapper.dart';

class RudimentPlaybackScheduler {
  RudimentPlaybackScheduler({
    required this.audioEngine,
    this.tickInterval = const Duration(milliseconds: 2),
  });

  final RudimentAudioEngine audioEngine;
  final Duration tickInterval;

  final Stopwatch _clock = Stopwatch();
  Timer? _timer;

  List<RudimentPlaybackEvent> _events = const [];
  var _cycleDuration = Duration.zero;
  var _nextEventIndex = 0;
  var _cycleIndex = 0;

  bool get isRunning => _clock.isRunning;

  Future<void> start({
    required RudimentPattern pattern,
    required int bpm,
  }) async {
    stop();

    _events = RudimentPatternTimeline.build(pattern: pattern, bpm: bpm);
    _cycleDuration = RudimentPatternTimeline.cycleDuration(
      pattern: pattern,
      bpm: bpm,
    );
    _nextEventIndex = 0;
    _cycleIndex = 0;

    final samples = _events
        .map((event) => RudimentSampleMapper.fromEvent(event).sample)
        .toSet();

    await audioEngine.preload(samples);

    _clock
      ..reset()
      ..start();
    _timer = Timer.periodic(tickInterval, (_) => _tick());
    _tick();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _clock
      ..stop()
      ..reset();
  }

  Future<void> dispose() async {
    stop();
    await audioEngine.dispose();
  }

  void _tick() {
    if (_events.isEmpty || _cycleDuration == Duration.zero) {
      return;
    }

    final elapsed = _clock.elapsed;
    final cycleMicroseconds = _cycleDuration.inMicroseconds;
    final currentCycleIndex = elapsed.inMicroseconds ~/ cycleMicroseconds;

    if (currentCycleIndex != _cycleIndex) {
      _cycleIndex = currentCycleIndex;
      _nextEventIndex = 0;
    }

    final cyclePosition = Duration(
      microseconds: elapsed.inMicroseconds % cycleMicroseconds,
    );

    while (_nextEventIndex < _events.length &&
        _events[_nextEventIndex].offset <= cyclePosition) {
      final hit = RudimentSampleMapper.fromEvent(_events[_nextEventIndex]);
      unawaited(audioEngine.play(hit));
      _nextEventIndex++;
    }
  }
}
