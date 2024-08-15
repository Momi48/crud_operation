import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/loading/done_screen.dart';
import 'package:flutter_assignment/login/login_screen.dart';
import 'package:flutter_assignment/screens/add_post_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Future<void> signOut() async {
    await auth.signOut().then((value) {
      DoneLoading().getMessage('Logged Out');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }).onError((error, stack) {
      DoneLoading().getMessage(error.toString());
    });
  }

  final auth = FirebaseAuth.instance;
  final textStyle =
      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  final dataRef = FirebaseDatabase.instance.ref('Post');
  final editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                signOut();
              },
              icon: const Icon(Icons.exit_to_app_outlined))
        ],
        title: const Text('Added Post'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                  query: dataRef,
                  itemBuilder: (context, snapshot, animation, index) {
                    if (!snapshot.exists) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    final title = snapshot.child('title').value.toString();
                    final id = snapshot.child('id').value.toString();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(14)),
                        child: ListTile(
                          title: Text(
                            title,
                            style: textStyle,
                          ),
                          subtitle: Text(
                            id,
                            style: textStyle,
                          ),
                          trailing: PopupMenuButton(
                              iconColor: Colors.white,
                              itemBuilder: (context) {
                                return <PopupMenuEntry>[
                                  PopupMenuItem(
                                      child: TextButton(
                                          onPressed: () {
                                            alertDialog(title, id);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Update'))),
                                  PopupMenuItem(
                                      child: TextButton(
                                          onPressed: () {
                                            dataRef.child(id).remove();
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Delete'))),
                                ];
                              }),
                        ),
                      ),
                    );
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPostScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void alertDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('Update Your Post'),
            actions: [
              TextButton(
                  onPressed: () {
                    dataRef
                        .child(id)
                        .update({'title': editController.text.toString()});
                    Navigator.pop(context);
                  },
                  child: const Text('Update')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
            title: TextFormField(
              controller: editController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          );
        });
  }
}
