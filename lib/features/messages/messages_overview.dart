import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/image_path.dart';
import '../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';

class MessageOverview extends StatelessWidget {
  const MessageOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: CustomNavBar(title: "News"),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage(ImagesAsset.news_default),
                    )),
                XMargin(10.0),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TEAM UNILORIN THRIVE AT NUGA GAMES 2022 IN UNILAG",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Config.b3(context),
                      ),
                      YMargin(4),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Author: UnilorinSU",
                                  style: Config.b3(context).copyWith(
                                    color: ProbitasColor.ProbitasSecondary,
                                  ),
                                ),
                                YMargin(4),
                                Text(
                                  "MAY 12, 2022  4:14 PM",
                                  style: Config.b3(context).copyWith(
                                    color: ProbitasColor.ProbitasSecondary,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                Share.share('Great news');
                              },
                              tooltip: "Share",
                              icon: SvgPicture.asset(ImagesAsset.share,
                                  height: 18, width: 18),
                            ),
                          ])
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: Container(
              child: ListView(
                shrinkWrap: true,
                children: [
                  YMargin(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SelectableText(
                      """On behalf of all Unilorites, 
              we welcome Team Unilorin back from the NUGA Games 2022 which was hosted by University of Lagos. 
              Team Unilorin which has 213 athletes on board was able to finished 4th out of 73 Nigerian Universities that participated with 11 Gold medals, 12 Silver medals and 16 Bronze medals.The entirety of the Union is proud of the team members and we celebrate them on this great win. We equally wish them more wins in future endeavors.We also appreciate the teeming support of Unilorites who came from far and wide to support the team in Lagos.""",
                      style: Config.b2(context),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]));
  }
}
