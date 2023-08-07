import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/constants/image_path.dart';
import 'package:probitas_app/core/utils/config.dart';
import 'dart:async';
import '../../../../core/utils/customs/custom_nav_bar.dart';
import '../../data/dark_mode.dart';

class Locations extends StatefulWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? newMapControler;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(8.480372, 4.675944),
    zoom: 18,
  );

  Set<Marker> _marker = {};

  onMapCreated(GoogleMapController controller) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomNavBar(title: "Locate Places"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              newMapControler = controller;

              isDarkMode ? darkModeMapFeature(controller) : null;
            },
            markers: {
              altMarker,
              sltMarker,
              eltMarker,
              lt1Marker,
              msltMarker,
              desmMarker
            },
          ),
          _buildContainer(),
          YMargin(20),
        ],
      ),
    );
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200.0,
        child: PageView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  ImagesAsset.nslt,
                  8.48208314244034,
                  4.676300336200427,
                  "Science Lecture Theater",
                  "Lecture Theater",
                  "SLT"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  ImagesAsset.nslt,
                  8.481935268625094,
                  4.673528025135144,
                  "Lecture Theatre I",
                  "Lecture Theater",
                  "LT1"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  ImagesAsset.nslt,
                  8.484244241568872,
                  4.67626633491362,
                  "Engineering Lecture Theater",
                  "Lecture Theater",
                  "ELT"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  ImagesAsset.nslt,
                  8.485491900257072,
                  4.677487756608535,
                  "Agriculture Lecture Theatre",
                  "Lecture Theater",
                  "ALT"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  ImagesAsset.nslt,
                  8.487776883238588,
                  4.67707806304939,
                  "Management Science Lecture Theatre",
                  "Lecture Theater",
                  "MSLT"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  ImagesAsset.nslt,
                  8.490538000989174,
                  4.676535505798677,
                  "Department of Estate Management",
                  "Department",
                  "ESM"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String lecture,
      String place, String lectureAbb) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
            width: context.screenWidth() - 60,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: ProbitasColor.ProbitasTextPrimary.withOpacity(0.6)),
              color: isDarkMode ? ProbitasColor.ProbitasPrimary : Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                XMargin(20),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.circular(24.0),
                  ),
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(24.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage(_image),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(lecture, place, lectureAbb),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget myDetailsContainer1(String lecture, String place, String lectureAbb) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 40),
          child: Container(
              child: Text(
            lecture,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: isDarkMode
                    ? ProbitasColor.ProbitasTextPrimary
                    : ProbitasColor.ProbitasSecondary,
                fontSize: 13.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        YMargin(15),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            lectureAbb,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: isDarkMode
                    ? ProbitasColor.ProbitasTextPrimary
                    : ProbitasColor.ProbitasSecondary,
                fontSize: 13.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        YMargin(15),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              SvgPicture.asset(
                ImagesAsset.lecture,
                height: 25,
                color: isDarkMode
                    ? ProbitasColor.ProbitasTextPrimary
                    : ProbitasColor.ProbitasSecondary,
              ),
              XMargin(5.0),
              Container(
                  child: Text(
                place,
                style: TextStyle(
                    // color: ProbitasColor.ProbitasSecondary,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Marker altMarker = new Marker(
    markerId: MarkerId("alt"),
    position: LatLng(8.485491900257072, 4.677487756608535),
    infoWindow: InfoWindow(title: "Agriculture Lecture Theatre"),
    icon: BitmapDescriptor.defaultMarker,
  );

  Marker sltMarker = new Marker(
    markerId: MarkerId("slt"),
    position: LatLng(8.48208314244034, 4.676300336200427),
    infoWindow: InfoWindow(title: "Science Lecture Theater(SLT)"),
    icon: BitmapDescriptor.defaultMarker,
  );

  Marker lt1Marker = new Marker(
    markerId: MarkerId("lt1"),
    position: LatLng(8.481935268625094, 4.673528025135144),
    infoWindow: InfoWindow(title: "Lecture Theatre I"),
    icon: BitmapDescriptor.defaultMarker,
  );

  Marker eltMarker = new Marker(
    markerId: MarkerId("elt"),
    position: LatLng(8.484244241568872, 4.67626633491362),
    infoWindow: InfoWindow(title: "Engineering Lecture Theater"),
    icon: BitmapDescriptor.defaultMarker,
  );

  Marker msltMarker = new Marker(
    markerId: MarkerId("mslt"),
    position: LatLng(8.487776883238588, 4.67707806304939),
    infoWindow: InfoWindow(title: "Management Science Lecture Theatre"),
    icon: BitmapDescriptor.defaultMarker,
  );

  Marker desmMarker = new Marker(
    markerId: MarkerId("desm"),
    position: LatLng(8.490538000989174, 4.676535505798677),
    infoWindow: InfoWindow(title: "Department of Estate Management"),
    icon: BitmapDescriptor.defaultMarker,
  );

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 18,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}
