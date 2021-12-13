class ConfirmationDialogData {
  String? textCode;
  String? description;
  String? cancelTitle;
  String? acceptTitle;
  String itemTitle;
  String safetyText;
  ConfirmationDialogData(
      {this.textCode,
      this.description,
      this.cancelTitle,
      this.acceptTitle,
      required this.safetyText,
      required this.itemTitle});
}
