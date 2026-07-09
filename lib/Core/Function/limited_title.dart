String limitedTitle(String title, [int maxWords = 3]) {
  final words = title.split(' ');
  return words.length <= maxWords
      ? title
      : words.take(maxWords).join(' ');
}