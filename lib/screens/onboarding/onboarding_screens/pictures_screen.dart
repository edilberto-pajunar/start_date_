import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/screens/onboarding/onboarding_screen.dart';
import 'package:start_date/widgets/add_user_image.dart';
import 'package:start_date/widgets/custom_text_header.dart';
import 'package:start_date/widgets/user_image.dart';

class PicturesTab extends StatelessWidget {
  const PicturesTab({
    super.key,
    required this.state,
  });

  final OnboardingLoaded state;

  @override
  Widget build(BuildContext context) {
    var images = state.user.imageUrls;
    var imageCount = images.length;

    return OnboardingScreenLayout(
      currentStep: 4,
      onPressed: () {
        context
            .read<OnboardingBloc>()
            .add(ContinueOnboarding(user: state.user));
      },
      children: [
        const CustomTextHeader(
          text: "Add 2 or More Pictures",
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 350,
          child: GridView.builder(
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.66,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return (imageCount > index)
                  ? UserImage.medium(
                      url: images[index],
                      border: Border.all(
                        color: Colors.black,
                      ),
                    )
                  : AddUserImage(
                      onPressed: () async { 
                        await ImagePicker()
                            .pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50,
                        )
                            .then((value) {
                          if (value == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("No image was selected.")));
                          } else {
                            print("Uploading...");
                            context
                                .read<OnboardingBloc>()
                                .add(UpdateUserImages(image: value));
                          }
                          return null;
                        });
                      },
                    );
            },
          ),
        ),
      ],
    );
  }
}
