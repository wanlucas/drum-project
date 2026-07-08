import 'package:flutter_soloud/flutter_soloud.dart';

import '../../application/audio/rudiment_audio_engine.dart';
import '../../application/audio/rudiment_sample.dart';

class SoloudRudimentAudioEngine implements RudimentAudioEngine {
  SoloudRudimentAudioEngine({
    required Map<RudimentSample, String> assetPaths,
    SoLoud? soloud,
    this.disposeSoloudOnDispose = false,
  })  : _assetPaths = Map.unmodifiable(assetPaths),
        _soloud = soloud ?? SoLoud.instance;

  final Map<RudimentSample, String> _assetPaths;
  final SoLoud _soloud;
  final bool disposeSoloudOnDispose;
  final Map<RudimentSample, AudioSource> _sources = {};

  @override
  Future<void> preload(Set<RudimentSample> samples) async {
    await _ensureInitialized();

    for (final sample in samples) {
      if (_sources.containsKey(sample)) {
        continue;
      }

      final assetPath = _assetPaths[sample];

      if (assetPath == null) {
        throw StateError('Missing asset path for rudiment sample: $sample');
      }

      _sources[sample] = await _soloud.loadAsset(
        assetPath,
        mode: LoadMode.memory,
      );
    }
  }

  @override
  Future<void> play(RudimentAudioHit hit) async {
    await preload({hit.sample});

    final source = _sources[hit.sample];

    if (source == null) {
      throw StateError('Rudiment sample was not loaded: ${hit.sample}');
    }

    _soloud.play(source, volume: hit.velocity);
  }

  @override
  Future<void> dispose() async {
    for (final source in _sources.values) {
      await _soloud.disposeSource(source);
    }

    _sources.clear();

    if (disposeSoloudOnDispose && _soloud.isInitialized) {
      _soloud.deinit();
    }
  }

  Future<void> _ensureInitialized() async {
    if (_soloud.isInitialized) {
      return;
    }

    await _soloud.init();
  }
}
