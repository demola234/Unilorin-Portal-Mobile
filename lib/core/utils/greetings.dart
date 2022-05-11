String getGreetings() {
  var presentTime = DateTime.now().hour;
  if (presentTime <= 12) {
    return "Good Morning";
  } else if ((presentTime > 12) && (presentTime < 16)) {
    return "Good Afternoon";
  } else if ((presentTime > 16) && (presentTime < 20)) {
    return "Good Evening";
  }
  return "Good Evening";
}
