import 'package:flutter/material.dart';

/// Custom local used for translation.
class CustomLocale extends Locale {
  @override
  String languageCode;

  /// Requires language code.
  CustomLocale({required this.languageCode}) : super(languageCode);

  @override
  int get hashCode => languageCode.hashCode;

  /// Override comparator operator to only compare text codes from the locals.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CustomLocale && other.languageCode == languageCode;
  }
}
