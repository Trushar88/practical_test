class BaseSettingResponse {
  int? statusCode;
  String? message;
  int? success;
  int? count;
  int? offSet;
  int? perPage;
  int? currentPage;
  bool? prevPage;
  bool? nextPage;

  BaseSettingResponse({this.statusCode, this.message, this.success});

  BaseSettingResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status'];
    message = json['message'];
    success = json['success'];
    count = json["count"];
    offSet = json["offset"];
    perPage = json["per_page"];
    currentPage = json["curr_page"];
    prevPage = json["prev_page"] != null
        ? json["prev_page"] == 0
            ? false
            : true
        : false;
    nextPage = json["next_page"] != null
        ? json["next_page"] == 0
            ? false
            : true
        : false;
  }
}
