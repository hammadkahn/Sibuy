import 'dart:convert';
import 'dart:ui';
import 'package:SiBuy/constant/app_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stripe_platform_interface/stripe_platform_interface.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import '../../constant/color_constant.dart';
import '../../models/current_user_chat_model.dart';
import '../../shared/custom_button.dart';
import '../../shared/loader.dart';
import '../../shared/toast.dart';

class CustomCardPaymentScreen extends StatefulWidget {

  CustomCardPaymentScreen({Key? key}) : super(key: key);

  @override
  _CustomCardPaymentScreenState createState() =>
      _CustomCardPaymentScreenState();
}

class _CustomCardPaymentScreenState extends State<CustomCardPaymentScreen> {
  CardDetails _card = CardDetails();
  bool _saveCard = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  late User user;
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool visibleButton = true;
  late OutlineInputBorder border;
  final prefs = SharedPreferences.getInstance();
  var userId = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.APP_PRIMARY_COLOR,
          title: const Text('Add Credit Card'),
        ),
        body: Container(
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/register_bg.png"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration:
              BoxDecoration(color: Colors.white.withOpacity(0.0)),
              child: Column(
                children: <Widget>[
                  CreditCardWidget(
                    glassmorphismConfig: useGlassMorphism
                        ? Glassmorphism.defaultConfig()
                        : null,
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    isHolderNameVisible: true,
                    cardBgColor: AppColors.APP_PRIMARY_COLOR,
                    isSwipeGestureEnabled: true,
                    onCreditCardWidgetChange:
                        (CreditCardBrand creditCardBrand) {},
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CreditCardForm(
                            formKey: formKey,
                            obscureCvv: true,
                            obscureNumber: true,
                            cardNumber: cardNumber,
                            cvvCode: cvvCode,
                            isHolderNameVisible: true,
                            isCardNumberVisible: true,
                            isExpiryDateVisible: true,
                            cardHolderName: cardHolderName,
                            expiryDate: expiryDate,
                            themeColor: AppColors.APP_PRIMARY_COLOR,
                            textColor: Colors.black,
                            cardNumberDecoration: InputDecoration(
                              labelText: '16 Digit Number',
                              hintText: 'XXXX XXXX XXXX XXXX',
                              focusedBorder: border,
                              enabledBorder: border,
                            ),
                            expiryDateDecoration: InputDecoration(
                              focusedBorder: border,
                              enabledBorder: border,
                              labelText: 'Expiry',
                              hintText: 'XX/XX',
                            ),
                            cvvCodeDecoration: InputDecoration(
                              focusedBorder: border,
                              enabledBorder: border,
                              labelText: 'CVC',
                              hintText: 'XXX',
                            ),
                            cardHolderDecoration: InputDecoration(
                              focusedBorder: border,
                              enabledBorder: border,
                              labelText: 'Name',
                            ),
                            onCreditCardModelChange:
                            onCreditCardModelChange,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          visibleButton
                              ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CustomButton(
                            text: 'Submit',
                            onPressed: () {
                                // _handlePayPress(context);
                            },
                          ),
                              )
                              : Loader(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Future<void> _handlePayPress(context) async {
    UiUtils.disableKeyboard(context);
    if (formKey.currentState!.validate()) {
      setState(() {
        visibleButton = false;
      });
      _card = _card.copyWith(
          cvc: cvvCode,
          number: cardNumber,
          expirationMonth: int.parse(expiryDate.split('/')[0]),
          expirationYear: int.parse(expiryDate.split('/')[1]));

      // if (widget.amount == 0) {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //       content:
      //       Text('success_the_payment_was_confirmed_successfully')));
      //   proceed(customerId: '');
      // }
      //
      // await Stripe.instance.dangerouslyUpdateCardDetails(_card);
      try {
        // final billingDetails = BillingDetails(
        //   email: user.email,
        //   phone: user.phone,
        //   address: Address(
        //     city: user.address,
        //     country: user.address,
        //     line1: user.address,
        //     line2: '',
        //     state: '',
        //     postalCode: '77063',
        //   ),
        // );
        //
        // // 2. Create payment method
        // final paymentMethod = await Stripe.instance.createPaymentMethod(params: PaymentMethodParams.card(
        //   paymentMethodData: PaymentMethodData(
        //     billingDetails: billingDetails,
        //   ),
        // ));
        //
        // if (widget.route == 'subscription') {
        //
        //   String? customer = '';
        //   if(user.stripeCustomerId == ''){
        //     var result = await api.createCustomer(user, paymentMethod.id);
        //     if(result is String){
        //       customer = result;
        //     }
        //     else{
        //       setState(() {
        //         visibleButton = true;
        //       });
        //       ToastUtil.showToast(context, '${result['error']['message']}');
        //       return;
        //     }
        //   }
        //   else{
        //     customer = user.stripeCustomerId;
        //   }
        //
        //   var endTime = DateTime.now().add(Duration(days: int.parse(widget.priceDuration))).toUtc().millisecondsSinceEpoch.toString();
        //   endTime = endTime.substring(0, endTime.length-3);
        //
        //   // final paymentIntentResult = await api.createSubscription(
        //   //   customerId: 'cus_L6A3wBiC6izOJG',
        //   //   paymentMethodId: 'pm_1KPxiMKbryNCjFZ4BgAUSWqE',
        //   //   priceId: 'price_1KPyBNKbryNCjFZ4nDHS5ZRr',
        //   //   coupon: widget.coupon,
        //   //   promoCodeId: widget.promotionId,
        //   //   endAt: int.parse(endTime),
        //   // );
        //
        //   final paymentIntentResult = await api.createSubscription(
        //     customerId: customer??'',
        //     paymentMethodId: paymentMethod.id,
        //     priceId: kReleaseMode ? widget.priceId : 'price_1KPyBNKbryNCjFZ4nDHS5ZRr',
        //     coupon: widget.coupon,
        //     promoCodeId: widget.promotionId,
        //     endAt: int.parse(endTime),
        //   );
        //
        //   if (paymentIntentResult != null &&
        //       paymentIntentResult['error'] != null) {
        //     // Error during creating or confirming Intent
        //     setState(() {
        //       visibleButton = true;
        //     });
        //     ToastUtil.showToast(context, '${paymentIntentResult['error']['message']}');
        //     return;
        //   } else if (paymentIntentResult != null && paymentIntentResult['status'] == 'active') {
        //     // Payment succeeded
        //     ToastUtil.showToast(context, 'el pago se confirma con éxito');
        //     proceed(customerId: customer??'');
        //   } else {
        //     setState(() {
        //       visibleButton = true;
        //     });
        //     ToastUtil.showToast(
        //         context, '${paymentIntentResult['error']['message']}');
        //   }
        // }
        // else{
        //   // cart scenario
        //   final paymentIntentResult = await api.createPaymentIntent(
        //       amount: (widget.amount * 100).toInt(),
        //       stripeCurrency: 'eur',
        //       paymentMethodId: paymentMethod.id);
        //
        //   if (paymentIntentResult != null &&
        //       paymentIntentResult['error'] != null) {
        //     // Error during creating or confirming Intent
        //     setState(() {
        //       visibleButton = true;
        //     });
        //     ToastUtil.showToast(
        //         context, '${paymentIntentResult['error']['message']}');
        //     return;
        //   } else if (paymentIntentResult != null &&
        //       paymentIntentResult['client_secret'] != null &&
        //       paymentIntentResult['status'] == 'succeeded') {
        //     // Payment succeeded
        //     ToastUtil.showToast(context, 'el pago se confirma con éxito');
        //     proceed(customerId: '');
        //   } else if (paymentIntentResult != null &&
        //       paymentIntentResult['client_secret'] != null &&
        //       paymentIntentResult['status'] != 'succeeded') {
        //     // 4. if payment requires action calling handleCardAction
        //     final paymentIntent = await Stripe.instance.handleNextAction(paymentIntentResult['client_secret']);
        //
        //     if (paymentIntent.status ==
        //         PaymentIntentsStatus.RequiresConfirmation) {
        //       setState(() {
        //         visibleButton = true;
        //       });
        //       ToastUtil.showToast(
        //           context, 'error: ' + paymentIntent.status.toString());
        //       // 5. Call API to confirm intent
        //       // await confirmIntent(paymentIntent.id);
        //       // Stripe.instance..completeNativePayRequest()
        //     } else {
        //       // Payment succeeded
        //       ToastUtil.showToast(context, '${paymentIntentResult['error']}');
        //       proceed(customerId: '');
        //     }
        //   } else {
        //     setState(() {
        //       visibleButton = true;
        //     });
        //     ToastUtil.showToast(
        //         context, '${paymentIntentResult['error']['message']}');
        //   }
        // }

      } catch (error) {
        ToastUtil.showToast(context, error.toString());
        setState(() {
          visibleButton = true;
        });
      }
    } else {
      ToastUtil.showToast(context, 'Missing Fields');
    }
  }
  proceed({
    required String customerId,
  }) async {
    // var payment = await userApi.createPayment(
    //     widget.productId, widget.productName, widget.amount, int.parse(widget.priceDuration));
    // if (payment is bool && payment) {
    //   userApi
    //       .updateUser(
    //           user.firstName,
    //           user.lastName,
    //           user.mobile,
    //           user.email,
    //           user.country,
    //           user.city,
    //           user.address,
    //           user.countryCode,
    //           user.dob,
    //           true)
    //       .then((val) {
    //     if (val.contains("error")) {
    //       setState(() {
    //         visibleButton = true;
    //       });
    //       ToastUtil.showToast(context, val.replaceAll("error: ", ""));
    //     } else {
    //       setState(() {
    //         visibleButton = true;
    //       });
    //       Navigator.of(context).popUntil((route) => route.isFirst);
    //       Navigator.pushReplacement(
    //           context,
    //           new MaterialPageRoute(
    //               builder: (context) => new QuestionareList(id: userId,)));
    //     }
    //   });
    // } else {
    //   if (payment.contains("error")) {
    //     ToastUtil.showToast(context, payment.replaceAll("error: ", ""));
    //   }
    //   setState(() {
    //     visibleButton = true;
    //   });
    // }
  }
}