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
  String get practiceTimeLabel => 'Tempo de pratica';

  @override
  String get practiceReady => 'Pronto para praticar';

  @override
  String get practiceRunning => 'Praticando agora';

  @override
  String get practicePaused => 'Pratica pausada';

  @override
  String get startPractice => 'Iniciar';

  @override
  String get pausePractice => 'Pausar';

  @override
  String get resetPractice => 'Zerar';

  @override
  String get rudimentPatternTitle => 'Sequência';

  @override
  String get rudimentPatternUnavailable =>
      'Sequência ainda não cadastrada para este rudimento.';

  @override
  String get bpmLabel => 'BPM';

  @override
  String get timelinePreviewTitle => 'Eventos calculados';
}
