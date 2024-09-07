class TimerData {
  final int postId;
  int elapsedTime;
  bool isActive;

  TimerData({
    required this.postId,
    this.elapsedTime = 0,
    this.isActive = false,
  });

  // Create from JSON
  factory TimerData.fromJson(Map<String, dynamic> json) {
    return TimerData(
      postId: json['postId'],
      elapsedTime: json['elapsedTime'],
      isActive: json['isActive'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'elapsedTime': elapsedTime,
      'isActive': isActive,
    };
  }
}
