import 'package:adminetic_booking/core/exceptions/failure.dart';
import 'package:adminetic_booking/core/network/api_interface.dart';
import 'package:adminetic_booking/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:adminetic_booking/features/booking/data/models/booking_model.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/show_booking.dart';
import 'package:fpdart/src/either.dart';

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final ApiInterface _apiService;
  BookingRemoteDataSourceImpl({required ApiInterface apiService})
      : _apiService = apiService;
  @override
  Future<List<BookingModel>> all() {
    // TODO: implement all
    throw UnimplementedError();
  }

  @override
  Future<BookingModel> show(BookingParam params) {
    // TODO: implement show
    throw UnimplementedError();
  }
}
