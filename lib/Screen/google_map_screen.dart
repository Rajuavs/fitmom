
import 'package:fitmom/Widgest/customThemeButton.dart';
import 'package:fitmom/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key, required this.latlng, required this.ontap});
  final LatLng? latlng;
  final Function(dynamic) ontap;

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  double latitude = 0;
  double longitude = 0;
  // late final GoogleMapController _googleMapController;

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
    TextEditingController locationController = TextEditingController();


  get defaultPosition => CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 12,
      );
  @override
  void initState() {
    latitude = widget.latlng?.latitude ?? 12.919;
    longitude = widget.latlng?.longitude ?? 77.58;
    super.initState();

    if (widget.latlng == null) {
      getCurrentLocation();
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: GoogleMap(
              initialCameraPosition: defaultPosition,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onTap: (v) {
                setState(() {
                  latitude = v.latitude;
                  longitude = v.longitude;
                });
              },
              markers: {
                Marker(
                    markerId: MarkerId("fitmommark"),
                    position: LatLng(latitude, longitude),
                    icon: markerIcon,
                    draggable: true,
                    onDragEnd: (v) {
                      setState(() {
                        latitude = v.latitude;
                        longitude = v.longitude;
                      });
                    }),
              },
            ),
          ),
          SafeArea(
              child: Container(
                  width: double.maxFinite,
                  height: 20,
                  color: appLightColor,
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "Select Your Location",
                    style: TextStyle(
                        backgroundColor: appLightColor,
                        color: appThemeColor,
                        fontWeight: FontWeight.w300),
                  ))),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: CustomTheemButton(buttonText: "Select Location",ontap: (){
          widget.ontap(LatLng(latitude, longitude));
        },),
      ),
    );
  }

  Position? position;
  List<Placemark>? placeMarks;

  getCurrentLocation() async {
    // ignore: unused_local_variable
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    position = newPosition;

    placeMarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);

    Placemark pMark = placeMarks![0];
    String completeAddress =
        "${placeMarks![0].subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea}, ${pMark.postalCode},${pMark.country}";

    locationController.text = completeAddress;
  }
}
