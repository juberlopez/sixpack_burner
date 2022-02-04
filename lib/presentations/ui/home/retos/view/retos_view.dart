import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/ui/home/retos/cubit/retos_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/retos/widget/detalle_reto_widget.dart';
import 'package:sixpackburner/presentations/ui/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart'; // for date format

class RetosView extends StatefulWidget {
  const RetosView({Key? key}) : super(key: key);

  @override
  _RetosViewState createState() => _RetosViewState();
}

class _RetosViewState extends State<RetosView> {
  @override
  void initState() {
    //BlocProvider.of<RecetasCubit>(context).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es');
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image:
                      AssetImage('assets/images/reto_del_dia_burnerstack.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<RetosCubit, RetosState>(
                buildWhen: (previous, current) =>
                    previous.listaRetos != current.listaRetos,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Column(
                      children: [
                        (state.listaRetos.isNotEmpty)
                            ? Column(
                                children: state.listaRetos
                                    .map((e) => Material(
                                          child: InkWell(
                                            onTap: () {},
                                            child: Ink(
                                              child: RetoCard(
                                                challengeModel: e,
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              )
                            : Center(
                                child: Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: Text(
                                  "",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RetoCard extends StatefulWidget {
  final ChallengeModel challengeModel;
  //final AlimentoModel alimentoModel;
  const RetoCard({Key? key, required this.challengeModel}) : super(key: key);

  @override
  _RetoCardState createState() => _RetoCardState();
}

class _RetoCardState extends State<RetoCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (context) => FractionallySizedBox(
                heightFactor: 1,
                child:
                    DetalleRetoWidget(challengeModel: widget.challengeModel)));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: 130,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      child: FadeInImage(
                        image: NetworkImage(
                            widget.challengeModel.image.toString()),
                        placeholder: AssetImage('assets/images/load.jpg'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )), /*ClipRRect(
                      
    
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      child: CachedNetworkImage(
                        
                        width: 100,
                        height: 100,
                        imageUrl: widget.challengeModel.image.toString(),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),*/
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.challengeModel.title.toString(),
                      style: AppTheme.text15,
                    ),
                    Text(
                      widget.challengeModel.body.toString(),
                      style: AppTheme.text14,
                    ),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Text(
                          DateFormat.yMMMd('es')
                              .format(widget.challengeModel.fecha!),
                          style: AppTheme.text14,
                        )
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
