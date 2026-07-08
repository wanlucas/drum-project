import 'package:flutter/material.dart';
import 'package:app/l10n/app_localizations.dart';

import 'core/theme/app_theme.dart';
import 'features/rudiments/presentation/pages/rudiments_page.dart';

class DrumApp extends StatelessWidget {
  const DrumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt'),
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: AppTheme.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const RudimentsPage(),
    );
  }
}
