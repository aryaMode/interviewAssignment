import 'package:flutter/material.dart';
import 'package:internship_assignment/modules/Home/edit_post.dart';
import 'package:internship_assignment/modules/Home/view_post.dart';

import '../modules/Home/models/post.dart';

class PostCard extends StatelessWidget {
  const PostCard({required this.post, Key? key, this.editable = false})
      : super(key: key);
  final Post? post;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => editable
                    ? EditPost(
                        post: post,
                      )
                    : PostView(post))),
          );
        },
        child: Card(
            elevation: 4.0,
            color: Colors.grey.shade300,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.border_color,
                        size: 18.0,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        post?.title ?? "Untitled",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    post?.body ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
