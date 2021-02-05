class TimeService {
  String _utc =  new DateTime.now().toUtc().toString();

  var _offsetInHrs;

  TimeService() {
    this._offsetInHrs = new DateTime.now().timeZoneOffset.inHours;
  }

  String get utc => _utc.toString();

  String getTime(String formattedString) {
    DateTime time = DateTime.parse(formattedString);
    return time.add(new Duration(hours: _offsetInHrs)).toString();
  }
}
