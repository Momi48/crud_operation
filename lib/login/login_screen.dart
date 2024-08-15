import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/loading/done_screen.dart';
import 'package:flutter_assignment/screens/post_screen.dart';
import 'package:flutter_assignment/signUp/sign_up_screen.dart';
import 'package:flutter_assignment/widgets/resuable_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool toggle = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
      automaticallyImplyLeading: false,
        title: const Text('Login/Sign in ',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
              const  SizedBox(height: 20,),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is Empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: toggle ? false : true,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            
                          });
                          toggle = !toggle;
                        },
                        icon: Icon(toggle ? Icons.visibility :Icons.visibility_off)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is Empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                ResuableContainer(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      auth
                          .signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.toString())
                          .then((value) {
                        setState(() {
                          loading = false;
                        });
                        DoneLoading().getMessage('Logged In');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PostScreen()));
                      }).onError((error, stack) {
                        setState(() {
                          loading = false;
                        });
                        DoneLoading().getMessage(error.toString());
                      });
                    }
                  },
                  title: 'Login ',
                  loading: loading,
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't Have An Account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
