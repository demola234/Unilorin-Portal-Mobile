import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/config.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/customs/custom_appbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;

  @override
  void initState() {
    super.initState();
    _tabcontroller = new TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomAppbar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            YMargin(20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 100,
              width: context.screenWidth(),
              decoration: BoxDecoration(
                  color: ProbitasColor.ProbitasTextPrimary.withOpacity(0.5),
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Image(
                      image: AssetImage(ImagesAsset.default_image),
                    ),
                  ),
                  XMargin(20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Afternoon, Femi!",
                        style: Config.b2(context)
                            .copyWith(color: ProbitasColor.ProbitasPrimary),
                      ),
                      YMargin(2.0),
                      Text(
                        "You are in the Rain semester",
                        style: Config.b2(context).copyWith(
                            color: ProbitasColor.ProbitasTextSecondary),
                      ),
                    ],
                  ),
                  Spacer()
                ],
              ),
            ),
            YMargin(20),
            Row(
              children: [],
            ),
            YMargin(20),
            new TabBar(
                unselectedLabelColor: !isDarkMode
                    ? ProbitasColor.ProbitasTextSecondary
                    : ProbitasColor.ProbitasTextSecondary,
                labelColor: !isDarkMode
                    ? ProbitasColor.ProbitasPrimary
                    : ProbitasColor.ProbitasTextPrimary,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 13,
                ),
                physics: BouncingScrollPhysics(),
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: ProbitasColor.ProbitasTextPrimary,
                      width: 1.0,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 10.0)),
                indicatorWeight: 1,
                controller: _tabcontroller,
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
                    controller: _tabcontroller,
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      NoInvestmentYet(),
                      NoLoanYet(),
                      NoInvestmentYet(),
                      NoLoanYet(),
                      NoLoanYet(),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoInvestmentYet extends StatelessWidget {
  const NoInvestmentYet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NoLoanYet extends StatelessWidget {
  const NoLoanYet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
