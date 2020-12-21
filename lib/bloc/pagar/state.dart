part of 'bloc.dart';

@immutable
class PagarState {
  final double dineroPagar;
  final String moneda;
  final bool tarjetaActiva;
  final TarjetaCredito tarjeta;

  String get dineroPagarString => '${this.dineroPagar * 100.floor()}';

  PagarState({
    this.dineroPagar = 375.55,
    this.moneda = 'USD',
    this.tarjetaActiva = false,
    this.tarjeta,
  });

  PagarState copyWith({
    double dineroPagar,
    String moneda,
    bool tarjetaActiva,
    TarjetaCredito tarjeta,
  }) =>
      PagarState(
        dineroPagar: dineroPagar ?? this.dineroPagar,
        moneda: moneda ?? this.moneda,
        tarjetaActiva: tarjetaActiva ?? this.tarjetaActiva,
        tarjeta: tarjeta ?? this.tarjeta,
      );
}
