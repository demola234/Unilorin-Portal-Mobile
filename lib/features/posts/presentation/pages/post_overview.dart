import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:probitas_app/core/utils/config.dart';
import 'package:probitas_app/features/posts/data/model/single_post.dart';
import 'package:probitas_app/features/posts/presentation/controller/post_controller.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_path.dart';
import '../../../../core/utils/components.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';
import '../provider/post_provider.dart';

class PostOverView extends ConsumerStatefulWidget {
  PostOverView({required this.singlePostId, Key? key}) : super(key: key);
  String singlePostId;

  @override
  ConsumerState<PostOverView> createState() => _PostOverViewState();
}

class _PostOverViewState extends ConsumerState<PostOverView> {
  int currentIndex = 0;
  late PageController controller;
  TextEditingController commentsController = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Posts"),
      ),
      body: SingleChildScrollView(
          child: ref.watch(getSinglePostProvider(widget.singlePostId)).when(
                data: (data) => Column(
                  children: [
                    YMargin(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.fitWidth,
                                imageUrl: data.data!.post!.user!.avatar!,
                              ),
                            ),
                          ),
                          XMargin(5),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 400,
                                  child: Text(
                                    data.data!.post!.user!.fullName!,
                                    style: Config.b2(context).copyWith(
                                        color: isDarkMode
                                            ? ProbitasColor.ProbitasTextPrimary
                                            : ProbitasColor.ProbitasPrimary),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                YMargin(2.0),
                                Text(
                                  data.data!.post!.user!.department!,
                                  style: Config.b2(context).copyWith(
                                    color: isDarkMode
                                        ? ProbitasColor.ProbitasTextPrimary
                                            .withOpacity(0.5)
                                        : ProbitasColor.ProbitasTextSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${data.data!.post!.user!.level!} Level",
                                  style: Config.b2(context).copyWith(
                                    color: isDarkMode
                                        ? ProbitasColor.ProbitasTextPrimary
                                            .withOpacity(0.5)
                                        : ProbitasColor.ProbitasTextSecondary,
                                    fontSize: 14.0,
                                  ),
                                ),
                                YMargin(2.0),
                                Text("Today, 02:34 PM",
                                    style: Config.b2(context).copyWith(
                                        color: isDarkMode
                                            ? ProbitasColor.ProbitasTextPrimary
                                                .withOpacity(0.5)
                                            : ProbitasColor.ProbitasPrimary,
                                        fontSize: 14.0))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    data.data!.post!.images!.isNotEmpty
                        ? Stack(
                            children: [
                              Container(
                                height: 220,
                                width: context.screenWidth(),
                                child: PageView.builder(
                                  controller: controller,
                                  physics: BouncingScrollPhysics(),
                                  onPageChanged: (int index) {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                  },
                                  itemCount: data.data!.post!.images!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            data.data!.post!.images![index],
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Positioned.fill(
                              //   bottom: 8.0,
                              //   child: Align(
                              //     alignment: Alignment.bottomCenter,
                              //     child: SmoothPageIndicator(
                              //       controller: controller,
                              //       count: currentIndex,
                              //       effect: ScrollingDotsEffect(
                              //         activeStrokeWidth: 2.6,
                              //         activeDotScale: 1.3,
                              //         maxVisibleDots: 5,
                              //         radius: 8,
                              //         spacing: 10,
                              //         activeDotColor: ProbitasColor.ProbitasSecondry,
                              //         dotColor: ProbitasColor.ProbitasTextPrimary,
                              //         dotHeight: 12,
                              //         dotWidth: 12,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Divider(),
                            ],
                          )
                        : SizedBox.shrink(),
                    YMargin(5),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                      child: SelectableText(
                        "${data.data!.post!.text}",
                        style: Config.b3(context).copyWith(fontSize: 14.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    ref
                                        .watch(postNotifierProvider.notifier)
                                        .likedOrUnlike(
                                            data.data!.post!.id!, true);
                                    ref.refresh(getSinglePostProvider(
                                        widget.singlePostId));
                                  },
                                  child: data.data!.post!.likes!
                                          .contains(data.data!.post!.user!.id)
                                      ? SvgPicture.asset(ImagesAsset.liked,
                                          height: 18, width: 18)
                                      : SvgPicture.asset(
                                          ImagesAsset.notliked,
                                          height: 18,
                                          width: 18,
                                          color: isDarkMode
                                              ? ProbitasColor
                                                  .ProbitasTextPrimary
                                              : ProbitasColor
                                                  .ProbitasTextSecondary,
                                        )),
                              XMargin(4),
                              Text(
                                "${data.data!.post!.likes!.length}",
                                style: Config.b3(context).copyWith(
                                  color: isDarkMode
                                      ? ProbitasColor.ProbitasTextPrimary
                                      : ProbitasColor.ProbitasTextSecondary,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              Share.share(data.data!.post!.text!);
                            },
                            tooltip: "Share",
                            icon: SvgPicture.asset(
                              ImagesAsset.share,
                              height: 18,
                              width: 18,
                              color: isDarkMode
                                  ? ProbitasColor.ProbitasTextPrimary
                                  : ProbitasColor.ProbitasPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    YMargin(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Add Comment",
                              textAlign: TextAlign.right,
                              style: Config.h3(context).copyWith(
                                fontSize: 19,
                              ),
                            ),
                          ),
                          YMargin(15),
                          ProbitasTextFormField(
                            controller: commentsController,
                            hintText: "Write a comment",
                          ),
                          YMargin(20),
                          Container(
                            width: context.screenWidth(),
                            child: ListView.builder(
                              itemCount: 10,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  width: context.screenWidth(),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: Border.all(
                                        color:
                                            ProbitasColor.ProbitasTextPrimary,
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              15.0))),
                                              child: Image(
                                                image: AssetImage(
                                                    ImagesAsset.default_image),
                                              ),
                                            ),
                                            XMargin(5),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    "Femi Ademola",
                                                    style: Config.b2(context).copyWith(
                                                        color: isDarkMode
                                                            ? ProbitasColor
                                                                .ProbitasTextPrimary
                                                            : ProbitasColor
                                                                .ProbitasPrimary),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                ),
                                                YMargin(2.0),
                                                Text("Microbiology",
                                                    style: Config.b2(context)
                                                        .copyWith(
                                                      color: isDarkMode
                                                          ? ProbitasColor
                                                                  .ProbitasTextPrimary
                                                              .withOpacity(0.5)
                                                          : ProbitasColor
                                                              .ProbitasTextSecondary,
                                                    )),
                                              ],
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text("Level 200",
                                                      style: Config.b2(context).copyWith(
                                                          color: isDarkMode
                                                              ? ProbitasColor
                                                                      .ProbitasTextPrimary
                                                                  .withOpacity(
                                                                      0.5)
                                                              : ProbitasColor
                                                                  .ProbitasTextSecondary,
                                                          fontSize: 14.0)),
                                                  YMargin(2.0),
                                                  Text("Today, 02:34 PM",
                                                      style: Config.b2(context)
                                                          .copyWith(
                                                              color: ProbitasColor
                                                                  .ProbitasPrimary,
                                                              fontSize: 14.0))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Divider(),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10.0),
                                          child: SelectableText(
                                            "In Flutter, the overflosssssw property of the Text, RichText, and DefaultTextStyle widgets specifies how ",
                                            style: Config.b3(context)
                                                .copyWith(fontSize: 14.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                    )
                  ],
                ),
                error: (err, str) => Center(child: Text("data")),
                loading: () => Center(child: CircularProgressIndicator()),
              )),
      floatingActionButton: InkWell(
        onTap: () {
          ref
              .watch(postNotifierProvider.notifier)
              .createComments(widget.singlePostId, commentsController.text);
          setState(() {
            commentsController.clear();
          });
        },
        child: Container(
          height: 70,
          width: 220,
          decoration: BoxDecoration(
              color: ProbitasColor.ProbitasSecondary,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Center(
            child: Text(
              "Add Comment",
              style: Config.b2(context).copyWith(
                color: ProbitasColor.ProbitasTextPrimary,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
