class Address {
  Address(
      {required this.latitude, required this.longitude, required this.address});
  final double latitude;
  final double longitude;
  final String address;

  static Address getDummyAddress() {
    return Address(
        latitude: 27.123123,
        longitude: 81.123123,
        address: 'Glocuster road, Hurstville, 2220');
  }
}
