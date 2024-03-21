import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/auth/auth_bloc.dart';
import 'package:start_date/blocs/swipe/swipe_bloc.dart';
import 'package:start_date/firebase_options.dart';
import 'package:start_date/models/user_model.dart';
import 'package:start_date/repositories/auth_repository.dart';
import 'package:start_date/screens/onboarding/onboarding_screen.dart';
import 'package:start_date/screens/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  AuthBloc(authRepository: context.read<AuthRepository>())),
          BlocProvider(
            create: (_) => SwipeBloc()..add(LoadUsersEvent(users: User.users)),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: OnboardingScreen(),
        ),
      ),
    );
  }
}
