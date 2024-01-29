import 'package:equatable/equatable.dart';

class ApiResponseException extends Equatable implements Exception {
  final int statusCode;

  const ApiResponseException({required this.statusCode});

  @override
  List<Object?> get props => [statusCode];
}

class ApiGenericException extends Equatable implements Exception {
  final String message;

  const ApiGenericException({required this.message});

  @override
  List<Object?> get props => [message];
}