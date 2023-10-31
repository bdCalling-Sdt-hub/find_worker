import 'package:find_worker/view/screens/change_language/arabic.dart';
import 'package:find_worker/view/screens/change_language/english.dart';
import 'package:get/get.dart';

class Language extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    "en_US":english,
     "ar_AE":arabic,
  };

}