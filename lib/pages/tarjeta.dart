import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:stripe_app/bloc/pagar/bloc.dart';
import 'package:stripe_app/models/tarjetaCredito.dart';
import 'package:stripe_app/widgets/totalPayButton.dart';

class TarjetaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TarjetaCredito tarjeta =
        BlocProvider.of<PagarBloc>(context).state.tarjeta;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pagar'),
        leading: IconButton(
          icon: (Platform.isIOS)
              ? Icon(Icons.arrow_back_ios)
              : Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<PagarBloc>(context).add(OnDesactivarTarjeta());
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Container(), // Estiramos todo
          Hero(
            tag: tarjeta.cardNumber,
            child: CreditCardWidget(
              cardNumber: tarjeta.cardNumberHidden,
              expiryDate: tarjeta.expiracyDate,
              cardHolderName: tarjeta.cardHolderName,
              cvvCode: tarjeta.cvv,
              showBackView: false,
            ),
          ),
          Positioned(
            bottom: 0,
            child: TotalPayButton(),
          ),
        ],
      ),
    );
  }
}
