import 'package:sixpackburner/presentations/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:sixpackburner/presentations/ui/welcome/view/welcome_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


@override
  void initState() {
    context.read<AuthenticationCubit>().signInwithToken();
    super.initState();

    
  }

  

 

  

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
         if(state.status ==StatusAuthentication.hay_token){
          //context.read<NutritionalPlanCubit>().init();
          context.read<AuthenticationCubit>().signInwithToken();
         
        }else if(state.status ==StatusAuthentication.welcome){
          Navigator.pushNamed(context, WelcomeView.routeName);
          //context.read<NutritionalPlanCubit>().init();
        
         
        }
        // TODO: implement listener
      },
      child: Scaffold(
            backgroundColor: Colors.blueAccent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 40),
                  child: new Image.asset(
                    'assets/images/logo_reto.png',
                    height: 160.0,
                  ),
                ),
              ),
              // Spacer(),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange.shade200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
