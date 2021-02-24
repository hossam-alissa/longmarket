import 'package:shared_preferences/shared_preferences.dart';

bool isLeft = false;

setLanguage ()async{
  SharedPreferences preferencesLanguage = await SharedPreferences.getInstance();
  isLeft = !isLeft;
  print(isLeft);
  preferencesLanguage.setBool("language", isLeft);
  print(preferencesLanguage.getBool("language").toString());
  print(isLeft);
}
getLanguage()async{
  SharedPreferences preferencesLanguage = await SharedPreferences.getInstance();

  if(preferencesLanguage.getBool("language") != null){
    isLeft = preferencesLanguage.getBool("language");
  }
}