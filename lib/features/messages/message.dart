import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/navigation_service.dart';

import '../../core/constants/colors.dart';
import '../../core/utils/config.dart';
import '../../core/utils/customs/custom_appbar.dart';
import '../../core/utils/customs/custom_drawers.dart';
import 'messages_overview.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              YMargin(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "News",
                    style: Config.h3(context).copyWith(
                      color: ProbitasColor.ProbitasPrimary,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: LiquidPullToRefresh(
                    key: _refreshIndicatorKey,
                    onRefresh: _handleRefresh,
                    color: ProbitasColor.ProbitasSecondary,
                    backgroundColor: ProbitasColor.ProbitasTextPrimary,
                    animSpeedFactor: 5,
                    showChildOpacityTransition: true,
                    child: Container(
                      width: context.screenWidth(),
                      child: ListView.builder(
                          itemCount: 200,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                NavigationService()
                                    .navigateToScreen(MessageOverview());
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                width: context.screenWidth(),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  border: Border.all(
                                    color: ProbitasColor.ProbitasSecondary,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0, vertical: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                    ImagesAsset.news_default),
                                              )),
                                          XMargin(10.0),
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "TEAM UNILORIN THRIVE AT NUGA GAMES 2022 IN UNILAG",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Config.b3(context),
                                                ),
                                                Text(
                                                  "3 weeks ago",
                                                  style: Config.b3(context)
                                                      .copyWith(
                                                    color: ProbitasColor
                                                        .ProbitasSecondary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 10),
                                        child: Text(
                                          "On behalf of all Unilorites, we welcome Team Unilorin back from the NUGA Games 2022 which was.....  Read more",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: Config.b3(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )),
              )
            ],
          ),
        ));
  }
}
