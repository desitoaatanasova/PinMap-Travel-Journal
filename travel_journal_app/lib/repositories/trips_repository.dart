import '../models/trip.dart';

abstract class TripsRepository {
  Future<List<Trip>> getAllTrips();
  Future<Trip?> getTripById(String id);
  Future<void> addTrip(Trip trip);
  Future<void> deleteTrip(String id);
}
