import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:burnet_stack/device/repositories/persistent_device.dart';
import 'package:burnet_stack/domain/domain.dart';
import 'package:burnet_stack/presentations/services/screen_messages_service.dart';
import 'package:equatable/equatable.dart';


part 'ajustes_state.dart';

class AjustesCubit extends Cubit<AjustesState> {
  AjustesCubit(this._generalRepository) : super(AjustesState(listaRetos: []));

  final GeneralRepository _generalRepository;

  Future<void> init() async {
    final respuesta = await _generalRepository.getChallenge();

    respuesta.fold((e) {
      emit(state.copyWith(status: StatusAjustes.initial));
      ScreenMessagesService().toast(e.message.toString());
    }, (response) {
      //ScreenMessages().toast("No existe Usuario");

      emit(state.copyWith(
          status: StatusAjustes.initial, listaRetos: response.data));
    });
  }

  
}
