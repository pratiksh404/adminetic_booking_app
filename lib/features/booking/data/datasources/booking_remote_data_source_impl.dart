import 'package:adminetic_booking/core/exceptions/server_exception.dart';
import 'package:adminetic_booking/core/helpers/typedefs.dart';
import 'package:adminetic_booking/core/network/api_interface.dart';
import 'package:adminetic_booking/core/network/endpoints/booking_endpoint.dart';
import 'package:adminetic_booking/core/network/response_model.dart';
import 'package:adminetic_booking/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:adminetic_booking/features/booking/data/models/booking_model.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/all_booking_params.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/booking_params.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/booking_status_params.dart';

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final ApiInterface _apiService;

  BookingRemoteDataSourceImpl({required ApiInterface apiService})
      : _apiService = apiService;

  @override
  Future<List<BookingModel>> all(AllBookingParams params) async {
    final JSON queryParams = {};
    if (params.status != null) {
      queryParams['status'] = params.status;
    }
    final ResponseModel responseModel = await _apiService.all(
      endPoint: BookingEndpoint.bookings,
      queryParams: queryParams,
    );
    if (responseModel.data != null) {
      try {
        final List<BookingModel> bookings =
            responseModel.data.map<BookingModel>((booking) {
          return BookingModel.fromMap(booking);
        }).toList();
        return bookings;
      } catch (e) {
        throw ServerException(message: e.toString());
      }
    } else {
      throw ServerException(message: responseModel.message);
    }
  }

  @override
  Future<BookingModel> show(BookingParam params) {
    // TODO: implement show
    throw UnimplementedError();
  }

  @override
  Future<void> setBookingStatus(BookingStatusParams params) async {
    try {
      final Booking booking = params.booking;
      final status = params.status;

      await _apiService.get(
        endPoint: '/bookings/${booking.id}/setStatus',
        queryParams: {'status': status},
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
