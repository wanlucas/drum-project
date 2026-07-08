// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Projeto de Bateria';

  @override
  String get rudimentsTitle => 'Rudimentos';

  @override
  String practiceRudimentTitle(int number) {
    return 'Prática do rudimento $number';
  }

  @override
  String get categoryLabel => 'Categoria';

  @override
  String get practicePlaceholder =>
      'Aqui depois vamos colocar o play/pause, o metrônomo e o cronômetro de prática.';
}
