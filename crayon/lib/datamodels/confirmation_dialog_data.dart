/// ConfirmationDialogData is used for the confirmation dialog.
/// It allows to dynamically change the text to not force and keep showing the same text.
///
class ConfirmationDialogData {
  /// The textcode will be used for translation. If null Saftytext will be used.
  String? textCode;
  String? description;
  String? cancelTitle;
  String? acceptTitle;

  /// Item title for what purposes for exmaple the lecture name for deleting a lecture.
  String itemTitle;

  /// The safetytext is required field and will be shown if the text code isn't provided.
  String safetyText;
  ConfirmationDialogData(
      {this.textCode,
      this.description,
      this.cancelTitle,
      this.acceptTitle,
      required this.safetyText,
      required this.itemTitle});
}
