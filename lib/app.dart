import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/rudiments/presentation/pages/rudiments_page.dart';

class DrumApp extends StatelessWidget {
  const DrumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drum Project',
      theme: AppTheme.dark(),
      home: const RudimentsPage(),
    );
  }
}
