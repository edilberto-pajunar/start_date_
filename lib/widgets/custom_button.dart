import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/cubits/signup/signup_cubit.dart';
import 'package:start_date/models/user_model.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.tabController,
    required this.text,
    super.key,
  });

  final TabController tabController;
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
          if (tabController.index == 6) {
            Navigator.pop(context, true);
          } else {
            tabController.animateTo(tabController.index + 1);
          }
          if (tabController.index == 2) {
            await context
                .read<SignupCubit>()
                .signupWithCredentials()
                .then((value) {
              User user = User(
                id: context.read<SignupCubit>().state.user?.uid,
                name: "",
                age: 0,
                gender: "",
                imageUrls: const [],
                bio: "",
                jobTitle: "",
                interests: const [],
                location: "",
              );

              context.read<OnboardingBloc>().add(StartOnboarding(user: user));
            });
          }
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
