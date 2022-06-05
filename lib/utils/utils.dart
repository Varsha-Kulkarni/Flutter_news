import 'package:intl/intl.dart';

String dateFormatter(String publishedDate) {
  DateTime parseDate =
      new DateFormat("yyyy-MM-ddThh:mm:ssZ").parse(publishedDate);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
  return outputFormat.format(inputDate);
}
