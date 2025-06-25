// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Contador de Pontos de Basquete';

  @override
  String get team1 => 'Time 1';

  @override
  String get team2 => 'Time 2';

  @override
  String get freeThrow => 'Lance Livre (+1)';

  @override
  String get twoPoints => '2 Pontos (+2)';

  @override
  String get threePoints => '3 Pontos (+3)';

  @override
  String get undoLastShot => 'Voltar Último Lance';

  @override
  String get score => 'Placar';
}
