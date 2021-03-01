import '../config/config.dart';

String errorExceptionFireBase (String errorException){
  if(errorException == "[firebase_auth/email-already-in-use] The email address is already in use by another account.")
    return isLeft ? "The email address is already in use by another account" : "يرجى تغير البريد الإلكتروني. البريد الإلكتروني مسجل في حساب آخر";
  else if(errorException == "[firebase_auth/invalid-email] The email address is badly formatted.")
    return isLeft ? "The email address is badly formatted." : "تأكد من  صيغة كتابة بريدك الإلكتروني. البريد الإلكتروني غير صحيح";
  else if(errorException == "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.")
   return  isLeft ? "There is no user record corresponding to this identifier. The user may have been deleted." : "البريد الإلكتروني غير مستخدم. او تم حذفة";
  else if(errorException == "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.")
    return isLeft ? "The password is invalid or the user does not have a password." : "الرقم السري غير صحيح";
  return errorException;
}