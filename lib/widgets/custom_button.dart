import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.tabController,
    required this.text,
    this.emailController,
    this.passwordController,
    super.key,
  });

  final TabController tabController;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        onPressed: () async {
          if (emailController != null && passwordController != null) {
            await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                  email: emailController!.text,
                  password: passwordController!.text,
                )
                .then((value) => print("User Added"))
                .catchError((error) => print("Failed to add user"));
          }
          tabController.animateTo(tabController.index + 1);
        },
        child: SizedBox(
          width: double.infinity,
          child: Text(
            text,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
