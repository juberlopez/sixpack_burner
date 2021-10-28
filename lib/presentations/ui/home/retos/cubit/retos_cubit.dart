import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:burnet_stack/domain/domain.dart';
import 'package:burnet_stack/presentations/services/screen_messages_service.dart';
import 'package:equatable/equatable.dart';


part 'retos_state.dart';

class RetosCubit extends Cubit<RetosState> {
  RetosCubit(this._generalRepository) : super(RetosState(listaRetos: []));

  final GeneralRepository _generalRepository;

  Future<void> init() async {
    final respuesta = await _generalRepository.getChallenge();

    respuesta.fold((e) {
      emit(state.copyWith(status: StatusRetos.initial));
      ScreenMessagesService().toast(e.message.toString());
    }, (response) {
      //ScreenMessages().toast("No existe Usuario");

      emit(state.copyWith(
          status: StatusRetos.initial, listaRetos: response.data));
    });
  }
}
