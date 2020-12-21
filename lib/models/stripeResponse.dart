import 'package:meta/meta.dart';

class StripeResponse {
  final bool ok;
  final String msg;

  StripeResponse({
    @required this.ok,
    this.msg,
  });
}
