class ApiResponse<T> {
  ApiResponse({this.status, this.data, this.message});

  bool? status;
  T? data;
  String? message;
}