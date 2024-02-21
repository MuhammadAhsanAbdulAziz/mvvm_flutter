import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter/model/user_request.dart';
import 'package:mvvm_flutter/model/user_response.dart';
import 'package:mvvm_flutter/repository/auth_repository.dart';
import 'package:mvvm_flutter/utils/routes/routes_name.dart';
import 'package:mvvm_flutter/utils/utils.dart';
import 'package:mvvm_flutter/view_model/user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  final _authRepository = AuthRepository();
  final _userViewModel = UserViewModel();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(UserRequest user, BuildContext context) async {
    setLoading(true);
    try {
      final response = await _authRepository.loginApi(user);
      final userResponse = UserResponse.fromJson(response);

      await _userViewModel.saveUser(userResponse);
      Utils.flushbarErrorMessage('login Successfully', context);
      Navigator.pushReplacementNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(response.toString());
        print(_userViewModel.getUser());
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
