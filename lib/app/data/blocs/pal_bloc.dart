import 'package:bloc/bloc.dart';
import 'package:palkedex/app/data/blocs/pal_event.dart';
import 'package:palkedex/app/data/blocs/pal_state.dart';
import 'package:palkedex/app/data/models/pal_model.dart';
import 'package:palkedex/app/data/repositories/pal_repository.dart';

class PalBloc extends Bloc<PalEvent, PalState> {
  final PalRepository repository;

  PalBloc({
    required this.repository,
  }) : super(PalInitialState()) {
    on(_mapEventToState);
  }

  void _mapEventToState(PalEvent event, Emitter emit) async {
    List<PalModel> pals = [];

    emit(PalLoadingState());

    if (event is GetPals) {
      pals = await repository.getPals();
    }

    emit(PalLoadedState(pals: pals));
  }
}
