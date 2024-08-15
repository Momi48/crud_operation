import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/loading/done_screen.dart';
import 'package:flutter_assignment/login/login_screen.dart';
import 'package:flutter_assignment/widgets/resuable_container.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool toggle = false;
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUp() {
    setState(() {
      loading = true;
    });
    auth
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      DoneLoading().getMessage('Account Created');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }).onError((error, stack) {
      setState(() {
        loading = false;
      });
      DoneLoading().getMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Sign Up ',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                
                const SizedBox(
                  height: 20,
                ),
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
                        setState(() {});
                        toggle = !toggle;
                      },
                      icon: Icon(
                          toggle ? Icons.visibility : Icons.visibility_off),
                    ),
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
                const SizedBox(
                  height: 20,
                ),
                ResuableContainer(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      signUp();
                    }
                  },
                  title: 'Sign Up',
                  loading: loading,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already Have An Account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
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
