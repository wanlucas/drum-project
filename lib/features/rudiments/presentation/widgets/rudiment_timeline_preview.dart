import 'package:flutter/material.dart';

import '../../domain/entities/rudiment_pattern.dart';
import '../../domain/entities/rudiment_playback_event.dart';
import '../../domain/services/rudiment_pattern_timeline.dart';

class RudimentTimelinePreview extends StatelessWidget {
  const RudimentTimelinePreview({
    super.key,
    required this.pattern,
    required this.bpm,
    this.playbackPosition,
  });

  final RudimentPattern pattern;
  final int bpm;
  final Duration? playbackPosition;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final events = RudimentPatternTimeline.build(pattern: pattern, bpm: bpm);
    final cycleDuration = RudimentPatternTimeline.cycleDuration(
      pattern: pattern,
      bpm: bpm,
    );
    final activeEventIndex = _activeEventIndex(events, playbackPosition);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _cycleLabel(cycleDuration, playbackPosition),
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var index = 0; index < events.length; index++)
              _TimelineEventChip(
                event: events[index],
                isActive: index == activeEventIndex,
              ),
          ],
        ),
      ],
    );
  }

  int? _activeEventIndex(
    List<RudimentPlaybackEvent> events,
    Duration? playbackPosition,
  ) {
    if (playbackPosition == null || events.isEmpty) {
      return null;
    }

    var activeIndex = events.length - 1;

    for (var index = 0; index < events.length; index++) {
      if (events[index].offset <= playbackPosition) {
        activeIndex = index;
      } else {
        break;
      }
    }

    return activeIndex;
  }

  String _cycleLabel(Duration cycleDuration, Duration? playbackPosition) {
    final cycle = 'Ciclo: ${cycleDuration.inMilliseconds} ms';

    if (playbackPosition == null) {
      return cycle;
    }

    return '$cycle | Posição: ${playbackPosition.inMilliseconds} ms';
  }
}

class _TimelineEventChip extends StatelessWidget {
  const _TimelineEventChip({
    required this.event,
    required this.isActive,
  });

  final RudimentPlaybackEvent event;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isActive
            ? theme.colorScheme.primary.withValues(alpha: 0.2)
            : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive
              ? theme.colorScheme.primary
              : theme.colorScheme.outline.withValues(alpha: 0.35),
        ),
      ),
      child: Text(
        '${event.offset.inMilliseconds}ms ${_handLabel(event)} ${_kindLabel(event.kind)}',
        style: theme.textTheme.labelSmall?.copyWith(
          color: isActive ? theme.colorScheme.primary : theme.colorScheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  String _handLabel(RudimentPlaybackEvent event) {
    return event.hand == Hand.right ? 'R' : 'L';
  }

  String _kindLabel(StrokeKind kind) {
    return switch (kind) {
      StrokeKind.tap => 'tap',
      StrokeKind.accent => 'accent',
      StrokeKind.ghost => 'ghost',
      StrokeKind.flamGrace => 'flam',
      StrokeKind.dragGrace => 'drag',
    };
  }
}
