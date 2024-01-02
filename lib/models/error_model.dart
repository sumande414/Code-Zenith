class CfError {
  CfError({required this.status, required this.comment});
  String status;
  String comment;

  factory CfError.fromJson(Map<String, dynamic> json) {
    String status = json['status'];
    String comment = json['comment'];
    return CfError(status: status, comment: comment);
  }
}
