import '../../../../core/constants/image_path.dart';

class OnboardModel {
  String img;
  String desc;

  OnboardModel({
    required this.img,
    required this.desc,
  });
}

List<OnboardModel> onboarding = <OnboardModel>[
  OnboardModel(
    img: ImagesAsset.student1,
    desc:
        "We have varieties of cars available for you\n with luxury features to ensure you have a \nperfect ride.",
  ),
  OnboardModel(
    img: ImagesAsset.student2,
    desc:
        "We have varieties of cars available for you\n with luxury features to ensure you have a \nperfect ride.",
  ),
  OnboardModel(
    img: ImagesAsset.student3,
    desc:
        "We have varieties of cars available for you\n with luxury features to ensure you have a \nperfect ride.",
  ),
];
