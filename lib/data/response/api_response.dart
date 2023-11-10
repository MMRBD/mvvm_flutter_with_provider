class ApiResponse<T> {
  Status? status;
  String? message;
  T? data;

  ApiResponse(this.status, this.message, this.data);

  ApiResponse.loading() : status = Status.loading;

  ApiResponse.completed(this.data) : status = Status.success;

  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return "status: $status\n message: $message\n data: $data ";
  }
}

enum Status { loading, success, error }
