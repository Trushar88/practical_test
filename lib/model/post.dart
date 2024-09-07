class Post {
  final int id;
  final String title;
  final String body;
  int timer;
  bool isActive;

  Post(
      {required this.id,
      required this.title,
      required this.body,
      this.timer = 0,
      this.isActive = false});

  // Create a Post instance from a JSON object
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      timer: json['timer'] ?? 0,
      isActive: json['isActive'] ?? false,
    );
  }

  // Convert a Post instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'timer': timer,
      'isActive': isActive
    };
  }
}
