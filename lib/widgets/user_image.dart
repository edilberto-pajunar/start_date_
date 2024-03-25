import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class UserImage extends StatelessWidget {
  final String? url;
  final double height;
  final double width;
  final EdgeInsets? margin;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final Widget? child;

  const UserImage.large({
    super.key,
    this.url,
    this.height = double.infinity,
    this.width = double.infinity,
    this.margin,
    this.boxShadow,
    this.border,
    this.child,
  });

  const UserImage.medium({
    super.key,
    this.url,
    this.height = 200,
    this.width = double.infinity,
    this.margin,
    this.boxShadow,
    this.border,
    this.child,
  });

  const UserImage.small({
    super.key,
    this.url,
    this.height = 60,
    this.width = 60,
    this.margin,
    this.boxShadow,
    this.border,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: (url == null)
              ? const AssetImage("assets/images/start.png") as ImageProvider
              : NetworkImage(url!),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        border: border,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
