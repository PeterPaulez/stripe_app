import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stripe_app/bloc/pagar/bloc.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/services/stripe.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TotalPayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool pagoTarjeta =
        BlocProvider.of<PagarBloc>(context).state.tarjetaActiva;
    final double amount = BlocProvider.of<PagarBloc>(context).state.dineroPagar;
    final String currency = BlocProvider.of<PagarBloc>(context).state.moneda;
    return Container(
      width: size.width,
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('$amount $currency', style: TextStyle(fontSize: 20)),
            ],
          ),
          (pagoTarjeta) ? _BtnPayCard() : _BtnPayOS(),
        ],
      ),
    );
  }
}

class _BtnPayOS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Icon(
            Platform.isAndroid
                ? FontAwesomeIcons.google
                : FontAwesomeIcons.apple,
            color: Colors.white,
          ),
          Text(' Pay', style: TextStyle(color: Colors.white, fontSize: 22)),
        ],
      ),
    );
  }
}

class _BtnPayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tarjeta = BlocProvider.of<PagarBloc>(context).state.tarjeta;
    final mesAno = tarjeta.expiracyDate.split('/');
    final String amount =
        BlocProvider.of<PagarBloc>(context).state.dineroPagarString;
    final String currency = BlocProvider.of<PagarBloc>(context).state.moneda;
    return MaterialButton(
      onPressed: () async {
        print(tarjeta.cardHolderName);
        mostrarLoading(context);
        final stripeService = new StripeService();
        final answer = await stripeService.pagarTarjetaExistente(
          amount: amount,
          currency: currency,
          card: CreditCard(
            number: tarjeta.cardNumber,
            expMonth: int.parse(mesAno[0]),
            expYear: int.parse(mesAno[1]),
          ),
        );
        Navigator.pop(context);

        if (answer.ok) {
          mostrarAlerta(
            context,
            'Tarjeta OK',
            'Todo se guardo correctamente en Stripe',
          );
        } else {
          mostrarAlerta(context, 'Algo salió mal', answer.msg);
        }
      },
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Icon(FontAwesomeIcons.creditCard, color: Colors.white),
          Text('  Pay', style: TextStyle(color: Colors.white, fontSize: 22)),
        ],
      ),
    );
  }
}
