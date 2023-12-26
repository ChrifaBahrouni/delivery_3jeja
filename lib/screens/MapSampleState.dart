import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
class MapSampleState extends StatefulWidget {
  const MapSampleState({super.key});

  @override
  State<MapSampleState> createState() => _MapSampleStateState();
}

class _MapSampleStateState extends State<MapSampleState> {
   //late MapclientBloc mapClientBloc;
  /*  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

      Set<Marker> markers = {
    Marker(
      markerId: MarkerId("marker1"),
      position: LatLng(37.7749, -122.4194),
      infoWindow: InfoWindow(
        title: 'San Francisco',
        snippet: 'La belle ville de la baie',
      ),
    ),
    Marker(
      markerId: MarkerId("marker2"),
      position: LatLng(37.7749, -122.4194),
      infoWindow: InfoWindow(
        title: 'San Francisco',
        snippet: 'La belle ville de la baie',
      ),
    ),
    // Ajoutez autant de marqueurs que nécessaire
  }; 
  */
  late GoogleMapController mapController;
  double _originLatitude = 35.825678180267246, _originLongitude = 10.589085478721694 ;
  double _destLatitude = 35.83316409660213, _destLongitude = 10.587418212487234;
 // 35.825678180267246, 10.589085478721694 
 // 35.83316409660213, 10.587418212487234 
  // double _originLatitude = 26.48424, _originLongitude = 50.04551;
  // double _destLatitude = 26.46423, _destLongitude = 50.06358;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyDH0_YP7NqI3wxvjrA9AhdCjfyWIYTOOQI";

  @override
  void initState() {
    super.initState();

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
    
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title:  Column(
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body:
             Stack(
               children: [
                GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(_originLatitude, _originLongitude), zoom: 15),
        myLocationEnabled: true,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: _onMapCreated,
        markers: Set<Marker>.of(markers.values),
        polylines: Set<Polyline>.of(polylines.values),
      ), 
               /*  GoogleMap(
                            mapType: MapType.normal,
                             initialCameraPosition: _kGooglePlex,
                             onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                             },
                            markers: markers,
                             polylines: Set<Polyline>.of(polylines.values) 
                           ),*/
                          
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
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'ID - 24457788',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                        const  SizedBox(
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
                  ?  const Color(0xFF1D2839) //const Color(0xFF321D0B)
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

             ),
       /* ],
      ),
      ),*/
    /*  floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),*/
    );
  }

  /*Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/
   Widget headerWidget(BuildContext context) {
    return Stack(
      children: [
       /*
       SizedBox(
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
                   const   SizedBox(
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
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'ID - 24457788',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                        const  SizedBox(
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
                  ? const Color(0xFF1D2839) //const Color(0xFF321D0B)
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

void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);

     if (result.points.isNotEmpty) {
    for (var point in result.points) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }

    _addPolyLine();
  }
  } 
}