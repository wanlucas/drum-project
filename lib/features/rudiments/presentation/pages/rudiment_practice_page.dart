import 'package:flutter/material.dart';
import 'package:app/l10n/app_localizations.dart';

import '../../domain/entities/rudiment.dart';

class RudimentPracticePage extends StatelessWidget {
  const RudimentPracticePage({super.key, required this.rudiment});

  final Rudiment rudiment;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(rudiment.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.practiceRudimentTitle(rudiment.number),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              '${l.categoryLabel}: ${rudiment.category}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Text(
              rudiment.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Text(
              l.practicePlaceholder,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
