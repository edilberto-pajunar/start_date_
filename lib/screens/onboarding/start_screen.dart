import 'package:flutter/material.dart';
import 'package:start_date/widgets/custom_button.dart';

class Start extends StatelessWidget {
  const Start({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset("assets/images/start.png"),
              ),
              const SizedBox(height: 50.0),
              Text(
                "Welcome to Start Date",
                style: theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Lorem ipsum",
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          CustomButton(
            tabController: tabController,
            text: "Start",
          ),
        ],
      ),
    );
  }
}
