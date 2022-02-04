import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:sixpackburner/presentations/ui/poll/poll_cubit/poll_cubit.dart';
import 'package:sixpackburner/presentations/ui/poll/view/poll_horas_view.dart';
import 'package:sixpackburner/presentations/ui/poll/widgets/carrucel_cuerpo.dart';
import 'package:sixpackburner/presentations/ui/widgets/buttons/app_button.dart';
import 'package:sixpackburner/presentations/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/iterables.dart';

class PollAntroView extends StatefulWidget {
  static final String routeName = 'poll_antro_View';
  const PollAntroView({Key? key}) : super(key: key);

  @override
  _PollAntroViewState createState() => _PollAntroViewState();
}

class _PollAntroViewState extends State<PollAntroView> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = new ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _ImagenBackGround(),
            SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "¿Con qué imagen te identificas? (Presiónala para seleccionar o desliza con el dedo para elegir)",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white)),
                    )),
                    Carrucel(
                      contenidoItems: BlocProvider.of<PollCubit>(context)
                          .getBodys()
                          .map((e) => CardBody(
                                e: e,
                                onTap: () {
                                  _scrollController.animateTo(200, duration: Duration(seconds: 2), curve: Curves.ease);
                                },
                              ))
                          .toList(),
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Seleciona el grosor de tu muñeca. (Presiónala para seleccionar o desliza con el dedo para elegir)",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white)),
                    )),
                    Carrucel(
                      contenidoItems: BlocProvider.of<PollCubit>(context)
                          .getMunecas()
                          .map((e) => CardMuneca(
                                e: e,
                              ))
                          .toList(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: AppButton(
                              label: 'Siguiente',
                              onPressed: () {
                                if (BlocProvider.of<PollCubit>(context)
                                    .nextTwo()) {
                                  Navigator.pushNamed(
                                      context, PollHorasView.routeName);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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
  final Function onTap;
  const CardBody({Key? key, required this.e, required this.onTap})
      : super(key: key);

  @override
  _CardBodyState createState() => _CardBodyState();
}

class _CardBodyState extends State<CardBody> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PollCubit>(context).cardBodySelect(widget.e);
        widget.onTap();
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
