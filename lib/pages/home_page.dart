import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_g1/models/hotel_model.dart';
import 'package:trabalho_g1/repositories/hotel_repository.dart';
import 'package:trabalho_g1/pages/map_page.dart';
import 'package:trabalho_g1/my_globals.dart' as globals;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _repository = HotelRepository(Dio());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter - Trabalho G1'),
          centerTitle: true,
        ),
        body: FutureBuilder<List<HotelModel>>(
          future: _repository.findAll(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final hotels = snapshot.data;

              return ListView.builder(
                itemCount: hotels!.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];

                  globals.nomesHotel.add(hotel.name);
                  globals.descricoesHotel.add(hotel.description);
                  globals.lat.add(hotel.lat);
                  globals.lon.add(hotel.lon);

                  return Card(
                    child: ListTile(
                      onTap: () => showDetails(hotel.id),
                      leading: const Icon(
                        Icons.house,
                        color: Colors.green,
                        size: 40,
                      ),
                      trailing: Text(
                        hotel.rating.toStringAsFixed(1),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      title: Text(hotel.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(hotel.address),
                    ),
                  );
                },
              );
            }

            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            globals.idHotel = 0;
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MapPage()));
          },
          label: const Text('Mapa'),
          icon: const Icon(Icons.map_outlined),
          backgroundColor: Colors.orangeAccent,
        ),
    );
  }

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
                              '${hotel.description}\n${hotel.status}')),
                      FloatingActionButton.extended(
                        onPressed: () {
                          globals.idHotel = int.parse(id) - 1;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const MapPage()));
                        },
                        label: const Text('Localização Mapa'),
                        icon: const Icon(Icons.map_outlined),
                        backgroundColor: Colors.orangeAccent,
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          );
        });
  }
}
