import 'package:intl/intl.dart';

class DateTimeService {
  String _utc =  new DateTime.now().toUtc().toString();
  var _offsetInHrs;

  DateTimeService() {
    this._offsetInHrs = new DateTime.now().timeZoneOffset.inHours;
  }

  String get utc => _utc.toString();

  String getDate(String formattedString) {
    print('formattedString: $formattedString');
    DateTime dateTime = DateTime.parse(formattedString);
    //TODO: This is hack, Fix in backend. +3 because the db was giving me incorrect
    dateTime = dateTime.add(new Duration(hours: _offsetInHrs + 3));

    final DateFormat dateFormatter = DateFormat.yMMMMEEEEd();
    final String formattedDate = dateFormatter.format(dateTime);

    final DateFormat timeFormatter = DateFormat('Hm');
    final String formattedTime = timeFormatter.format(dateTime);

    return '$formattedDate $formattedTime';
  }
}
