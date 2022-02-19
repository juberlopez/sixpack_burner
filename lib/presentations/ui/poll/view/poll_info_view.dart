import 'package:sixpackburner/device/device.dart';
import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/view/home_view.dart';
import 'package:sixpackburner/presentations/ui/poll/poll_cubit/poll_cubit.dart';
import 'package:sixpackburner/presentations/ui/widgets/buttons/app_button.dart';
import 'package:sixpackburner/presentations/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/iterables.dart';

class InfoView extends StatefulWidget {
  static final String routeName = 'info_View';
  const InfoView({Key? key}) : super(key: key);

  @override
  _InfoViewState createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
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
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    Container(
                      height: 340,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/atletas_burnerstack.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Text(
                      "¡LISTO PARA EMPEZAR!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Aquí está la vista previa de tu plan",
                        style: TextStyle(color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text("Calorías Diarias:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(child: Container()),
                                Text(
                                  context
                                          .select((PollCubit b) =>
                                              b.state.totalCalorias)
                                          .toString() +
                                      " Kcal",
                                  style: TextStyle(color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text("Proteínas:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(child: Container()),
                                Text(
                                    context
                                            .select((PollCubit b) =>
                                                b.state.totalProteinas)
                                            .toString() +
                                        " gr",
                                    style: TextStyle(color: Colors.blue))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text("Carbohidratos:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(child: Container()),
                                Text(
                                    context
                                            .select((PollCubit b) =>
                                                b.state.totalCarbohidratos)
                                            .toString() +
                                        " gr",
                                    style: TextStyle(color: Colors.blue))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text("Grasas",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Expanded(child: Container()),
                                Text(
                                    context
                                            .select((PollCubit b) =>
                                                b.state.totalGrasas)
                                            .toString() +
                                        "gr",
                                    style: TextStyle(color: Colors.blue))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ACTIVAR RECORDATORIOS DE COMIDAS",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Asi te podemos enviar recordatorios de tus comidas y entrenamientos para poder alcanzar tus objetivos",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 60,
                              child: Switch(
                                value: context.select(
                                    (PollCubit b) => b.state.notification),
                                onChanged: (value) {
                                  context
                                      .read<PollCubit>()
                                      .initNotificationTest(value);
                                },
                                //activeTrackColor: UiTheme.primaryColor.withOpacity(0.3),
                                //activeColor: UiTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: AppButton(
                              label: 'OBTENER PLAN',
                              onPressed: () {
                                PersitentDevice().setState("FULL");
                                Navigator.pushNamed(
                                    context, HomeView.routeName);
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
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

class _ImagenBackGround extends StatelessWidget {
  const _ImagenBackGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    return Container(
      height: data.size.height,
      width: data.size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage('assets/images/andrea_back_burnerstack.png'),
            fit: BoxFit.cover),
      ),
    );
  }
}

class ListarEstaturas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: range(150, 200)
              .map((e) => GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Text(e.toString() + "cm"),
                  )))
              .toList()),
    );
  }
}

class CardBody extends StatefulWidget {
  final BodyModel e;
  const CardBody({Key? key, required this.e}) : super(key: key);

  @override
  _CardBodyState createState() => _CardBodyState();
}

class _CardBodyState extends State<CardBody> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PollCubit>(context).cardBodySelect(widget.e);
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Stack(
            children: [
              FadeInImage(
                image: NetworkImage(widget.e.image.toString()),
                placeholder: AssetImage('assets/images/blurhombre.jpg'),
                fit: BoxFit.cover,
                //width: double.infinity,
              ),
              context.select((PollCubit b) => b.state.idCardBody == widget.e.id)
                  ? Center(
                      child: Icon(
                        Icons.check,
                        size: 100,
                        color: Colors.white,
                      ),
                    )
                  : Container()
            ],
          )),
    );
  }
}

class CardMuneca extends StatefulWidget {
  final MunecaModel e;
  const CardMuneca({Key? key, required this.e}) : super(key: key);

  @override
  _CardMunecaState createState() => _CardMunecaState();
}

class _CardMunecaState extends State<CardMuneca> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PollCubit>(context).cardMunecaSelect(widget.e);
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Image(
                    image: AssetImage(widget.e.image.toString()),
                  ),
                  Expanded(child: Container()),
                  Text(
                    widget.e.msg.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  Expanded(child: Container())
                ],
              ),
              context.select(
                      (PollCubit b) => b.state.idCardMuneca == widget.e.id)
                  ? Center(
                      child: Icon(
                        Icons.check,
                        size: 100,
                        color: Colors.white,
                      ),
                    )
                  : Container()
            ],
          )),
    );
  }
}
