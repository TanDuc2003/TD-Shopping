import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  final AddressServices addressServices = AddressServices();

  String addressTobeUser = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    phoneController.dispose();
    cityController.dispose();
    areaController.dispose();
  }

// thanh toán khi nhận hàng
  void onPayAtHome(String addressFromProvider) {
    addressTobeUser = "";
    bool isForm = flatBuildingController.text.isNotEmpty ||
        phoneController.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        areaController.text.isNotEmpty;
    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressTobeUser =
            '${flatBuildingController.text},${areaController.text},${cityController.text}-${phoneController.text}';
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
        phoneController.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        areaController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressTobeUser =
            '${flatBuildingController.text},  ${areaController.text},  ${cityController.text}-  ${phoneController.text}';
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
                    const Text(
                      "Địa Chỉ Hiện Tại",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(12),
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
                      "Địa Chỉ Khác",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
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
                      hintText: '   Số nhà',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: areaController,
                      hintText: '   Tên đường, Hẻm',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: cityController,
                      hintText: '   Tình/Thành Phố',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: phoneController,
                      hintText: '   Số Điện Thoại',
                      type: TextInputType.phone,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Phương Thức Thanh Toán",
                style: TextStyle(
                  color: Colors.red.shade600,
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 40),
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
                  child: const Text(
                    "Thanh Toán Bằng Momo",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
