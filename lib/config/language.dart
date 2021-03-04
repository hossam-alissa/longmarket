import 'package:shared_preferences/shared_preferences.dart';

bool isLeft = false;

setLanguage ()async{
  SharedPreferences preferencesLanguage = await SharedPreferences.getInstance();
  await preferencesLanguage.setBool("language", isLeft);

}
getLanguage()async{
  SharedPreferences preferencesLanguage = await SharedPreferences.getInstance();

  if(await preferencesLanguage.getBool("language") != null){
    isLeft = await preferencesLanguage.getBool("language");
  }
}