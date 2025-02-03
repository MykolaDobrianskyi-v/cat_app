import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkHelper {
  Future<bool> hasInternet() async {
    final result = await Connectivity().checkConnectivity();
    return result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile);
  }
}
