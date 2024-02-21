import 'package:flutter/material.dart';
import 'package:mvvm_flutter/res/components/round_button.dart';
import 'package:mvvm_flutter/utils/routes/routes_name.dart';
import 'package:mvvm_flutter/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: RoundButton(
                title: 'logout',
                loading: userViewModel.loading,
                onPress: () async {
                  bool user = await userViewModel.removeUser();
                  if (user) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutesName.login,
                      (route) {
                        return false;
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
