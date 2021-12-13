import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lojacompleta/models/cepaberto_address.dart';

const token = "a6a7da6ae6b3f344f5044b69eb82268b";

class CepAbertoService {
  Future<CepAbertoAddress> getAddressFromCep(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    log(cleanCep);
    final endpoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

    final Dio dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try {
      final response = await dio.get<Map<String, dynamic>>(endpoint);

      if (response.data.isEmpty) {
        return Future.error('Cep Inválido');
      }

      final CepAbertoAddress address = CepAbertoAddress.fromMap(response.data);

      return address;
    } on DioError catch (e) {
      log(e.message);
      return Future.error("erro ao buscar o CEP");
    }
  }
}
