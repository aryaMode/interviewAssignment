import 'dart:convert';

class Post {
  final int date;
  final String key;
  final String author;
  final String title;
  final String body;
  Post({
    required this.date,
    required this.key,
    required this.author,
    required this.title,
    required this.body,
  });

  Post copyWith({
    int? date,
    String? key,
    String? author,
    String? title,
    String? body,
  }) {
    return Post(
      date: date ?? this.date,
      key: key ?? this.key,
      author: author ?? this.author,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'key': key,
      'author': author,
      'title': title,
      'body': body,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      date: map['date']?.toInt() ?? 0,
      key: map['key'] ?? '',
      author: map['author'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(date: $date, key: $key, author: $author, title: $title, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Post &&
      other.date == date &&
      other.key == key &&
      other.author == author &&
      other.title == title &&
      other.body == body;
  }

  @override
  int get hashCode {
    return date.hashCode ^
      key.hashCode ^
      author.hashCode ^
      title.hashCode ^
      body.hashCode;
  }
}
