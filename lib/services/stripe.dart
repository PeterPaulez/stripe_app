import 'package:meta/meta.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  // Inicializamos, si existe una instancia la retornamos, y sino la creamos.
  // final stripeService = new StripeService();
  // Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  String _paymentApiURL = 'https://api.stripe.com/v1/payment_intents';
  String _secretKey = 'sk_test_JSKA4WhRXwZg3NGMw2J1TExO';

  void init() {}

  Future pagarTarjetaExistente(
      {@required String amount,
      @required String currency,
      @required CreditCard card}) async {}

  Future pagarNuevaTarjeta({
    @required String amount,
    @required String currency,
  }) async {}

  Future pagarAppleGooglePay({
    @required String amount,
    @required String currency,
  }) async {}

  Future _crearPaymentIntent({
    @required String amount,
    @required String currency,
  }) async {}

  Future _realizarPago({
    @required String amount,
    @required String currency,
    @required PaymentMethod paymentMethod,
  }) async {}
}
