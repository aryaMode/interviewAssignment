import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internship_assignment/helpers/post_service.dart';
import 'package:internship_assignment/modules/Auth/providers/providers.dart';
import 'package:internship_assignment/modules/Auth/signInScreen/login_screen.dart';

import 'package:internship_assignment/modules/Home/home_screen.dart';
import 'package:uuid/uuid.dart';

import 'models/post.dart';

class EditPost extends ConsumerStatefulWidget {
  const EditPost({
    this.post,
    this.newPost = false,
    Key? key,
  }) : super(key: key);

  final Post? post;
  final bool newPost;
  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends ConsumerState<EditPost> {
  late TextEditingController titleEditingController;
  late TextEditingController bodyEditingController;
  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  void initState() {
    super.initState();
    titleEditingController = TextEditingController(text: widget.post?.title);
    bodyEditingController = TextEditingController(text: widget.post?.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.newPost ? 'Add Post' : 'Edit Post',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: titleEditingController,
                decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Post Title',
                    border: OutlineInputBorder()),
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return "Title field can't be empty";
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: bodyEditingController,
                decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Post Body',
                    border: OutlineInputBorder()),
                maxLines: 10,
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return "Body field can't be empty";
                  }
                },
              ),
              Visibility(
                visible: !widget.newPost,
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    PostService().deletePost(widget.post);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.check),
          onPressed: () {
            editPost();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void editPost() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      final Post post = Post(
          author: ref.read(userProvider.state).state.name,
          key: widget.post?.key ?? const Uuid().v4(),
          title: titleEditingController.text,
          body: bodyEditingController.text,
          date: DateTime.now().millisecondsSinceEpoch);
      PostService().updatePost(post);
      _formkey.currentState!.reset();
      Navigator.pushReplacementNamed(context, HomePage.id);
    }
  }
}
