import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/auth/auth_bloc.dart';
import 'package:start_date/blocs/match/match_bloc.dart';
import 'package:start_date/blocs/profile/profile_bloc.dart';
import 'package:start_date/cubits/invitation/invitation_cubit.dart';
import 'package:start_date/cubits/login/login_cubit.dart';
import 'package:start_date/firebase_options.dart';
import 'package:start_date/repositories/auth/auth_repository.dart';
import 'package:start_date/repositories/database/database_repository.dart';
import 'package:start_date/repositories/location/location_repository.dart';
import 'package:start_date/repositories/storage/storage_repository.dart';
import 'package:start_date/screens/splash/splash_screen.dart';

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
        RepositoryProvider(create: (context) => DatabaseRepository()),
        RepositoryProvider(create: (context) => StorageRepository()),
        RepositoryProvider(create: (context) => LocationRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
              databaseRepository: context.read<DatabaseRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => InvitationCubit(
              databaseRepository: context.read<DatabaseRepository>(),
              authBloc: context.read<AuthBloc>(),
            ),
          ),
          BlocProvider(
            create: (context) => LoginCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => MatchBloc(
              databaseRepository: context.read<DatabaseRepository>(),
            )..add(LoadMatches(user: context.read<AuthBloc>().state.user!)),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              authBloc: context.read<AuthBloc>(),
              databaseRepository: context.read<DatabaseRepository>(),
              locationRepository: context.read<LocationRepository>(),
            )..add(LoadProfile(
                userId: context.read<AuthBloc>().state.authUser!.uid)),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
