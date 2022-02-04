import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sixpackburner/device/repositories/device_repository.dart';
import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/services/screen_messages_service.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'mi_progreso_state.dart';

class MiProgresoCubit extends Cubit<MiProgresoState> {
  MiProgresoCubit(this._generalRepository, this.deviceRepository)
      : super(MiProgresoState(listaProgresos: [], imagen: ""));

  final GeneralRepository _generalRepository;
  final DeviceRepository deviceRepository;

  Future<void> init() async {
    emit(state.copyWith(status: StatusMiprogreso.loading));
    final respuesta = await _generalRepository.getProgresos();

    respuesta.fold((e) {
      emit(state.copyWith(status: StatusMiprogreso.initial));
      ScreenMessagesService().toast(e.message.toString());
    }, (response) {
      //ScreenMessages().toast("No existe Usuario");
      List<MyProgressModel>? listaProgresos= response.data;

      emit(state.copyWith(
          status: StatusMiprogreso.initial, listaProgresos: listaProgresos,
          sizeListaprogreso: listaProgresos!.length));
    });
  }

  Future<void> imageChanged(ImageSource source) async {
    try {
      String img = (await deviceRepository.getImagenDevice(source));
      emit(state.copyWith( imagen: img, ));
    } on DomainException catch (e) {
      //print("error");
      ScreenMessagesService().toast(e.message.toString());
      //emit(state.copyWith(status: FormzStatus.invalid));
    } catch (e) {
      print(e);
      ScreenMessagesService().toast("Cancelado por el usuario");
      //emit(state.copyWith(status: FormzStatus.invalid));
    }
  }

  Future<void> saveProgress(String peso) async {
    if (state.imagen.isNotEmpty) {
      emit(state.copyWith(status: StatusMiprogreso.loading));
      final respuesta = await _generalRepository.addControl(state.imagen, peso);

      respuesta.fold((e) {
        emit(state.copyWith(status: StatusMiprogreso.initial));
        ScreenMessagesService().toast(e.message.toString());
      }, (response) {
        //ScreenMessages().toast("No existe Usuario");
            
List<MyProgressModel>? listaProgresos= response.data;

List<MyProgressModel>? listaProgresosPlus= state.listaProgresos;
listaProgresos!.last;

listaProgresosPlus.add(listaProgresos.last);

        emit(state.copyWith(
            status: StatusMiprogreso.initial,
            listaProgresos: listaProgresosPlus,
            sizeListaprogreso: listaProgresos.length,
            imagen: ""));
      });
    } else {
      ScreenMessagesService().toast("Agrega una foto");
    }
  }

  Future<void> deleteProgress(int id) async {
    emit(state.copyWith(status: StatusMiprogreso.loading));
    final respuesta = await _generalRepository.deleteProgresos(id);

    respuesta.fold((e) {
      emit(state.copyWith(status: StatusMiprogreso.initial));
      ScreenMessagesService().toast(e.message.toString());
    }, (response) {
      emit(state.copyWith(
          status: StatusMiprogreso.initial, listaProgresos: response.data));
    });
  }
}
