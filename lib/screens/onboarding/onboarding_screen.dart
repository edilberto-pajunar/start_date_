import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/cubits/signup/signup_cubit.dart';
import 'package:start_date/repositories/auth/auth_repository.dart';
import 'package:start_date/repositories/database/database_repository.dart';
import 'package:start_date/repositories/location/location_repository.dart';
import 'package:start_date/repositories/storage/storage_repository.dart';
import 'package:start_date/screens/onboarding/onboarding_screens/bio_screen.dart';
import 'package:start_date/screens/onboarding/onboarding_screens/demo_screen.dart';
import 'package:start_date/screens/onboarding/onboarding_screens/email_screen.dart';
import 'package:start_date/screens/onboarding/onboarding_screens/location_screen.dart';
import 'package:start_date/screens/onboarding/onboarding_screens/pictures_screen.dart';
import 'package:start_date/screens/onboarding/onboarding_screens/start_screen.dart';
import 'package:start_date/widgets/custom_appbar.dart';
import 'package:start_date/widgets/custom_button.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const List<Tab> tabs = <Tab>[
    Tab(
      text: "Start",
    ),
    Tab(
      text: "Email",
    ),
    // Tab(
    //   text: "Email Verification",
    // ),
    Tab(
      text: "Demo",
    ),
    Tab(
      text: "Pictures",
    ),
    Tab(
      text: "Bio",
    ),
    // Tab(
    //   text: "Location",
    // ),
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

            return Scaffold(
              appBar: const CustomAppbar(
                title: "Onboarding",
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 50.0),
                child: BlocBuilder<OnboardingBloc, OnboardingState>(
                  builder: (context, state) {
                    if (state is OnboardingLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is OnboardingLoaded) {
                      return TabBarView(
                        children: [
                          StartTab(state: state),
                          EmailTab(state: state),
                          // EmailVerificationTab(state: state),
                          DemoTab(state: state),
                          PicturesTab(state: state),
                          BioTab(state: state),
                          // LocationTab(state: state),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text("Something went wrong."),
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class OnboardingScreenLayout extends StatelessWidget {
  const OnboardingScreenLayout({
    super.key,
    required this.currentStep,
    required this.onPressed,
    required this.children,
  });

  final int currentStep;
  final Function()? onPressed;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...children,
                  const Spacer(),
                  SizedBox(
                    height: 75,
                    child: StepProgressIndicator(
                      totalSteps: 5,
                      currentStep: currentStep,
                      selectedColor: Colors.black,
                      unselectedColor: Colors.white,
                    ),
                  ),
                  CustomButton(
                    text: "NEXT STEP",
                    onPressed: onPressed,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
