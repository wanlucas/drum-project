import 'dart:async';

import 'package:flutter/material.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/core/utils/duration_formatter.dart';
import 'package:app/shared/widgets/app_badge.dart';

import '../../application/playback/rudiment_playback_scheduler.dart';
import '../../domain/entities/rudiment.dart';
import '../../domain/services/rudiment_pattern_timeline.dart';
import '../../infrastructure/audio/rudiment_sample_assets.dart';
import '../../infrastructure/audio/soloud_rudiment_audio_engine.dart';
import '../widgets/rudiment_pattern_view.dart';
import '../widgets/rudiment_timeline_preview.dart';

class RudimentPracticePage extends StatefulWidget {
  const RudimentPracticePage({super.key, required this.rudiment});

  final Rudiment rudiment;

  @override
  State<RudimentPracticePage> createState() => _RudimentPracticePageState();
}

class _RudimentPracticePageState extends State<RudimentPracticePage> {
  final Stopwatch _stopwatch = Stopwatch();
  final RudimentPlaybackScheduler _playbackScheduler =
      RudimentPlaybackScheduler(
    audioEngine: SoloudRudimentAudioEngine(
      assetPaths: RudimentSampleAssets.allSamples,
    ),
  );
  Timer? _ticker;
  int _bpm = 80;

  bool get _isRunning => _stopwatch.isRunning;
  Duration get _elapsed => _stopwatch.elapsed;

  @override
  void dispose() {
    _ticker?.cancel();
    unawaited(_playbackScheduler.dispose());
    super.dispose();
  }

  Future<void> _togglePractice() async {
    if (_isRunning) {
      _stopwatch.stop();
      _playbackScheduler.stop();
      _ticker?.cancel();
      _ticker = null;
      setState(() {});
      return;
    }

    await _startPlaybackScheduler();
    if (!mounted) return;

    _stopwatch.start();
    _ticker ??= Timer.periodic(const Duration(milliseconds: 33), (_) {
      if (!mounted) return;
      setState(() {});
    });
    setState(() {});
  }

  void _resetPractice() {
    _stopwatch
      ..stop()
      ..reset();
    _playbackScheduler.stop();
    _ticker?.cancel();
    _ticker = null;
    setState(() {});
  }

  Future<void> _startPlaybackScheduler() async {
    final pattern = widget.rudiment.pattern;

    if (pattern == null) {
      return;
    }

    await _playbackScheduler.start(pattern: pattern, bpm: _bpm);
  }

  void _updateBpm(double value) {
    setState(() {
      _bpm = value.round();
    });

    if (_isRunning) {
      unawaited(_startPlaybackScheduler());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final pattern = widget.rudiment.pattern;
    final playbackPosition = pattern == null
        ? null
        : RudimentPatternTimeline.cyclePosition(
            pattern: pattern,
            bpm: _bpm,
            elapsed: _elapsed,
          );
    final statusLabel = _isRunning
        ? l.practiceRunning
        : (_elapsed == Duration.zero ? l.practiceReady : l.practicePaused);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rudiment.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.practiceRudimentTitle(widget.rudiment.number),
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  AppBadge(
                    label: '${l.categoryLabel}: ${widget.rudiment.category}',
                  ),
                  AppBadge(label: statusLabel),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.rudiment.description,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Text(
                l.rudimentPatternTitle,
                style: theme.textTheme.labelLarge,
              ),
              const SizedBox(height: 12),
              RudimentPatternView(
                pattern: widget.rudiment.pattern,
                emptyLabel: l.rudimentPatternUnavailable,
              ),
              const SizedBox(height: 24),
              Text(
                '${l.bpmLabel}: $_bpm',
                style: theme.textTheme.labelLarge,
              ),
              Slider(
                min: 40,
                max: 240,
                divisions: 200,
                value: _bpm.toDouble(),
                label: _bpm.toString(),
                onChanged: _updateBpm,
              ),
              if (pattern != null) ...[
                const SizedBox(height: 12),
                Text(
                  l.timelinePreviewTitle,
                  style: theme.textTheme.labelLarge,
                ),
                const SizedBox(height: 12),
                RudimentTimelinePreview(
                  pattern: pattern,
                  bpm: _bpm,
                  playbackPosition: playbackPosition,
                ),
              ],
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.practiceTimeLabel,
                        style: theme.textTheme.labelLarge,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        formatClockDuration(_elapsed),
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () {
                                unawaited(_togglePractice());
                              },
                              icon: Icon(
                                _isRunning
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                              ),
                              label: Text(
                                _isRunning
                                    ? l.pausePractice
                                    : l.startPractice,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton.icon(
                            onPressed:
                                _elapsed == Duration.zero ? null : _resetPractice,
                            icon: const Icon(Icons.restart_alt_rounded),
                            label: Text(l.resetPractice),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
