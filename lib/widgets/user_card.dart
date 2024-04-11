import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:start_date/models/user_model.dart';
import 'package:start_date/widgets/user_image.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    required this.user,
    required this.heroTag,
    required this.partner,
    super.key,
  });

  final User user;
  final String heroTag;
  final User partner;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return Hero(
      tag: heroTag,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: size.height * 0.3,
          width: size.width,
          child: Stack(
            children: [
              UserImage.large(
                url: user.imageUrls[0],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.withOpacity(0.5),
                      Colors.black.withOpacity(0.1),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Visibility(
                visible: partner.swipeLeft!.contains(user.id) ||
                    partner.swipeRight!.contains(user.id),
                child: Positioned(
                  top: 20,
                  right: 10,
                  child: Icon(
                    partner.swipeRight!.contains(user.id)
                        ? Icons.favorite
                        : Icons.heart_broken,
                    color: partner.swipeRight!.contains(user.id)
                        ? Colors.red
                        : Colors.orange,
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user.name}, ${user.age}",
                      style: theme.textTheme.headlineLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.jobTitle,
                      style: theme.textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: user.imageUrls.length,
                        itemBuilder: (context, index) {
                          return (index < user.imageUrls.length)
                              ? UserImage.small(
                                  url: user.imageUrls[index],
                                  margin: const EdgeInsets.only(
                                      top: 8.0, right: 8.0),
                                )
                              : Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.info,
                                    size: 25.0,
                                  ),
                                );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
