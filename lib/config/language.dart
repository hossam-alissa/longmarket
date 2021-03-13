import 'package:shared_preferences/shared_preferences.dart';

bool isLeft = false;

setLanguage() async {
  SharedPreferences preferencesLanguage = await SharedPreferences.getInstance();
  await preferencesLanguage.setBool("language", isLeft);
}

getLanguage() async {
  SharedPreferences preferencesLanguage = await SharedPreferences.getInstance();
  try {
    if (await preferencesLanguage.getBool("language") != null) {
      isLeft = await preferencesLanguage.getBool("language");
    }
    print("+++ +++ Done lib-config-language-getLanguage");
  } catch (e) {
    print("+++ +++ Error lib-config-language-getLanguage");
    print(e);
  }
}
