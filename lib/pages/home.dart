import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:stripe_app/data/tarjetas.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/pages/tarjeta.dart';
import 'package:stripe_app/widgets/totalPayButton.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              /*
              mostrarLoading(context);
              await Future.delayed(Duration(seconds: 2));
              Navigator.pop(context);
              */
              mostrarAlerta(context, 'Hola', 'Mundo');
            },
            icon: Icon(Icons.add),
          )
        ],
        title: Text('Pagar'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 200,
            width: size.width,
            height: size.height,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.88),
              physics: BouncingScrollPhysics(),
              itemCount: tarjetas.length,
              itemBuilder: (_, int index) {
                final tarjeta = tarjetas[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, navegarFadeIn(context, TarjetaPage()));
                  },
                  child: Hero(
                    tag: tarjeta.cardNumber,
                    child: CreditCardWidget(
                      cardNumber: tarjeta.cardNumberHidden,
                      expiryDate: tarjeta.expiracyDate,
                      cardHolderName: tarjeta.cardHolderName,
                      cvvCode: tarjeta.cvv,
                      showBackView: false,
                    ),
                  ),
                );
              },
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
