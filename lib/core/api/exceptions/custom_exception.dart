import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_exception.freezed.dart';

@freezed
abstract class CustomException implements Exception, _$CustomException {
  const CustomException._();
  factory CustomException.noRecords() = NoRecordsException;
  factory CustomException.error(String message) = ErrorException;
  factory CustomException.failedToParse() = FailedToParseException;
  factory CustomException.sessionExpired() = SessionExpiredException;
  factory CustomException.noInternetConnection() =
      NoInternetConnectionException;
  factory CustomException.timeoutExpection() = TimeoutException;

  String toMessage() {
    return when(noRecords: () {
      return 'Could not find the data';
    }, error: (error) {
      return error;
    }, failedToParse: () {
      return 'Failed to parse the response';
    }, sessionExpired: () {
      return 'Session expired. Please login again';
    }, noInternetConnection: () {
      return 'Internet connection not available';
    }, timeoutExpection: () {
      return 'Time out';
    });
  }
}
