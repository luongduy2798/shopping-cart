import 'package:intl/intl.dart';

extension IntCustom on int {
  String numberFormat() {
    return NumberFormat("#,###", 'en').format(this).replaceAll(".", ",");
  }
}
