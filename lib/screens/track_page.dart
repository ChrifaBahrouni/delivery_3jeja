import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class TrackPage extends StatefulWidget {
  //static const String routeName = '/order-accepted';

  const TrackPage({super.key});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: sourceLocation, zoom: 14.5),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            // headerWidget(context),
          ],
        ),
      ),
    );
  }

  Widget headerWidget(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: sourceLocation, zoom: 14.5),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        /* SizedBox(
          child: Image.asset(
            'assets/images/map.png',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
        ),
        Container(
          height: 100,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),*/
        Positioned(
          right: 0,
          top: 50,
          left: 0,
          child: Column(
            children: [
              Text(
                'Starbucks - CSB Mall',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'Distance from you: 1.2 km',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 55,
          left: 15,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                margin: const EdgeInsets.all(8),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 150,
          left: 0,
          child: Container(
            height: 100,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/1.jpeg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rifqi Arkaanul',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'ID - 24457788',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Coffee Courier',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontSize: 10,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9314),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 50,
          left: 0,
          child: Container(
            height: 75,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Color(0xFF1D2839) //const Color(0xFF321D0B)
                  : const Color(0xFFFF9314),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Code   : 267890-2',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      'Arrived Time : 15 Min',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'View',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
