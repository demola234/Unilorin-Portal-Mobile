import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:probitas_app/core/utils/config.dart';
import 'package:probitas_app/core/utils/customs/custom_drawers.dart';
import 'package:probitas_app/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:probitas_app/features/dashboard/presentation/pages/manage_schedules.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_path.dart';
import '../../../../core/utils/customs/custom_appbar.dart';
import '../../../../core/utils/greetings.dart';
import '../../../../core/utils/image_viewer.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../core/utils/shimmer_loading.dart';
import '../widget/weekdays/friday.dart';
import '../widget/weekdays/monday.dart';
import '../widget/weekdays/thursday.dart';
import '../widget/weekdays/tuesday.dart';
import '../widget/weekdays/wed.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(getUsersProvider);
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            YMargin(20),
            Consumer(
              builder: ((context, watch, child) {
                return value.when(
                  data: (data) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 100,
                      width: context.screenWidth(),
                      decoration: BoxDecoration(
                          color: ProbitasColor.ProbitasTextPrimary.withOpacity(
                              0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            child: GestureDetector(
                              onTap: () {
                                ImageViewUtils.showImagePreview(
                                    context, [data.data!.user!.avatar!]);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fitWidth,
                                  imageUrl: data.data!.user!.avatar!,
                                ),
                              ),
                            ),
                          ),
                          XMargin(20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getGreetings()}, ${data.data!.user!.fullName!.split(" ")[1]}👋🏾",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Config.b2(context).copyWith(
                                    color: isDarkMode
                                        ? Colors.white
                                        : ProbitasColor.ProbitasPrimary),
                              ),
                              YMargin(5.0),
                              Text(
                                "You are in the ${data.data!.user!.semester!.type} Semester",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Config.b2(context).copyWith(
                                    color: isDarkMode
                                        ? ProbitasColor.ProbitasTextPrimary
                                        : ProbitasColor.ProbitasTextSecondary),
                              ),
                            ],
                          ),
                          Spacer()
                        ],
                      )),
                  loading: () {
                    return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 100,
                        width: context.screenWidth(),
                        decoration: BoxDecoration(
                            color:
                                ProbitasColor.ProbitasTextPrimary.withOpacity(
                                    0.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 60,
                                  height: 60,
                                  child: Loading(
                                    height: 60,
                                    width: 60,
                                  )),
                              XMargin(20),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Loading(
                                      height: 20,
                                      width: 200,
                                    ),
                                    YMargin(5.0),
                                    Loading(
                                      height: 20,
                                      width: 200,
                                    )
                                  ]),
                            ]));
                  },
                  error: (err, str) {
                    return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 100,
                        width: context.screenWidth(),
                        decoration: BoxDecoration(
                            color:
                                ProbitasColor.ProbitasTextPrimary.withOpacity(
                                    0.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                         
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Failed to Get Details",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Config.b3(context).copyWith(
                                          color: isDarkMode
                                              ? Colors.white
                                              : ProbitasColor.ProbitasPrimary),
                                    ),
                                    YMargin(10.0),
                                    InkWell(
                                      onTap: () {
                                        ref.refresh(getUsersProvider);
                                        ref.refresh(getSchedulesProvider);
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0))),
                                        child: Center(
                                            child: Text("Tap to Retry",
                                                style:
                                                    Config.b3(context).copyWith(
                                                  color: ProbitasColor
                                                      .ProbitasPrimary,
                                                ))),
                                      ),
                                    ),
                                  ]),
                            ]));
                  },
                );
              }),
            ),
            YMargin(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Schedule",
                  style: Config.h3(context).copyWith(
                    color: isDarkMode
                        ? ProbitasColor.ProbitasTextPrimary
                        : ProbitasColor.ProbitasPrimary,
                    fontSize: 18,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  child: InkWell(
                    onTap: () {
                      NavigationService().navigateToScreen(ManageSchedule());
                    },
                    child: Container(
                      height: 35,
                      width: 130,
                      decoration: BoxDecoration(
                          color: ProbitasColor.ProbitasSecondary,
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      child: Center(
                          child: Text("Manage Schedule",
                              style: Config.b3(context).copyWith(
                                color: ProbitasColor.ProbitasTextPrimary,
                              ))),
                    ),
                  ),
                )
              ],
            ),
            YMargin(30),
            new TabBar(
                unselectedLabelColor: ProbitasColor.ProbitasTextSecondary,
                labelColor: !isDarkMode
                    ? ProbitasColor.ProbitasPrimary
                    : ProbitasColor.ProbitasTextPrimary,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 13,
                ),
                physics: BouncingScrollPhysics(),
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: isDarkMode
                          ? ProbitasColor.ProbitasTextPrimary
                          : ProbitasColor.ProbitasTextSecondary,
                      width: 1.0,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 10.0)),
                indicatorWeight: 1,
                controller: _controller,
                isScrollable: true,
                tabs: [
                  new Tab(
                    text: 'Monday',
                  ),
                  new Tab(
                    text: 'Tuesday',
                  ),
                  new Tab(
                    text: 'Wednesday',
                  ),
                  new Tab(
                    text: 'Thursday',
                  ),
                  new Tab(
                    text: 'Friday',
                  ),
                ]),
            const YMargin(25),
            Expanded(
              child: Container(
                width: context.screenWidth(),
                height: context.screenHeight(),
                decoration: BoxDecoration(),
                child: TabBarView(
                    controller: _controller,
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      Monday(),
                      Tuesday(),
                      Wednesday(),
                      Thursday(),
                      Friday(),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
