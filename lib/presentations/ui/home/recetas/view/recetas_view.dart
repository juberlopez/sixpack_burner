import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/ui/home/recetas/cubit/recetas_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/recetas/widget/detalle_reseta_widget.dart';
import 'package:sixpackburner/presentations/ui/theme/app_theme.dart';
import 'package:sixpackburner/presentations/ui/widgets/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

class RecetasView extends StatefulWidget {
  const RecetasView({Key? key}) : super(key: key);

  @override
  _RecetasViewState createState() => _RecetasViewState();
}

class _RecetasViewState extends State<RecetasView> {
  @override
  void initState() {
    //BlocProvider.of<RecetasCubit>(context).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<RecetasCubit, RecetasState>(
                    buildWhen: (previous, current) =>
                        previous.listaRecetas != current.listaRecetas,
                    builder: (context, state) {
                      return SingleChildScrollView(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Column(
                          children: [
                            (state.listaRecetas.isNotEmpty)
                                ? Column(
                                    children: state.listaRecetas
                                        .map((e) => RecetaCard(
                                              recipeModel: e,
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
                      ));
                    },
                  ),
                ),
              )
            ],
          ),
          _buildLoading(context)
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext contextDialogo) {
    return BlocBuilder<RecetasCubit, RecetasState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == StatusRecetas.loading) {
          return LoadingIndicator();
        } else {
          return Container();
        }
      },
    );
  }
}

class RecetaCard extends StatefulWidget {
  final RecipeModel recipeModel;
  //final AlimentoModel alimentoModel;
  const RecetaCard({Key? key, required this.recipeModel}) : super(key: key);

  @override
  _RecetaCardState createState() => _RecetaCardState();
}

class _RecetaCardState extends State<RecetaCard> {
  bool like = false;
  bool favorite = false;
  int dataLike = 0;
  int cantidadLike = 0;

  @override
  void initState() {
    super.initState();
    like = widget.recipeModel.isLike!;
    favorite = widget.recipeModel.isFavorite!;
    cantidadLike = widget.recipeModel.likes!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 265,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => FractionallySizedBox(
                            heightFactor: 1,
                            child: DetalleRecetaWidget(
                                recipeModel: widget.recipeModel)));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    child: CachedNetworkImage(
                      imageUrl: widget.recipeModel.cover.toString(),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Text(
                widget.recipeModel.name.toString(),
                style: AppTheme.text15,
              ),
              Text(
                widget.recipeModel.category.toString(),
                style: AppTheme.text14,
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            if (like) {
                              setState(() {
                                dataLike = dataLike - 1;
                              });
                            } else {
                              setState(() {
                                dataLike = dataLike +1;
                              });
                            }

                            BlocProvider.of<RecetasCubit>(context).stateLike(
                                widget.recipeModel.id.toString(), like);
                            setState(() {
                              like = !like;
                            });
                          },
                          icon: Icon(
                            Icons.thumb_up,
                            color: (like) ? Colors.blue : Colors.grey,
                          )),
                      Text((cantidadLike + dataLike).toString())
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<RecetasCubit>(context)
                                .stateFavorite(
                                    widget.recipeModel.id.toString(), favorite);
                            setState(() {
                              favorite = !favorite;
                            });
                          },
                          icon: Icon(
                              favorite ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red))
                    ],
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: (){
                      Share.share(widget.recipeModel.sharelink!);
                    },
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Share.share(widget.recipeModel.sharelink!);
                            },
                            icon: Icon(Icons.share)),
                        Text("Share")
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
