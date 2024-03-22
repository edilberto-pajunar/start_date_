part of 'images_bloc.dart';

sealed class ImagesEvent extends Equatable {
  const ImagesEvent();

  @override
  List<Object> get props => [];
}

class LoadImages extends ImagesEvent {}

class UpdateImages extends ImagesEvent {
  final List<dynamic> imageUrls;

  const UpdateImages({
    required this.imageUrls,
  });

  @override
  List<Object> get props => [imageUrls];
}
