import 'package:intl/intl.dart';

String dividePrice(int value) {
  var formatter = NumberFormat('##,###');
  final result = formatter.format(value);
  return result.replaceAll('.', ' ');
}
