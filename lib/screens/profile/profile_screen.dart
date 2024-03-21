import 'package:flutter/material.dart';
import 'package:start_date/models/user_model.dart';
import 'package:start_date/widgets/choice_button.dart';
import 'package:start_date/widgets/custom_appbar.dart';
import 'package:start_date/widgets/custom_text_container.dart';
import 'package:start_date/widgets/title_with_icon.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    final User user = User.users[0];

    return Scaffold(
      appBar: const CustomAppbar(
        title: "PROFILE",
        hasActions: true,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Stack(
            children: [
              Container(
                height: size.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(3, 3),
                      blurRadius: 3,
                      spreadRadius: 3,
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(user.imageUrls[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
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
                      user.name,
                      style: theme.textTheme.headlineLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
                  user.bio,
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
                    itemCount: 3,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Container(
                          height: 125,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.black,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                user.imageUrls[index],
                              ),
                              fit: BoxFit.cover,
                            ),
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
                  "Singatpore, 1 Suntec City",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    height: 1.5,
                  ),
                ),
                const TitleWithIcon(
                  title: "Interest",
                  icon: Icons.edit,
                ),
                const Row(
                  children: [
                    CustomTextContainer(text: "MUSIC"),
                    CustomTextContainer(text: "ECONOMICS"),
                    CustomTextContainer(text: "FOOTBALL "),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
