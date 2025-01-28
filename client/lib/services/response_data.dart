// custom class to handle response data from the server
class ResponseData {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  ResponseData({
    required this.success,
    required this.message,
    this.data,
  });
}