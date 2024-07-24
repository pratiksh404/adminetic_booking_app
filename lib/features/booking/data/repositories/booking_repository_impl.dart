import 'package:adminetic_booking/core/exceptions/failure.dart';
import 'package:adminetic_booking/core/exceptions/server_exception.dart';
import 'package:adminetic_booking/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/domain/repositories/booking_repository.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/all_booking_params.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/booking_params.dart';

import 'package:fpdart/src/either.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource bookingRemoteDataSource;
  BookingRepositoryImpl({required this.bookingRemoteDataSource});
  @override
  Future<Either<Failure, List<Booking>>> all(AllBookingParams params) async {
    try {
      final List<Booking> bookings = await bookingRemoteDataSource.all(params);
      return Right(bookings);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Booking>> show(BookingParam params) async {
    try {
      final Booking booking = await bookingRemoteDataSource.show(params);
      return Right(booking);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
