import 'package:shared_preferences/shared_preferences.dart';

bool isLeft = false;

setLanguage() async {
  try {
    SharedPreferences preferencesLanguage = await SharedPreferences.getInstance();
    await preferencesLanguage.setBool("language", isLeft);
    print("+++ +++ Done lib-config-language---setLanguage");
  } catch (e) {
    print("+++ +++ Error lib-config-language---setLanguage");
    print(e);
  }
}

getLanguage() async {
  try {
    SharedPreferences preferencesLanguage = await SharedPreferences.getInstance();
    if (await preferencesLanguage.getBool("language") != null) {
      isLeft = await preferencesLanguage.getBool("language");
    }
    print("+++ +++ Done lib-config-language---getLanguage");
  } catch (e) {
    print("+++ +++ Error lib-config-language---getLanguage");
    print(e);
  }
}
