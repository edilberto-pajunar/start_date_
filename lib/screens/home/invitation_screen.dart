import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/profile/profile_bloc.dart';
import 'package:start_date/cubits/cubit/invitation_cubit.dart';
import 'package:start_date/widgets/custom_elevated_button.dart';
import 'package:start_date/widgets/custom_text_field.dart';

class InvitationScreen extends StatelessWidget {
  const InvitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is ProfileLoaded) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.2),
                    Text(
                      "Invite/Join a friend",
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "You should join/invite a friend first, before you can see your dream partner",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextField(
                      hint: "Invitation Code",
                      onChanged: (value) {
                        context
                            .read<InvitationCubit>()
                            .invitationCodeChanged(value);
                      },
                    ),
                    SizedBox(height: size.height * 0.2),
                    Text(
                      "Invitation Code: ${state.generatedCode ?? ""}",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    CustomElevatedButton(
                      text: "Generate a Code",
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () {
                        context.read<ProfileBloc>().add(GenerateCode());
                      },
                    ),
                    const SizedBox(height: 20.0),
                    CustomElevatedButton(
                      text: "Join",
                      color: Colors.white,
                      textColor: Colors.black,
                      onPressed: () {
                        context.read<InvitationCubit>().joinPartner();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Text("Something went wrong.");
        }
      },
    );
  }
}
