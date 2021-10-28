class CityModel {
  
  String ciudada;
  String departamento;
  

  CityModel.fromJson(Map json)
      : ciudada = json['ciudad'],
        departamento = json['departamento'];

  Map toJson() {
    return {'ciudada': ciudada, 'departamento': departamento,};
  }
}