import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internship_assignment/modules/Auth/providers/providers.dart';
import 'package:internship_assignment/modules/Auth/signInScreen/login_screen.dart';
import 'package:internship_assignment/modules/Home/edit_post.dart';
import 'package:internship_assignment/widgets/post_card.dart';

import 'models/post.dart';

class HomePage extends ConsumerStatefulWidget {
  static String id = "home_screen";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = 'posts';
  List<Post>? postsList = <Post>[];
  int currentNavBarIndex = 0;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  bool switchValue = false;
  late Query postQuery;

  @override
  void initState() {
    super.initState();

    postQuery = _database.ref().child('posts');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: const Icon(Icons.home_filled),
              onTap: () {},
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: const Icon(Icons.create),
              onTap: () {},
            ),
            label: "My Blogs",
          ),
        ],
        currentIndex: currentNavBarIndex,
        onTap: (index) {
          setState(() {
            currentNavBarIndex = index;
          });
        },
      ),
      key: _globalKey,
      body: StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref("posts")
            .orderByChild("date")
            .onValue
            .asyncMap(
          (event) {
            List<Post> posts = [];
            for (DataSnapshot snapshot in event.snapshot.children) {
              Post post = Post.fromMap(snapshot.value as Map<String, dynamic>);
              if (currentNavBarIndex == 1) {
                if (post.author == ref.read(userProvider).name) {
                  posts.add(post);
                }
              } else {
                posts.add(post);
              }
            }
            return posts;
          },
        ),
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          postsList = snapshot.data;
          return Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Visibility(
                    visible: postsList?.isEmpty ?? true,
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: const Center(child: Text('No post to show')),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: postsList?.isNotEmpty ?? false,
                    child: Flexible(
                      child: ListView(
                        children: postsList
                                ?.map((post) => PostCard(
                                      post: post,
                                      editable: currentNavBarIndex == 1,
                                    ))
                                .toList() ??
                            [],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditPost(
                          newPost: true,
                        )));
          },
          tooltip: 'Add a post',
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
