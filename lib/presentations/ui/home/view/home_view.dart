import 'package:flutter/services.dart';
import 'package:sixpackburner/domain/repositories/repositories.dart';
import 'package:sixpackburner/presentations/ui/home/ajustes/cubit/ajustes_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/ajustes/view/ajustes_view.dart';
import 'package:sixpackburner/presentations/ui/home/dietas/cubit/dieta_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/dietas/view/dietas_view.dart';
import 'package:sixpackburner/presentations/ui/home/mi_progreso/cubit/mi_progreso_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/mi_progreso/view/mi_progreso_view.dart';
import 'package:sixpackburner/presentations/ui/home/profile/cubit/profile_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/recetas/cubit/recetas_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/recetas/view/recetas_view.dart';
import 'package:sixpackburner/presentations/ui/home/retos/cubit/retos_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/retos/view/retos_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  static final String routeName = 'home_View';

  const HomeView({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeView());
  }

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 2;

  List<Widget> _widgetOptions = <Widget>[
    RetosView(),
    AjustesView(),
    DietasView(),
    MiProgresoView(),
    RecetasView(),
  ];

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = 2;
    context.read<DietaCubit>().init();
    context.read<AjustesCubit>().init();
    context.read<RetosCubit>().init();
    context.read<RecetasCubit>().init();
    context.read<ProfileCubit>().init();
    context.read<MiProgresoCubit>().init();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle( statusBarColor: Colors.blueAccent));
 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return /*BlocListener<PlayerZoneCubit, PlayerZoneState>(
      listenWhen: (previous, current) =>
          previous.selectedIndexTap != current.selectedIndexTap,
      listener: (context, state) {
        if (state.selectedIndexTap == 2) {
          setState(() {
            _selectedIndex = 2;
          });
        }
      },
      child:*/
        Scaffold(
      body: new SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        iconSize: 25.0,
        backgroundColor: Color(0xFF00AAFF),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w300,
          fontSize: 10.0,
        ),
        selectedLabelStyle: TextStyle(
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w300,
          fontSize: 10.0,
        ),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Container(
                  width: 45.0,
                  height: 30.0,
                  margin: EdgeInsets.only(
                    bottom: 3.0,
                  ),
                  child: Icon(Icons.notifications),
                ),
              ],
            ),
            label: 'Retos',
          ),
          BottomNavigationBarItem(
            icon: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Container(
                  width: 45.0,
                  height: 30.0,
                  margin: EdgeInsets.only(
                    bottom: 2.0,
                  ),
                  child: Icon(Icons.supervisor_account),
                ),
              ],
            ),
            label: 'Ajustes',
          ),
          BottomNavigationBarItem(
            icon: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Container(
                  width: 45.0,
                  height: 30.0,
                  margin: EdgeInsets.only(
                    bottom: 2.0,
                  ),
                  child: Icon(Icons.restaurant),
                ),
              ],
            ),
            label: 'Dietas',
          ),
          BottomNavigationBarItem(
            icon: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Container(
                  width: 45.0,
                  height: 30.0,
                  margin: EdgeInsets.only(
                    bottom: 3.0,
                  ),
                  child: Icon(Icons.camera),
                ),
              ],
            ),
            label: 'Mis progresos',
          ),
          BottomNavigationBarItem(
            icon: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Container(
                  width: 45.0,
                  height: 30.0,
                  margin: EdgeInsets.only(
                    bottom: 3.0,
                  ),
                  child: Icon(Icons.restaurant_menu),
                ),
              ],
            ),
            label: 'Recetas',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFE6E6E6),
        onTap: _onItemTapped,
      ),
    );
    //);
  }
}
