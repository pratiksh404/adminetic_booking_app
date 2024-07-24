// ignore_for_file: public_member_api_docs, sort_constructors_first
class AllBookingParams {
  final String? status;

  AllBookingParams({this.status});

  AllBookingParams copyWith({
    String? status,
  }) {
    return AllBookingParams(
      status: status ?? this.status,
    );
  }
}
