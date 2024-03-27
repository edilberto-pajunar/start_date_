import 'package:start_date/models/location_model.dart';

abstract class BaseLocationRepository {
  Future<Location> getLocation(String location);
}
