import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:burnet_stack/domain/domain.dart';
import 'package:burnet_stack/presentations/services/screen_messages_service.dart';
import 'package:equatable/equatable.dart';

part 'recetas_state.dart';

class RecetasCubit extends Cubit<RecetasState> {
  RecetasCubit(this._recipeRepository) : super(RecetasState(listaRecetas: []));

  final RecipeRepository _recipeRepository;

  Future<void> init() async {
    emit(state.copyWith(status: StatusRecetas.loading));
    final respuesta = await _recipeRepository.getRecipes();

    respuesta.fold((e) {
      emit(state.copyWith(status: StatusRecetas.initial));
      ScreenMessagesService().toast(e.message.toString());
    }, (response) {
      //ScreenMessages().toast("No existe Usuario");

      emit(state.copyWith(
          status: StatusRecetas.initial, listaRecetas: response.data));
    });
  }

  Future<void> stateLike(String idReceta, bool stateLike) async {
   

    final respuesta = await _recipeRepository.statelikeRecipes(idReceta, !stateLike);

    respuesta.fold((e) {
     // emit(state.copyWith(status: StatusRecetas.initial));
      ScreenMessagesService().toast(e.message.toString());
    }, (response) {
      //ScreenMessages().toast("No existe Usuario");

    });
  }
   Future<void> stateFavorite(String idReceta, bool stateFavorite) async {
   

    final respuesta = await _recipeRepository.stateFavoriteRecipes(idReceta, stateFavorite);

    respuesta.fold((e) {
     // emit(state.copyWith(status: StatusRecetas.initial));
      ScreenMessagesService().toast(e.message.toString());
    }, (response) {
      //ScreenMessages().toast("No existe Usuario");

    });
  }
}
