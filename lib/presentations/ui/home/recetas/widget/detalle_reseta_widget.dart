import 'package:burnet_stack/domain/domain.dart';
import 'package:burnet_stack/presentations/ui/home/recetas/cubit/recetas_cubit.dart';
import 'package:burnet_stack/presentations/ui/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

class DetalleRecetaWidget extends StatefulWidget {
  final RecipeModel recipeModel;
  //final AlimentoModel alimentoModel;
  const DetalleRecetaWidget({Key? key, required this.recipeModel})
      : super(key: key);

  @override
  _DetalleRecetaWidgetState createState() => _DetalleRecetaWidgetState();
}

class _DetalleRecetaWidgetState extends State<DetalleRecetaWidget> {
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Container(
          height: 265,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                     Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      child: CachedNetworkImage(
                        imageUrl: widget.recipeModel.cover.toString(),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    child: IconButton(onPressed: (){
                       Navigator.of(context).pop();
                    }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                  )
                  ],
                  
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start ,
                    children: [
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
                                        dataLike = 1;
                                      });
                                    } else {
                                      setState(() {
                                        dataLike = -1;
                                      });
                                    }
    
                                    BlocProvider.of<RecetasCubit>(context)
                                        .stateLike(
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
                                            widget.recipeModel.id.toString(),
                                            favorite);
                                    setState(() {
                                      favorite = !favorite;
                                    });
                                  },
                                  icon: Icon(
                                      favorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red))
                            ],
                          ),
                          Expanded(child: Container()),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Share.share(widget.recipeModel.sharelink!);
                                  },
                                  icon: Icon(Icons.share)),
                              Text("Share")
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [Icon(Icons.info_sharp,color:Colors.blue), Text("Preparacion",style: TextStyle(fontWeight:FontWeight.bold ),)],
                      ),
                      SizedBox(height: 10,),
                      Text(widget.recipeModel.description.toString())
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
