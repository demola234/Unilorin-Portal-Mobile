List<String> getSessions() {
  List<String> sessionYears = [];
  // subtract one to account for covid displacement
  var thisYear = DateTime.now().year - 1;
  for (var year = thisYear; year >= 2009; year--) {
    var session = "${year - 1}/$year";
    sessionYears.add(session.trim());
  }
  return sessionYears;
}
