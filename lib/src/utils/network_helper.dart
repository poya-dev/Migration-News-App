import 'package:connectivity_plus/connectivity_plus.dart';

import '../blocs/network/network_event.dart';
import '../blocs/network/network_bloc.dart';

class NetworkHelper {
  static void observeNetwork() {
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          NetworkBloc().add(NetworkNotified());
        } else {
          NetworkBloc().add(NetworkNotified(isConnected: true));
        }
      },
    );
  }
}
