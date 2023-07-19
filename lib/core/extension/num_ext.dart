extension IntExt on int {
  String padZero(int number) {
    return toString().padLeft(number, '0');
  }
}
