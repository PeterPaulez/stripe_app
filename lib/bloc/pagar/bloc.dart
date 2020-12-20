import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stripe_app/models/tarjetaCredito.dart';

part 'event.dart';
part 'state.dart';

class PagarBloc extends Bloc<PagarEvent, PagarState> {
  PagarBloc() : super(PagarState());

  @override
  Stream<PagarState> mapEventToState(PagarEvent event) async* {
    if (event is OnSeleccionarTarjeta) {
      yield state.copyWith(tarjeta: event.tarjeta, tarjetaActiva: true);
    } else if (event is OnDesactivarTarjeta) {
      yield state.copyWith(tarjetaActiva: false);
    }
  }
}
