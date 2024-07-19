import 'package:palkedex/app/data/models/pal_model.dart';

abstract class PalState {
  final List<PalModel> pals;

  PalState({required this.pals});
}

class PalInitialState extends PalState {
  PalInitialState() : super(pals: []);
}

class PalLoadingState extends PalState {
  PalLoadingState() : super(pals: []);
}

class PalLoadedState extends PalState {
  PalLoadedState({required List<PalModel> pals}) : super(pals: pals);
}

class PalErrorState extends PalState {
  final Exception exception;

  PalErrorState({required this.exception}) : super(pals: []);
}
