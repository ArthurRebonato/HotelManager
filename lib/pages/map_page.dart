import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trabalho_g1/models/hotel_model.dart';
import 'package:trabalho_g1/repositories/hotel_repository.dart';
import 'package:trabalho_g1/my_globals.dart' as globals;

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  final _repository = HotelRepository(Dio());

  final LatLng _center = LatLng(double.parse(globals.lat[globals.idHotel]),
      double.parse(globals.lon[globals.idHotel]));

  void showDetails(String id) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: FutureBuilder<HotelModel>(
              future: _repository.findById(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                      height: 50,
                      child: Center(child: CircularProgressIndicator()));
                }

                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final hotel = snapshot.data;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                          leading: const Icon(
                            Icons.house,
                            color: Colors.green,
                            size: 40,
                          ),
                          trailing: Text(
                            hotel!.rating.toStringAsFixed(1),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          isThreeLine: true,
                          title: Text(
                            hotel.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              '${hotel.address}\n${hotel.description}\n${hotel.status}')),
                    ],
                  );
                }
                return Container();
              },
            ),
          );
        });
  }

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }

  pfHotelMarkerFunction(int i){
    int idHotelMock = i + 1;
    return Marker(
      markerId: MarkerId(globals.nomesHotel[i]),
      infoWindow: InfoWindow(title: globals.nomesHotel[i]),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(double.parse(globals.lat[i]), double.parse(globals.lon[i])),
      onTap: () => (
          showDetails(idHotelMock.toString())
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mapa'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => {
              Navigator.pop(context)
            }
          ),
        ),
        body: GoogleMap(
            mapType: MapType.normal,
            markers: {
              pfHotelMarkerFunction(0),
              pfHotelMarkerFunction(1),
              pfHotelMarkerFunction(2),
              pfHotelMarkerFunction(3),
              pfHotelMarkerFunction(4),
              pfHotelMarkerFunction(5),
              pfHotelMarkerFunction(6),
              pfHotelMarkerFunction(7),
              pfHotelMarkerFunction(8),
              pfHotelMarkerFunction(9),
              pfHotelMarkerFunction(10),
              pfHotelMarkerFunction(11),
              pfHotelMarkerFunction(12),
              pfHotelMarkerFunction(13),
              pfHotelMarkerFunction(14),
              pfHotelMarkerFunction(15),
              pfHotelMarkerFunction(16),
              pfHotelMarkerFunction(17),
              pfHotelMarkerFunction(18),
              pfHotelMarkerFunction(19),
            },
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            onMapCreated: _onMapCreated,
        ),
        ),
    );
  }
}
