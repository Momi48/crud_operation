import 'package:flutter/material.dart';

class ResuableContainer extends StatefulWidget {
  final VoidCallback onTap;
  final String title;
  final bool loading;
  const ResuableContainer(
      {super.key,
      required this.onTap,
      this.loading = false,
      required this.title});

  @override
  State<ResuableContainer> createState() => _ResuableContainerState();
}

class _ResuableContainerState extends State<ResuableContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 200,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child:  Center(
          child:widget.loading == true ? const CircularProgressIndicator.adaptive() :  Text(
            widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
