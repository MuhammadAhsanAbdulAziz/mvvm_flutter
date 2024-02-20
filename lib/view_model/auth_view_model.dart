import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter/repository/auth_repository.dart';
import 'package:mvvm_flutter/utils/routes/routes_name.dart';
import 'package:mvvm_flutter/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _repository = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    try {
      final response = await _repository.loginApi(data);
      Utils.flushbarErrorMessage('login Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(response.toString());
      }
    } catch (error) {
      Utils.flushbarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    }
    setLoading(false);
  }
}
