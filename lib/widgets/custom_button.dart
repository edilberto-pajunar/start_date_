import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    this.onPressed,
    super.key,
  });

  final String text;
  final void Function()? onPressed;

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
        onPressed: onPressed,
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

// onPressed: () async {
//           if (tabController.index == 6) {
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => const SplashScreen()));
//           } else {
//             tabController.animateTo(tabController.index + 1);
//           }
//           if (tabController.index == 2) {
//             await context
//                 .read<SignupCubit>()
//                 .signupWithCredentials()
//                 .then((value) {
//               User user = User(
//                 id: context.read<SignupCubit>().state.user?.uid,
//                 name: "",
//                 age: 0,
//                 gender: "",
//                 imageUrls: const [],
//                 bio: "",
//                 jobTitle: "",
//                 interests: const [],
//                 location: Location.initialLocation,
//                 swipeLeft: const [],
//                 swipeRight: const [],
//                 matches: const [],
//                 distancePreference: 10,
//                 ageRangePreference: const [18, 50],
//                 genderPreference: const ["Female"],
//               );

//               context.read<OnboardingBloc>().add(StartOnboarding(user: user));
//             });
//           }
//         },