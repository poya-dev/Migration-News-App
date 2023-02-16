abstract class NetworkEvent {}

class NetworkObserved extends NetworkEvent {}

class NetworkNotified extends NetworkEvent {
  final bool isConnected;

  NetworkNotified({this.isConnected = false});
}
