import 'package:intl/intl.dart';

class Utils{
  DateTime convetDate(String text){
    List<String> texts = text.split('/');
  
  String t1=texts[0].toString().padLeft(2, '0');
  String t2=texts[1].toString().padLeft(2, '0');
  String t3=texts[2].toString().padLeft(3, '20');
  
  String s = t3+t1+t2;
  return (DateTime.parse(s));
  }

  static String numberFormat(int n){
                                  final formatter = NumberFormat.decimalPattern();
                                  return formatter.format(n);

  }
}