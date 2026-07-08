import 'package:flutter/material.dart';

import '../../domain/entities/rudiment.dart';

class RudimentPracticePage extends StatelessWidget {
  const RudimentPracticePage({super.key, required this.rudiment});

  final Rudiment rudiment;

  @override
  Widget build(BuildContext context) {
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
              'Prática do rudimento ${rudiment.number}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              'Aqui depois vamos colocar o play/pause, o metrônomo e o cronômetro de prática.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
