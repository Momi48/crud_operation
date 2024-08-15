import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/loading/done_screen.dart';
import 'package:flutter_assignment/widgets/resuable_container.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  int idNumber = 0;
  bool loading = false;
  final dataRef = FirebaseDatabase.instance.ref('Post');
  final postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Whats on Your Mind'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              maxLines: 3,
              controller: postController,
              decoration: InputDecoration(
                  hintText: 'Express Your Feelings',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ResuableContainer(
            title: 'Add',
            loading: loading,
            onTap: () {
              setState(() {
                loading = true;
              });
              String id = DateTime.now().microsecondsSinceEpoch.toString();
              dataRef.child(id).set({
                'title': postController.text.toString(),
                'id': id
              }).then((value) {
                DoneLoading().getMessage('Post Added Successfully');
                setState(() {
                  loading = false;
                });
              }).onError((error, stackTrace) {
                setState(() {
                  loading = false;
                });
                DoneLoading().getMessage(error.toString());
              });
            },
          )
        ],
      ),
    );
  }
}
