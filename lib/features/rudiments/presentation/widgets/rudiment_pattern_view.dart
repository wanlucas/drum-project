import 'package:flutter/material.dart';

import '../../domain/entities/rudiment_pattern.dart';

class RudimentPatternView extends StatelessWidget {
  const RudimentPatternView({
    super.key,
    required this.pattern,
    required this.emptyLabel,
  });

  final RudimentPattern? pattern;
  final String emptyLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pattern = this.pattern;

    if (pattern == null) {
      return Text(
        emptyLabel,
        style: theme.textTheme.bodyMedium,
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final group in pattern.groups) ...[
            _StrokeGroupToken(group: group),
            const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }
}

class _StrokeGroupToken extends StatelessWidget {
  const _StrokeGroupToken({required this.group});

  final StrokeGroup group;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final note in group.notes) ...[
          _StrokeNoteToken(note: note),
          const SizedBox(width: 4),
        ],
      ],
    );
  }
}

class _StrokeNoteToken extends StatelessWidget {
  const _StrokeNoteToken({required this.note});

  final StrokeNote note;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSmallNote = note.isGrace || note.kind == StrokeKind.ghost;
    final size = isSmallNote ? 28.0 : 42.0;
    final backgroundColor = note.kind == StrokeKind.accent
        ? theme.colorScheme.primary.withValues(alpha: 0.18)
        : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6);
    final borderColor = note.kind == StrokeKind.accent
        ? theme.colorScheme.primary
        : theme.colorScheme.outline.withValues(alpha: 0.45);

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        _noteLabel(note),
        style: theme.textTheme.labelLarge?.copyWith(
          color: note.kind == StrokeKind.accent
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface,
          fontSize: isSmallNote ? 12 : 16,
          fontWeight: note.kind == StrokeKind.accent ? FontWeight.w800 : FontWeight.w700,
        ),
      ),
    );
  }

  String _noteLabel(StrokeNote note) {
    final label = note.hand == Hand.right ? 'R' : 'L';

    if (note.kind == StrokeKind.ghost || note.isGrace) {
      return label.toLowerCase();
    }

    return label;
  }
}
