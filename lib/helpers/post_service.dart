
import 'package:firebase_database/firebase_database.dart';
import 'package:internship_assignment/modules/Home/models/post.dart';

class PostService {
  String nodeName = 'posts';
  FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference _databaseReference;

  void addPost(Post post) {
    _databaseReference = database.ref().child(nodeName);
    _databaseReference.push().set(post.toMap());
  }

  void deletePost(Post? post) {
    _databaseReference = database.ref().child('$nodeName/${post?.key}');
    _databaseReference.remove();
  }

  void updatePost(Post post) {
    _databaseReference = database.ref().child('$nodeName/${post.key}');
    _databaseReference.update(post.toMap());
  }
}
