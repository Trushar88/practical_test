// ignore_for_file: unnecessary_new, no_leading_underscores_for_local_identifiers, file_names

//APIResult it is master model for API response
class APIResult<T> {
  late String status;
  late String message;
  late T recordList;

  APIResult({
    required this.status,
    required this.message,
    required this.recordList,
  });

  factory APIResult.fromJson(Map<String, dynamic> json, T _recordList) =>
      new APIResult(
        status: json["status"].toString(),
        message: json["message"],
        recordList: _recordList,
      );
}

//Error reponse
class Error {
  late String apiName;
  late String apiType;
  late String fileName;
  late dynamic functionName;
  late dynamic lineNumber;
  late dynamic typeName;
  late String stack;

  Error({
    required this.apiName,
    required this.apiType,
    required this.fileName,
    this.functionName,
    this.lineNumber,
    this.typeName,
    required this.stack,
  });

  factory Error.fromJson(Map<String, dynamic> json) => new Error(
        apiName: json["apiName"],
        apiType: json["apiType"],
        fileName: json["fileName"],
        functionName: json["functionName"],
        lineNumber: json["lineNumber"],
        typeName: json["typeName"],
        stack: json["stack"],
      );
}
