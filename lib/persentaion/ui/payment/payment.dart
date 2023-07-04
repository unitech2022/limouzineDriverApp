import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';

class PaymentMethods extends StatelessWidget {
  PaymentMethods({super.key});

  final paymentConfig = PaymentConfig(
    publishableApiKey: 'pk_test_83UURo8Mjym2nc7jgxKhJLrVKrzgqNhogC5M4RoY',
    amount: 324, // SAR 257.58
    description: 'order #1324',

    metadata: {'size': '250g'},
    // applePay: ApplePayConfig(merchantId: 'YOUR_MERCHANT_ID', label: 'ليموزين'),
  );

  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:

          break;
        case PaymentStatus.failed:
        // handle failure.
          break;
        case PaymentStatus.initiated:
          // TODO: Handle this case.
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 200,),
          // ApplePay(
          //   config: paymentConfig,
          //   onPaymentResult: onPaymentResult,
          // ),
          // const Text("or"),
          CreditCard(
            config: paymentConfig,
            onPaymentResult: onPaymentResult,
          )
        ],
      ),
    );
  }
}