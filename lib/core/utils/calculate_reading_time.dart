int calculateReadingTime(String content) {
  final wordCounter = content.split(RegExp(r'\s+')).length;

  final readingTime = wordCounter / 225;

  return readingTime.ceil();
}
