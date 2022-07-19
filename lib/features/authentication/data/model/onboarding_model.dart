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
        "Welcome to Probitas,\n Our goal is to make the lives of unilorin\n students easier.",
  ),
  OnboardModel(
    img: ImagesAsset.student2,
    desc:
        "Get access to class Free Books, Hand-outs, Textbooks, Assignments and\n Other materials.",
  ),
  OnboardModel(
    img: ImagesAsset.student3,
    desc:
        "Create and Share your thoughts with you class mates and school mates\n on our feeds page.",
  ),
];
