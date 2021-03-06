import 'package:flutter/material.dart';
import '../config/config.dart';
import '../widgets/widgets.dart';

class TreatyToUseService extends StatelessWidget {
  final String laws = "البند الأول : لكونك مستخدم فأنك توافق على الالتزام بكل ما يرد بهذه الاتفاقية في حال استخدامك التطبيق او في حال الوصول اليه او في حالة التسجيل في الخدمة. يحق لإدارة التطبيق السوق الطويل أو تطبيق السوق الطويل التعديل على هذه الاتفاقية في أي وقت وتعتبر ملزمة لجميع الأطراف بعد الإعلان عن التحديث في التطبيق أو في أي وسيلة آخرى. " +
      "\n\n" +
      "البند الثاني : يتحمل المعلن كامل المسؤولية عن محتوى الإعلان و الصور ولا تتحمل إدارة تطبيق السوق الطويل ولا تطبيق السوق الطويل أي مسؤولية عن محتوي أي إعلان." +
      "\n\n" +
      "البند الثالث : بعدم نشر إعلانات أو تعليقات كاذبة أو غير دقيقة أو مضللة أو خادعة أو قذف ، أو تشهير." +
      "\n\n" +
      "البند الرابع : بعدم التعرض للسياسات أو السيادات الدولية أو الشخصيات المعتبرة أو أي مناقشات لا تتعلق بالبيع والشراء المشروعة في تطبيق السوق الطويل." +
      "\n\n" +
      "البند الخامس : عدم جمع معلومات عن مستخدمي الموقع الآخرين لأغراض تجارية أو غيرها." +
      "\n\n" +
      "البند السادس : سيتم حذف الإعلان بشكل تلقائي بعد ثلاث أشهر من تاريخ النشر." +
      "\n\n" +
      "البند السابع : جميع السلع الممنوعة حسب قوانين الجمهورية العربية السورية." +
      "\n\n" +
      "البند الثامن : الأدوية والمنتجات الطبية والصحية. هذه السلع ممنوعه حتى لو كان مسموح بها في قوانين وزارة الصحة وحتى لو كانت سلع موصى بها من الوازرة." +
      "\n\n" +
      "البند التاسع : الأسلحة بمافيها الصواعق والمسدسات و الرشاشات واسلحة الحماية الشخصية و مستلزماتها حتى لو كانت مرخصة." +
      "\n\n" +
      "البند العاشر : أجهزة الليزر وأجهزة التجسس و التنصت." +
      "\n\n" +
      "البند الحادي عشر : الإعلان عن منتجات أو خدمات تتطلب ترخيص من دون الحصول على الترخيص من الجهة المنظمة." +
      "\n\n";

  @override
  Widget build(BuildContext context) {
    return MyBuildAlertDialog(
      context,
      SingleChildScrollView(
        child: Container(
          height: 1300,
          //   color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(isLeft ?"Treaty to use service": "معاهدة الإستخدام",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: Text(
                      laws,
                      style: TextStyle(color: Colors.black),
                      overflow: TextOverflow.visible,
                      textAlign: isLeft ? TextAlign.left : TextAlign.right,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
