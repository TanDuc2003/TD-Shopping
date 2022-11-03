import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:td_shoping/common/widgets/loadding.dart';
import 'package:td_shoping/constants/global_variables.dart';
import 'package:td_shoping/constants/utils.dart';
import 'package:td_shoping/features/address/services/address_services.dart';

import '../../../common/widgets/custom_textfield.dart';
import '../../../provider/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = "/address";
  final String totalAmout;
  const AddressScreen({super.key, required this.totalAmout});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  final AddressServices addressServices = AddressServices();

  String addressTobeUser = "";

  List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
      amount: widget.totalAmout,
      label: "Tổng Tiền",
      status: PaymentItemStatus.final_price,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    pinController.dispose();
    cityController.dispose();
    areaController.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.savaUserAddress(
          context: context, address: addressTobeUser);
    }
    addressServices.placeOrder(
      context: context,
      address: addressTobeUser,
      totalSum: double.parse(widget.totalAmout),
    );
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.savaUserAddress(
          context: context, address: addressTobeUser);
    }
    addressServices.placeOrder(
      context: context,
      address: addressTobeUser,
      totalSum: double.parse(widget.totalAmout),
    );
  }

  void payPressed(String addressFromProvider) {
    addressTobeUser = "";
    bool isForm = flatBuildingController.text.isNotEmpty ||
        pinController.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        areaController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressTobeUser =
            '${flatBuildingController.text},${areaController.text},${cityController.text}-${pinController.text}';
      } else {
        throw Exception("vui lòng nhập đúng");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressTobeUser = addressFromProvider;
    } else {
      showSnackBar(context, "Lôi");
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Or",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: 'Căn hộ, Số nhà, Tòa nhà',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: areaController,
                      hintText: 'Tên đường,Tòa nhà,Số nhà',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: pinController,
                      hintText: 'PinCode',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: cityController,
                      hintText: 'Tình/Thành Phố',
                    ),
                  ],
                ),
              ),
              ApplePayButton(
                width: double.infinity,
                style: ApplePayButtonStyle.white,
                type: ApplePayButtonType.buy,
                paymentConfigurationAsset: 'applepay.json',
                onPaymentResult: onApplePayResult,
                onPressed: () => payPressed(address),
                paymentItems: paymentItems,
                height: 50,
                margin: const EdgeInsets.only(top: 15),
              ),
              const SizedBox(height: 10),
              GooglePayButton(
                paymentConfigurationAsset: 'gpay.json',
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                height: 50,
                onPressed: () => payPressed(address),
                width: double.infinity,
                loadingIndicator: const Loading(),
                margin: const EdgeInsets.only(top: 15),
                type: GooglePayButtonType.buy,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
