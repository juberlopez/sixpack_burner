import 'package:burnet_stack/domain/domain.dart';
import 'package:burnet_stack/presentations/ui/home/profile/cubit/profile_cubit.dart';
import 'package:burnet_stack/presentations/ui/theme/app_theme.dart';
import 'package:burnet_stack/presentations/ui/widgets/type_image_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  static final String routeName = 'profile_View';
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).init();
  }

  @override
  Widget build(BuildContext context) {
    UserPlusModel user = context.select((ProfileCubit b) => b.state.user);
    ReportModel report = context.select((ProfileCubit b) => b.state.report);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Reto Burner Stack"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: BoxDecoration(
                    gradient: LinearGradient(stops: [
                  0.0,
                  1,
                ], colors: AppTheme.secondarylinearGradiant)),
              )
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                BlocBuilder<ProfileCubit, ProfileState>(
                  buildWhen: (previous, current) =>
                      previous.imagen != current.imagen,
                  builder: (context, state) {
                    return CircleAvatar(
                      backgroundColor: Colors.white70,
                      minRadius: 70.0,
                      child: CircleAvatar(
                        radius: 69.0,
                        backgroundImage: NetworkImage(state.imagen),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    user.usuario.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          child: OutlinedButton(
                            child: Text("CAMBIAR FOTO DE PERFIL"),
                            style: OutlinedButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.transparent,
                              side: BorderSide(color: Colors.white, width: 1),
                            ),
                            onPressed: () {
                              showBottomModal(context, (imegeSource) {
                                context
                                    .read<ProfileCubit>()
                                    .imageChanged(imegeSource);
                              });
                              // forgotPasswordDialog(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 10, right: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Peso Inicial:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                Expanded(child: Container()),
                                Text(
                                  "${report.datosAntro!.peso??0} Kg",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 10, right: 10),
                            child: Row(
                              children: [
                                Text("Estatura:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                Expanded(child: Container()),
                                Text(
                                  "${report.datosAntro!.estatura??0} Cm",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 10, right: 10),
                            child: Row(
                              children: [
                                Text("Edad:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                Expanded(child: Container()),
                                Text(
                                  "${report.datosAntro!.edad??0}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 10, right: 10),
                            child: Row(
                              children: [
                                Text("Correo:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                Expanded(child: Container()),
                                Text(
                                  "${user.correo??""}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 10, right: 10),
                            child: Row(
                              children: [
                                Text("Nº Celular:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                Expanded(child: Container()),
                                Text(
                                  "${user.numeroCelular??0}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  void showBottomModal(BuildContext context, Function imege) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.30,
              child: TypeImageSource(
                  onPressed: (imegeSource) => imege(imegeSource)));
        });
  }
}
