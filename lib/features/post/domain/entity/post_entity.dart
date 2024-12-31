// ignore_for_file: public_member_api_docs, sort_constructors_first
class Post {
  int? id;
  String title;
  String body;
  Post({
    this.id,
    required this.title,
    required this.body,
  });

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.body == body;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ body.hashCode;
}
