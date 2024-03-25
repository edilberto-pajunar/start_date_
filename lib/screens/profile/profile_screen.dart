import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/profile/profile_bloc.dart';
import 'package:start_date/models/user_model.dart';
import 'package:start_date/repositories/auth/auth_repository.dart';
import 'package:start_date/widgets/custom_appbar.dart';
import 'package:start_date/widgets/custom_text_container.dart';
import 'package:start_date/widgets/title_with_icon.dart';
import 'package:start_date/widgets/user_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppbar(
        title: "PROFILE",
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  UserImage.medium(
                    height: 300,
                    url: state.user.imageUrls[0],
                    child: Container(
                      height: size.height * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.4),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Text(
                            state.user.name,
                            style: theme.textTheme.headlineLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleWithIcon(
                          title: "Biography",
                          icon: Icons.edit,
                        ),
                        Text(
                          state.user.bio,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            height: 1.5,
                          ),
                        ),
                        const TitleWithIcon(
                          title: "Pictures",
                          icon: Icons.edit,
                        ),
                        SizedBox(
                          height: 125.0,
                          child: ListView.builder(
                            itemCount: state.user.imageUrls.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: UserImage.small(
                                  url: state.user.imageUrls[index],
                                  width: 100,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const TitleWithIcon(
                          title: "Location",
                          icon: Icons.edit,
                        ),
                        Text(
                          state.user.location,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            height: 1.5,
                          ),
                        ),
                        const TitleWithIcon(
                          title: "Interest",
                          icon: Icons.edit,
                        ),
                        Row(
                          children: [
                            CustomTextContainer(text: state.user.interests[0]),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            RepositoryProvider.of<AuthRepository>(context)
                                .signOut();
                          },
                          child: const Center(
                            child: Text(
                              "Sign Out",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Text("Something went wrong.");
            }
          },
        ),
      ),
    );
  }
}
