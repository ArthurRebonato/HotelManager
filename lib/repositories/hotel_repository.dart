import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:trabalho_g1/models/hotel_model.dart';

part 'hotel_repository.g.dart';

@RestApi(baseUrl: 'https://6446d42bee791e1e290a1276.mockapi.io/api/')
abstract class HotelRepository {
  factory HotelRepository(Dio dio, {String baseUrl}) = _HotelRepository;

  @GET('/hotels')
  Future<List<HotelModel>> findAll();

  @GET('/hotels/{id}')
  Future<HotelModel> findById(@Path('id') String id);
}
