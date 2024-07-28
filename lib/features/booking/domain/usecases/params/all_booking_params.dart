// ignore_for_file: public_member_api_docs, sort_constructors_first
class AllBookingParams {
  final String? status;
  final String? search;

  AllBookingParams({this.status, this.search});

  AllBookingParams copyWith({
    String? status,
    String? search,
  }) {
    return AllBookingParams(
      status: status ?? this.status,
      search: search ?? this.search,
    );
  }
}
