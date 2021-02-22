bool checkIfTextInArabic(String text) {
  var referenceText = "أبجدهوزحطيكلمنسعفصقرشتثخذضظغ";
  var notArabicCount = 0;
  for (int i = 0; i < referenceText.length; i++) {
    if (text.contains(referenceText[i])) return true;
  }
  return false;
}
