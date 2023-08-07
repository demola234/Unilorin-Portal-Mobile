import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/components.dart';
import 'package:probitas_app/core/utils/navigation_service.dart';
import 'package:probitas_app/features/dashboard/presentation/widget/empty_state/empty_state.dart';
import 'package:probitas_app/features/resources/data/model/resource_response.dart';
import 'package:probitas_app/features/resources/presentation/pages/download_screen.dart';
import 'package:probitas_app/features/resources/presentation/pages/pdf_viewer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_appbar.dart';
import '../../../../core/utils/customs/custom_drawers.dart';
import '../../../../core/utils/customs/custom_error.dart';
import '../../../dashboard/presentation/controller/dashboard_controller.dart';
import '../controller/resource_controller.dart';
import '../provider/resources_provider.dart';
import 'package:probitas_app/core/utils/states.dart';
import 'add_resources.dart';

class Resources extends StatefulHookConsumerWidget {
  const Resources({Key? key}) : super(key: key);

  @override
  ConsumerState<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends ConsumerState<Resources> {
  TextEditingController searchController = TextEditingController();

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  @override
  Widget build(BuildContext context) {
    final resourcesNotifier = ref.watch(resourcesNotifierProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      key: _key,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomAppbar(
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
      ),
      drawer: ProbitasDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(children: [
          YMargin(10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Resources",
              style: Config.h3(context).copyWith(
                color: isDarkMode
                    ? ProbitasColor.ProbitasTextPrimary
                    : ProbitasColor.ProbitasPrimary,
                fontSize: 18,
              ),
            ),
          ]),
          YMargin(10),
          Row(
            children: [
              Flexible(
                child: ProbitasTextFormField(
                  controller: searchController,
                  onChanged: (v) {
                    setState(() {
                      v = searchController.text;
                    });
                  },
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search for Pdf, Past Questions, etc...",
                ),
              ),
            ],
          ),
          YMargin(15),
          searchController.text.isEmpty
              ? Builder(builder: (context) {
                  if (resourcesNotifier.viewState.isLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: ProbitasColor.ProbitasSecondary,
                    ));
                  } else if (resourcesNotifier.viewState.isError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView(
                          shrinkWrap: true,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  ErrorsWidget(
                                    onTap: () => ref
                                        .refresh(
                                            resourcesNotifierProvider.notifier)
                                        .getResource(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Expanded(
                      child: LiquidPullToRefresh(
                          key: _refreshIndicatorKey,
                          color: ProbitasColor.ProbitasSecondary,
                          backgroundColor: ProbitasColor.ProbitasTextPrimary,
                          animSpeedFactor: 5,
                          showChildOpacityTransition: false,
                          onRefresh: () => ref
                              .refresh(resourcesNotifierProvider.notifier)
                              .getResource(),
                          child: Builder(builder: (context) {
                            if (resourcesNotifier.viewState.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: ProbitasColor.ProbitasSecondary,
                              ));
                            } else if (resourcesNotifier.viewState.isError) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Center(
                                        child: Column(
                                          children: [
                                            ErrorsWidget(
                                              onTap: () => ref
                                                  .refresh(
                                                      resourcesNotifierProvider
                                                          .notifier)
                                                  .getResource(),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return ResourceItems(
                                  resourceNotifier: resourcesNotifier);
                            }
                          })),
                    );
                  }
                })
              : Expanded(
                  child: Container(
                      height: context.screenHeight(),
                      width: context.screenWidth(),
                      child: ref
                          .watch(getResourcesSearchedNotifier(
                              searchController.text))
                          .when(
                              data: (data) => ListView.builder(
                                  itemCount: data.data!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final response = data.data![index];
                                    return ResourceTile(response: response);
                                  }),
                              error: (err, _) => SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Center(
                                                child: EmptyState(
                                              text: "No Resource Found",
                                            ))),
                                      ],
                                    ),
                                  ),
                              loading: () => SingleChildScrollView(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                  color: ProbitasColor
                                                      .ProbitasSecondary),
                                            ))
                                      ]))))),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationService().navigateToScreen(AddResources());
        },
        backgroundColor: ProbitasColor.ProbitasSecondary,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ResourceItems extends StatefulHookConsumerWidget {
  ResourceItems({
    Key? key,
    required this.resourceNotifier,
  }) : super(key: key);

  final ResourceState resourceNotifier;

  @override
  ConsumerState<ResourceItems> createState() => _ResourceItemsState();
}

class _ResourceItemsState extends ConsumerState<ResourceItems> {
  final controller = RefreshController();
  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    useEffect(() {
      void scrollListener() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          ref.watch(resourcesNotifierProvider.notifier).getResource();
        }
      }

      scrollController.addListener(scrollListener);

      return () => scrollController.removeListener(scrollListener);
    }, [scrollController]);

    return ListView.builder(
        itemCount: widget.resourceNotifier.resource!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == widget.resourceNotifier.resource!.length - 1 &&
              widget.resourceNotifier.moreDataAvailable) {}
          final response = widget.resourceNotifier.resource![index];
          return ResourceTile(response: response);
        });
  }
}

class ResourceTile extends ConsumerStatefulWidget {
  final Datum? response;

  ResourceTile({
    required this.response,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ResourceTile> createState() => _ResourceTileState();
}

class _ResourceTileState extends ConsumerState<ResourceTile> {
  bool isLoading = false;
  late Dio dio;
  late String progress;
  // ignore: unused_field
  String? _fileFullPath;

  @override
  void initState() {
    dio = Dio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getUser = ref.watch(getUsersProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<Null>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Container(
              height: context.screenHeight() / 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Column(
                children: [
                  YMargin(5),
                  Container(
                      height: 6,
                      width: context.screenWidth() / 3.5,
                      decoration: BoxDecoration(
                          color: ProbitasColor.ProbitasTextPrimary.withOpacity(
                              0.7),
                          borderRadius: BorderRadius.circular(5.0))),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 70.0,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: getResourceIcon(),
                        ),
                        XMargin(15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            YMargin(2.0),
                            Text(
                              widget.response!.courseTitle!,
                              style: Config.b2(context).copyWith(
                                // color: ProbitasColor.ProbitasPrimary,
                                fontSize: 12,
                              ),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    "By ${widget.response!.user!.fullName!.split(" ")[0]} ${widget.response!.user!.fullName!.split(" ")[1]}",
                                    style: Config.b2(context).copyWith(
                                      // color: ProbitasColor.ProbitasPrimary,
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: false,
                                isDismissible: false,
                                context: context,
                                builder: (context) => DownloadScreen(
                                      url: widget.response!.file!,
                                      title: widget.response!.courseTitle!,
                                    ));
                          },
                          icon: SvgPicture.asset(ImagesAsset.download,
                              color: isDarkMode
                                  ? ProbitasColor.ProbitasTextSecondary
                                  : ProbitasColor.ProbitasSecondary),
                        )
                      ],
                    ),
                  ),
                  YMargin(30),
                  widget.response!.file!.split(".").last.toLowerCase() == "pdf"
                      ? ProbitasButton(
                          onTap: () {
                            NavigationService().navigateToScreen(PDFViewer(
                              path: widget.response!.file!,
                            ));
                          },
                          text: "View Material")
                      : SizedBox.shrink(),
                  Spacer(),
                  getUser.when(
                    data: (data) => data.data!.user!.user!.id ==
                            widget.response!.user!.id
                        ? ProbitasDeleteButton(
                            text: "Delete Material",
                            onTap: () {
                              ref.read(
                                  deleteResourceProvider(widget.response!.id!));
                              Navigator.pop(context);
                              Future.delayed(const Duration(seconds: 3), () {
                                ref
                                    .refresh(resourcesNotifierProvider.notifier)
                                    .getResource();
                              });
                            })
                        : Container(),
                    loading: () => Container(),
                    error: (str, err) => Container(),
                  ),
                  Spacer(),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        height: 120,
        width: context.screenWidth(),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
                color: isDarkMode
                    ? ProbitasColor.ProbitasTextPrimary
                    : ProbitasColor.ProbitasSecondary.withOpacity(0.4))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70.0,
                height: 100,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                child: getResourceIcon(),
              ),
              XMargin(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  YMargin(2.0),
                  Text(
                    widget.response!.courseTitle!,
                    style: Config.b2(context).copyWith(
                      fontSize: 12,
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          "By ${widget.response!.user!.fullName!.split(" ")[0]} ${widget.response!.user!.fullName!.split(" ")[1]}",
                          style: Config.b2(context).copyWith(
                            fontSize: 12,
                          )),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  getResourceIcon() {
    if (widget.response!.file!.split(".").last.toLowerCase() == "pdf") {
      return SvgPicture.asset(ImagesAsset.pdf);
    } else if (widget.response!.file!.split(".").last.toLowerCase() == "png") {
      return SvgPicture.asset(ImagesAsset.png);
    } else if (widget.response!.file!.split(".").last.toLowerCase() == "jpg") {
      return SvgPicture.asset(ImagesAsset.jpg);
    } else if (widget.response!.file!.split(".").last.toLowerCase() == "jpeg") {
      return SvgPicture.asset(ImagesAsset.jpg);
    } else if (widget.response!.file!.split(".").last.toLowerCase() == "doc") {
      return SvgPicture.asset(ImagesAsset.doc);
    } else if (widget.response!.file!.split(".").last.toLowerCase() == "docx") {
      return SvgPicture.asset(ImagesAsset.doc);
    } else if (widget.response!.file!.split(".").last.toLowerCase() == "xls") {
      return SvgPicture.asset(ImagesAsset.xls);
    } else if (widget.response!.file!.split(".").last.toLowerCase() == "webp") {
      return SvgPicture.asset(ImagesAsset.doc);
    } else if (widget.response!.file!.split(".").last.toLowerCase() == "xlsx") {
      return SvgPicture.asset(ImagesAsset.xls);
    } else if (widget.response!.file!.split(".").last.toLowerCase() == "pptx") {
      return SvgPicture.asset(ImagesAsset.ppt);
    } else if (widget.response!.file!.split(".").last.toLowerCase() == "ppt") {
      return SvgPicture.asset(ImagesAsset.ppt);
    } else {
      return SvgPicture.asset(ImagesAsset.file);
    }
  }
}
