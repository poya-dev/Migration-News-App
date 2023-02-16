import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/network_helper.dart';
import './network_event.dart';
import './network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc._() : super(NetworkInitial()) {
    on<NetworkObserved>(_onObserved);
    on<NetworkNotified>(_onNotifiedStatus);
  }

  static final NetworkBloc _instance = NetworkBloc._();

  factory NetworkBloc() => _instance;

  void _onObserved(event, emit) {
    NetworkHelper.observeNetwork();
  }

  void _onNotifiedStatus(NetworkNotified event, emit) {
    event.isConnected ? emit(NetworkSuccess()) : emit(NetworkFailure());
  }
}
