import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/cubits/signup/signup_cubit.dart';
import 'package:start_date/repositories/auth/auth_repository.dart';
import 'package:start_date/repositories/database/database_repository.dart';
import 'package:start_date/repositories/location/location_repository.dart';
import 'package:start_date/repositories/storage/storage_repository.dart';
import 'package:start_date/screens/onboarding/bio_screen.dart';
import 'package:start_date/screens/onboarding/demo_screen.dart';
import 'package:start_date/screens/onboarding/email_screen.dart';
import 'package:start_date/screens/onboarding/email_verification_screen.dart';
import 'package:start_date/screens/onboarding/location_screen.dart';
import 'package:start_date/screens/onboarding/pictures_screen.dart';
import 'package:start_date/screens/onboarding/start_screen.dart';
import 'package:start_date/widgets/custom_appbar.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const List<Tab> tabs = <Tab>[
    Tab(
      text: "Start",
    ),
    Tab(
      text: "Email",
    ),
    Tab(
      text: "Email Verification",
    ),
    Tab(
      text: "Demo",
    ),
    Tab(
      text: "Pictures",
    ),
    Tab(
      text: "Bio",
    ),
    Tab(
      text: "Location",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardingBloc(
            databaseRepository: context.read<DatabaseRepository>(),
            storageRepository: context.read<StorageRepository>(),
            locationRepository: context.read<LocationRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => SignupCubit(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
      ],
      child: DefaultTabController(
        length: tabs.length,
        child: Builder(
          builder: (context) {
            final TabController tabController =
                DefaultTabController.of(context);

            context
                .read<OnboardingBloc>()
                .add(StartOnboarding(tabController: tabController));

            return const Scaffold(
              appBar: CustomAppbar(
                title: "Onboarding",
              ),
              body: TabBarView(
                children: [
                  StartTab(),
                  EmailTab(),
                  EmailVerificationTab(),
                  DemoTab(),
                  PicturesTab(),
                  BioTab(),
                  LocationTab(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
