class Utils {
  static String formatDate(DateTime datetime) {
    return datetime.toIso8601String().split("T").first;
  }
}
