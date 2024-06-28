import 'package:intl/intl.dart';

const rfc822DatePattern = 'EEE, dd MMM yyyy HH:mm:ss Z';
const rfc822DatePatternWithoutSeconds = 'EEE, dd MMM yyyy HH:mm Z';
const rfc822DatePatternWithoutDayOfWeek = 'dd MMM yyyy HH:mm:ss Z';

DateTime? parseDateTime(String? dateString) {
  if (dateString == null) return null;

  return _tryParseRfc822Date(dateString, rfc822DatePattern) ??
      _tryParseRfc822Date(dateString, rfc822DatePatternWithoutSeconds) ??
      _tryParseRfc822Date(dateString, rfc822DatePatternWithoutDayOfWeek) ??
      _parseIso8601DateTime(dateString);
}

DateTime? _tryParseRfc822Date(String dateString, String pattern) {
  try {
    final num? length = dateString.length.clamp(0, pattern.length);
    final trimmedPattern = pattern.substring(0, length as int);
    final format = DateFormat(trimmedPattern, 'en_US');
    return format.parse(dateString);
  } on FormatException {
    return null;
  }
}

DateTime? _parseIso8601DateTime(String dateString) {
  try {
    return DateTime.parse(dateString);
  } on FormatException {
    return null;
  }
}
