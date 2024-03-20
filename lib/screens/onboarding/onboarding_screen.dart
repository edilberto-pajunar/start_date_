import 'package:flutter/material.dart';
import 'package:start_date/screens/onboarding/bio_screen.dart';
import 'package:start_date/screens/onboarding/demo_screen.dart';
import 'package:start_date/screens/onboarding/email_screen.dart';
import 'package:start_date/screens/onboarding/email_verification_screen.dart';
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
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context);

          tabController.addListener(() {
            if (!tabController.indexIsChanging) {}
          });

          return Scaffold(
            appBar: const CustomAppbar(
              title: "Onboarding",
            ),
            body: TabBarView(
              children: [
                Start(tabController: tabController),
                Email(tabController: tabController),
                EmailVerification(tabController: tabController),
                Demo(tabController: tabController),
                Pictures(tabController: tabController),
                Bio(tabController: tabController),
              ],
            ),
          );
        },
      ),
    );
  }
}
