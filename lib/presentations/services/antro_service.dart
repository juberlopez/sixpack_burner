import 'package:burnet_stack/domain/domain.dart';

class AntroService {
  
  DatosAntroModel getAntro(
      {required String genero,
      required double peso,
      required double porcentajeGrasa,
      required double pesoOseo}) {
    double pesoResidual = 0;

    pesoResidual = genero == "MASCULINO" ? peso * 0.241 : peso * 0.209;

    double porcentajeResidual = pesoResidual * 100 / peso;
    double pesoGrasa = porcentajeGrasa * peso / 100;
    double porcentajeOseo = pesoOseo * 100 / peso;
    double pesoMuscle = peso - (pesoOseo + pesoResidual + pesoGrasa);
    double porcentajeMuscle = pesoMuscle * 100 / peso;

    return DatosAntroModel(
        pesoGrasa: pesoGrasa,
        pesoOseo: pesoOseo,
        pesoResidual: pesoResidual,
        porcentajeResidual: porcentajeResidual,
        pesoMuscle: pesoMuscle,
        porcentajeMuscle: porcentajeMuscle,
        porcentajeOseo: porcentajeOseo);
  }

  ImcModel getImc(
      {required String peso,
      required String estatura,
      required double porcentajeGrasa}) {
    var imc = int.parse(peso) ~/
        ((int.parse(estatura) / 100) * (int.parse(estatura) / 100));
    //const imc= Number(parseFloat(JSON.stringify(peso/((estatura/100)*(estatura/100)))).toFixed(1));
    var msgImc = "";

    if (imc < 15.9)
      msgImc =
          "Tu peso está muy liviano, te recomendamos tomar 1 copa y media de megaplex creatine power 3 veces al día para normalizar tu peso.";
    else if (imc > 16 && imc < 18.4)
      msgImc =
          "Tu peso está liviano, te recomendamos tomar un servicio de Gainz dos veces al día y realizar ejercicios de fuerza.";
    else if (imc > 18.5 && imc < 24.9) msgImc = "Tu peso está saludable";
    if (imc > 25 && imc < 29.9 && porcentajeGrasa >= 25)
      msgImc =
          "Tu peso está en sobre peso, te recomendamos realizar una dieta para perder el porcentaje de grasa.";
    else if (imc > 25 && imc < 29.9 && porcentajeGrasa < 25)
      msgImc =
          "Tu peso está adecuado, te recomendamos tomar bipro para mantener la masa muscular.";
    if (imc > 29.9 && porcentajeGrasa >= 25)
      msgImc =
          "Ten cuidado con tu porcentaje de grasa puede ser peligro para tu salud";
    else if (imc > 29.9 && porcentajeGrasa < 25)
      msgImc = "Tu peso está adecuado, prevalece la masa muscular.";

    return ImcModel(msg: msgImc, imc: imc);
  }

  double grtTMB(
      {required String genero,
      required String peso,
      required String estatura,
      required String edad}) {
    double tmb = 0;

    if (genero == "MASCULINO") {
      tmb = 66.47 +
          13.57 * int.parse(peso) +
          5 * int.parse(estatura) -
          6.75 * int.parse(edad);
    } else {
      tmb = 655.1 +
          9.46 * int.parse(peso) +
          1.85 * (int.parse(estatura)) -
          4.67 * int.parse(edad);
    }

    return tmb;
  }

  int frecuencyTraining(String frecuency) {
    switch (frecuency) {
      case 'SEDENTARIO':
        return 20;

      case 'ENTRENO OCASIONAL Y LIGERO':
        return 30;
      case 'ENTRENA 3-4 VECES POR SEMANA':
        return 45;
      case 'ENTRENA FUERTE 5 VECES POR SEMANA':
        return 60;
      case 'ALTO RENDIMIENTO':
        return 80;
      default:
        return 20;
    }
  }
}

/*public static frecuency_training={
SEDENTARIO:20,
'ENTRENO OCASIONAL Y LIGERO':30,
'ENTRENA 3-4 VECES POR SEMANA':45,
'ENTRENA FUERTE 5 VECES POR SEMANA':60,
'ALTO RENDIMIENTO':80
}*/


/*public static getTMB(genero,peso,estatura,edad){
let tmb;
if(genero=="MASCULINO")tmb=66.47+13.57*peso+5*estatura-6.75*edad;
else tmb=655.1+9.46*peso+1.85*(estatura)-4.67*edad;
return Math.round(tmb);
}*/


/*export class ANTRO{
public static getAntro(genero:string, peso:number,
porcentaje_grasa:number,peso_oseo:number){
let peso_residual=0;
if(genero=="MASCULINO")peso_residual=peso*0.241;
else peso_residual=peso*0.209;
let porcentaje_residual=peso_residual*100/peso;
let peso_grasa=porcentaje_grasa*peso/100;
let porcentaje_oseo=peso_oseo*100/peso;
let peso_muscle= peso-(peso_oseo+ peso_residual+ peso_grasa);
let porcentaje_muscle=peso_muscle*100/peso;
return{
peso_grasa: Number(parseFloat((JSON.stringify(peso_grasa))).toFixed(1)),
peso_oseo: Number(parseFloat((JSON.stringify(peso_oseo))).toFixed(2)),
peso_residual: Number(parseFloat((JSON.stringify(peso_residual))).toFixed(1)),
porcentaje_residual: Number(parseFloat((JSON.stringify(porcentaje_residual))).toFixed(1)),
peso_muscle: Number(parseFloat((JSON.stringify(peso_muscle))).toFixed(1)),
porcentaje_muscle: Number(parseFloat((JSON.stringify(porcentaje_muscle))).toFixed(1)),
porcentaje_oseo: Number(parseFloat((JSON.stringify(porcentaje_oseo))).toFixed(1)),
}
}   
public static getImc(peso,estatura,porcentaje_grasa){
const imc= Number(parseFloat(JSON.stringify(peso/((estatura/100)*(estatura/100)))).toFixed(1));
let msgimc="";
if(imc<15.9)msgimc="Tu peso está muy liviano, te recomendamos tomar 1 copa y media de megaplex creatine power 3 veces al día para normalizar tu peso.";
else if(imc>16 && imc < 18.4)msgimc="Tu peso está liviano, te recomendamos tomar un servicio de Gainz dos veces al día y realizar ejercicios de fuerza.";
else if(imc>18.5 && imc<24.9)msgimc="Tu peso está saludable";
if(imc>25 && imc<29.9 && porcentaje_grasa>=25)msgimc="Tu peso está en sobre peso, te recomendamos realizar una dieta para perder el porcentaje de grasa.";
else if(imc>25 && imc<29.9 && porcentaje_grasa<25)msgimc="Tu peso está adecuado, te recomendamos tomar bipro para mantener la masa muscular.";
if(imc>29.9 && porcentaje_grasa>=25)msgimc="Ten cuidado con tu porcentaje de grasa puede ser peligro para tu salud";
else if(imc>29.9 && porcentaje_grasa<25)msgimc="Tu peso está adecuado, prevalece la masa muscular.";
return {
imc,msgimc
}
}
public static getTMB(genero,peso,estatura,edad){
let tmb;
if(genero=="MASCULINO")tmb=66.47+13.57*peso+5*estatura-6.75*edad;
else tmb=655.1+9.46*peso+1.85*(estatura)-4.67*edad;
return Math.round(tmb);
}
public static frecuency_training={
SEDENTARIO:20,
'ENTRENO OCASIONAL Y LIGERO':30,
'ENTRENA 3-4 VECES POR SEMANA':45,
'ENTRENA FUERTE 5 VECES POR SEMANA':60,
'ALTO RENDIMIENTO':80
}*/
    
// #region <name of my region> 
//     json={
//     genero: genero,
//     edad: edad,
//     salud: null,
//     objetivo: objetivo,
//     producto:"BI PRO",
//     vegetariano:vegetarino,
//     antro:{
//     calorias: Math.round(tmb),
//     aumento: aumentop,
//     kgmuscle:peso_muscle
//     },
//     datos_antro:{
//     porcentaje_grasa: porcentaje_grasa,
//     peso_grasa: Number(parseFloat((JSON.stringify(peso_grasa))).toFixed(1)),
//     peso_oseo: Number(parseFloat((JSON.stringify(peso_oseo))).toFixed(2)),
//     peso_residual: Number(parseFloat((JSON.stringify(peso_residual))).toFixed(1)),
//     porcentaje_residual: Number(parseFloat((JSON.stringify(porcentaje_residual))).toFixed(1)),
//     peso_muscle: Number(parseFloat((JSON.stringify(peso_muscle))).toFixed(1)),
//     porcentaje_muscle: Number(parseFloat((JSON.stringify(porcentaje_muscle))).toFixed(1)),
//     porcentaje_oseo: Number(parseFloat((JSON.stringify(porcentaje_oseo))).toFixed(1)),
//     peso: peso,
//     estatura: estatura,
//     visceral:5,
//     imc:Math.round(imc),
//     msg: msgimc,
//     frecuencia_entreno:frecuencia_entreno
//     },
//     panel:{
//     Hora_levantarse:despertar,
//     MinutosEntreno:tipo_entreno,
//     Hora_Entreno:tiempo_entreno,
//     Hora_DESAYUNO: desayuno,
//     Hora_almuerzo: almuerzo,
//     Hora_cena: cena,
//     Hora_Entreno: entreno,
//     Hora_dormir: dormir  
//     },
//     usuario: {
//         nombres: "KEVIN GUTIERREZ",
//         id_usuario: 6394880
//     },
//     nutricionista: {
//         id_usuario: 6394880,
//         nombres: "DIETAS AUTOMÁTICAS",
//         rol: "ADMIN"
//     }
//     }
    

    



// #endregion  
//}