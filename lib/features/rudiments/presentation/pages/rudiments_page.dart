import 'package:flutter/material.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/shared/widgets/app_badge.dart';

import '../../domain/entities/rudiment.dart';
import '../../domain/rudiment_catalog.dart';
import 'rudiment_practice_page.dart';

class RudimentsPage extends StatelessWidget {
  const RudimentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final rudiments = RudimentCatalog.all;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.rudimentsTitle),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(child: Text('40')),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        itemCount: rudiments.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final rudiment = rudiments[index];
          return _RudimentTile(
            rudiment: rudiment,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RudimentPracticePage(rudiment: rudiment),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _RudimentTile extends StatelessWidget {
  const _RudimentTile({
    required this.rudiment,
    required this.onTap,
  });

  final Rudiment rudiment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.25)),
                ),
                alignment: Alignment.center,
                child: Text(
                  rudiment.number.toString(),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rudiment.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      rudiment.description,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        AppBadge(label: rudiment.category),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
