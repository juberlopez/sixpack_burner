import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sixpackburner/device/device.dart';
import 'package:sixpackburner/device/repositories/device_repository.dart';
import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/services/screen_messages_service.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._generalRepository, this.deviceRepository)
      : super(ProfileState(
            listaProgresos: [],
            imagen: "",
            user: UserPlusModel(),
            report: ReportModel()));

  final GeneralRepository _generalRepository;
  final DeviceRepository deviceRepository;

  Future<void> init() async {
    String? dataUser = await PersitentDevice().getUser();
    String? dataReporte = await PersitentDevice().getReporte();

    UserPlusModel user = UserPlusModel.fromRawJson(dataUser!);
    ReportModel report = ReportModel.fromRawJson(dataReporte!);
    emit(state.copyWith(user: user, report: report,imagen: user.foto));
  }

  Future<void> imageChanged(ImageSource source) async {
    try {
      String img = (await deviceRepository.getImagenDevice(source));
      saveImg(img);
      
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

  Future<void> saveImg(String imagen) async {
   
      emit(state.copyWith(status: StatusProfile.loading));
      final respuesta = await _generalRepository.updatePhotoBase64(imagen);

      respuesta.fold((e) {
        emit(state.copyWith(status: StatusProfile.initial));
        ScreenMessagesService().toast(e.message.toString());
      }, (response) {
        //ScreenMessages().toast("No existe Usuario");


        emit(state.copyWith(
            status: StatusProfile.initial,
            imagen: response.data ));
      });
   
  }

  Future<void> deleteProgress(int id) async {
    emit(state.copyWith(status: StatusProfile.loading));
    final respuesta = await _generalRepository.deleteProgresos(id);

    respuesta.fold((e) {
      emit(state.copyWith(status: StatusProfile.initial));
      ScreenMessagesService().toast(e.message.toString());
    }, (response) {
      emit(state.copyWith(
          status: StatusProfile.initial, listaProgresos: response.data));
    });
  }
}
