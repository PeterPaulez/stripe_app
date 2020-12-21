import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:stripe_app/models/stripeReponseIntent.dart';
import 'package:stripe_app/models/stripeResponse.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  // Inicializamos, si existe una instancia la retornamos, y sino la creamos.
  // final stripeService = new StripeService();
  // Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  String _paymentApiURL = 'https://api.stripe.com/v1/payment_intents';
  static String _secretKey = 'sk_test_JSKA4WhRXwZg3NGMw2J1TExO';
  String _publishableKey = 'pk_test_nSIPFj5MlRUTZFuy7Q6xSslR';
  final headerOptions = new Options(
    contentType: Headers.formUrlEncodedContentType,
    headers: {'Authorization': 'Bearer ${StripeService._secretKey}'},
  );

  void init() {
    StripePayment.setOptions(
      StripeOptions(publishableKey: _publishableKey),
    );
  }

  Future pagarTarjetaExistente({
    @required String amount,
    @required String currency,
    @required CreditCard card,
  }) async {}

  Future<StripeResponse> pagarNuevaTarjeta({
    @required String amount,
    @required String currency,
  }) async {
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
          new CardFormPaymentRequest());
      final answer = this._realizarPago(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
      );

      return answer;
    } catch (e) {
      print(e.toString());
      return StripeResponse(
        ok: false,
        msg: e.toString(),
      );
    }
  }

  void handleError(dynamic error) {
    if (error.code == 'purchaseCancelled' || error.code == 'cancelled') {
      print('payment cancelled');
    }
  }

  Future pagarAppleGooglePay({
    @required String amount,
    @required String currency,
  }) async {}

  Future<StripeResponseIntent> _crearPaymentIntent({
    @required String amount,
    @required String currency,
  }) async {
    try {
      final dio = Dio();
      final data = {
        'amount': amount,
        'currency': currency,
      };
      final answer = await dio.post(
        _paymentApiURL,
        data: data,
        options: headerOptions,
      );

      return StripeResponseIntent.fromJson(answer.data);
    } catch (e) {
      print('Error en el Intent: ${e.toString()}');
      return StripeResponseIntent(status: '400');
    }
  }

  Future<StripeResponse> _realizarPago({
    @required String amount,
    @required String currency,
    @required PaymentMethod paymentMethod,
  }) async {
    try {
      final paymentIntent = await this._crearPaymentIntent(
        amount: amount,
        currency: currency,
      );
      print('clientSecret: ${paymentIntent.clientSecret}');
      print('id: ${paymentIntent.id}');
      final paymentResult = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent.clientSecret,
          paymentMethodId: paymentMethod.id,
        ),
      );

      if (paymentResult.status == 'succeeded') {
        return StripeResponse(ok: true);
      } else {
        return StripeResponse(ok: false, msg: 'Fallo: ${paymentResult.status}');
      }
    } catch (e) {
      print(e.toString());
      return StripeResponse(
        ok: false,
        msg: e.toString(),
      );
    }
  }
}
