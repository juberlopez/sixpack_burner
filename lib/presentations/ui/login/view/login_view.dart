import 'package:burnet_stack/presentations/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:burnet_stack/presentations/ui/login/widgets/form_login.dart';
import 'package:burnet_stack/presentations/ui/register/view/register_view.dart';
import 'package:burnet_stack/presentations/ui/theme/app_theme.dart';
import 'package:burnet_stack/presentations/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  static final String routeName = 'login_View';
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    stops: [
                      0.0,
                      1,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppTheme.primarylinearGradiant),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/splash/logo.png',
                    //width: 325,
                    height: 51,
                  ),
                  FormLogin(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Center(
                        child: Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          '¿No eres miembro?',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Quicksand',
                            color: Color(0xff717171),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegisterView.routeName);
                            },
                            child: Text(
                              'Únete a nosotros',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Quicksand',
                                color: Colors.black,
                              ),
                            )),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
            _buildLoading(context)
          ],
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext contextDialogo) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == StatusAuthentication.loading
            ? LoadingIndicator()
            : Container();
      },
    );
  }
}
