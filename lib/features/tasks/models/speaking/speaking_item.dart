class SpeakingItem {
  SpeakingItem(this.phrase, {this.recordedFilePath, this.rating});

  final String phrase;
  String? recordedFilePath;
  int? rating;
}
