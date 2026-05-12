import 'package:fork_mate/translations/es_ES.dart';
import 'package:get/get.dart';
import 'en_US.dart';
import 'ar_AE.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS,
    'ar_AE': arAE,
    'es_ES': esES,
  };
}
