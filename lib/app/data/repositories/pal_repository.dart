import 'dart:convert';
import 'package:flutter/services.dart'; // Importe este pacote para usar o rootBundle
import 'package:palkedex/app/data/models/pal_model.dart';

abstract class IPalRopository {
  Future<List<PalModel>> getPals();
}

class PalRepository implements IPalRopository {
  @override
  Future<List<PalModel>> getPals() async {
    final String jsonString = await rootBundle.loadString('assets/pals.json');

    final List<PalModel> pals = [];

    final List<dynamic> data = jsonDecode(jsonString);

    for (var item in data) {
      final PalModel pal = PalModel.fromMap(item);
      pals.add(pal);
    }

    return pals;
  }
}
