import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:momo_vn/momo_vn.dart';
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

  // late MomoVn _momoPay;
  // late PaymentResponse _momoPaymentResult;
  // ignore: non_constant_identifier_names
  // late String _paymentStatus;
  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
      amount: widget.totalAmout,
      label: "Tổng Tiền",
      status: PaymentItemStatus.final_price,
    ));

    // _momoPay = MomoVn();
    // _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _paymentStatus = "";
    // initPlatformState();
  }

  // Future<void> initPlatformState() async {
  //   if (!mounted) return;
  //   setState(() {});
  // }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    pinController.dispose();
    cityController.dispose();
    areaController.dispose();

    // _momoPay.clear();
  }

// thanh toán khi nhận hàng
  void onPayAtHome(String addressFromProvider) {
    addressTobeUser = "";
    bool isForm = flatBuildingController.text.isNotEmpty ||
        pinController.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        areaController.text.isNotEmpty;
    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressTobeUser =
            '${flatBuildingController.text},${areaController.text},${cityController.text}-${pinController.text}';
        if (Provider.of<UserProvider>(context, listen: false)
            .user
            .address
            .isEmpty) {
          addressServices.saveUserAddress(
              context: context, address: addressTobeUser);
        }
        addressServices.placeOrder(
          context: context,
          address: addressTobeUser,
          totalSum: double.parse(widget.totalAmout),
        );
      } else {
        throw Exception("vui lòng nhập đúng");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressTobeUser = addressFromProvider;
      if (Provider.of<UserProvider>(context, listen: false)
          .user
          .address
          .isEmpty) {
        addressServices.saveUserAddress(
            context: context, address: addressTobeUser);
      }
      addressServices.placeOrder(
        context: context,
        address: addressTobeUser,
        totalSum: double.parse(widget.totalAmout),
      );
    } else {
      showSnackBar(context, "Lỗi ");
    }
    Future.delayed(
      const Duration(seconds: 1),
      () {
        setState(() {
          Navigator.pop(context);
        });
      },
    );
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
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
      addressServices.saveUserAddress(
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
      showSnackBar(context, "Lỗi ");
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
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[100],
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.black.withOpacity(0.5), width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => onPayAtHome(address),
                  child: const Text(
                    "Thanh Toán Khi Nhận Hàng",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 165, 0, 100),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.black.withOpacity(0.5), width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Chức năng thanh toán momo'),
                            content: const Text(
                                'Thanh toán momo sễ được cập nhật trong thời gian sắp tới '),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          )),
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Image(
                            image: AssetImage("assets/images/logo-momo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Thanh Toán Bằng Momo",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _setState() {
  //   _paymentStatus = 'Đã chuyển thanh toán';
  //   if (_momoPaymentResult.isSuccess == true) {
  //     _paymentStatus += "\nTình trạng: Thành công.";
  //     _paymentStatus +=
  //         "\nSố điện thoại: " + _momoPaymentResult.phoneNumber.toString();
  //     _paymentStatus += "\nExtra: " + _momoPaymentResult.extra!;
  //     _paymentStatus += "\nToken: " + _momoPaymentResult.token.toString();
  //   } else {
  //     _paymentStatus += "\nTình trạng: Thất bại.";
  //     _paymentStatus += "\nExtra: " + _momoPaymentResult.extra.toString();
  //     _paymentStatus += "\nMã lỗi: " + _momoPaymentResult.status.toString();
  //   }
  // }

  // void _handlePaymentSuccess(PaymentResponse response) {
  //   setState(() {
  //     _momoPaymentResult = response;
  //     _setState();
  //   });
  //   Fluttertoast.showToast(
  //       msg: "THÀNH CÔNG: " + response.phoneNumber.toString(),
  //       toastLength: Toast.LENGTH_SHORT);
  // }

  // void _handlePaymentError(PaymentResponse response) {
  //   setState(() {
  //     _momoPaymentResult = response;
  //     _setState();
  //   });
  //   Fluttertoast.showToast(
  //       msg: "THẤT BẠI: " + response.message.toString(),
  //       toastLength: Toast.LENGTH_SHORT);
  // }
}
