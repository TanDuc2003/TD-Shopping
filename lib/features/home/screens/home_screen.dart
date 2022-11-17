import 'package:avatar_glow/avatar_glow.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:td_shoping/constants/utils.dart';
import 'package:td_shoping/features/cart/screen/cart_screen.dart';
import 'package:td_shoping/features/home/screens/all_product_screen.dart';
import 'package:td_shoping/features/home/widgets/address_box.dart';
import 'package:td_shoping/features/home/widgets/carousel_image.dart';
import 'package:td_shoping/features/home/widgets/deal_of_day.dart';
import 'package:td_shoping/features/home/widgets/top_categories.dart';
import 'package:td_shoping/features/search/screens/search_screen.dart';
import 'package:td_shoping/provider/user_provider.dart';

import '../../../common/widgets/loadding.dart';
import '../../../constants/global_variables.dart';
import '../../../models/product.dart';
import '../services/home_services.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  RefreshController refreshC = RefreshController();
  List<Product>? products;
  final HomeServices homeservices = HomeServices();

//speech to text
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';

  void refreshData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      getAllProduct();
      setState(() {});
      refreshC.refreshCompleted();
    } catch (e) {
      refreshC.refreshFailed();
    }
  }

  void loadData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      getAllProduct();
      setState(() {});
      refreshC.loadComplete();
    } catch (e) {
      refreshC.loadFailed();
    }
  }

  @override
  void initState() {
    super.initState();
    getAllProduct();
    _initSpeech();
  }

  getAllProduct() async {
    products = await homeservices.getallProduct(context);
    setState(() {});
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    lastWords = '';
    await speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    if (lastWords.isEmpty) {
      showSnackBar(context, "Hãy thử nói lại");
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      Navigator.pushNamed(context, SearchScreen.routeName,
          arguments: lastWords);
    }
    await speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    lastWords = result.recognizedWords;
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Icon(
                            Icons.search,
                            color: Colors.black38,
                            size: 23,
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              title: const Text(
                                'Ấn đẻ nói',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                              content: Container(
                                color: Colors.transparent,
                                child: GestureDetector(
                                  onLongPress: () {
                                    _startListening();
                                  },
                                  onLongPressUp: () {
                                    _stopListening();
                                  },
                                  child: AvatarGlow(
                                    glowColor: Colors.red,
                                    endRadius: 60.0,
                                    child: Material(
                                      elevation: 8.0,
                                      shape: const CircleBorder(),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[100],
                                        radius: 30.0,
                                        child: Image.asset(
                                          'assets/category/mic.png',
                                          height: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          child: Icon(
                            speechToText.isNotListening
                                ? Icons.mic
                                : Icons.mic_off,
                            size: 30,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Nhập tên sản phẩm ...',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  PageTransition(
                    child: const CartScreen(),
                    type: PageTransitionType.rightToLeft,
                  ),
                ),
                child: Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.only(left: 20, right: 10),
                  child: Badge(
                    elevation: 0,
                    animationType: BadgeAnimationType.slide,
                    badgeContent: Text(
                      userCartLen.toString(),
                      style: const TextStyle(color: Colors.red),
                    ),
                    badgeColor: Colors.white30,
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black87,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SmartRefresher(
            physics: const BouncingScrollPhysics(),
            controller: refreshC,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: refreshData,
            onLoading: loadData,
            header: const WaterDropHeader(
              waterDropColor: Colors.pink,
            ),
            footer: CustomFooter(
              builder: (context, mode) {
                if (mode == LoadStatus.idle) {
                  return const SizedBox();
                } else if (mode == LoadStatus.loading) {
                  return const Center(
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: Loading2(),
                    ),
                  );
                } else if (mode == LoadStatus.failed) {
                  return const Center(
                      child: Text("Tải thất bại! Click để tải lại !"));
                } else if (mode == LoadStatus.canLoading) {
                  return const Center(
                      child: Text(
                    "Tải Thêm",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ));
                } else {
                  return const Center(child: Text("Không thể tải dữ liệu"));
                }
              },
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AddressBox(),
                  const SizedBox(height: 10),
                  const CarouselImage(),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Shimmer.fromColors(
                      period: const Duration(seconds: 3),
                      baseColor: Colors.black,
                      direction: ShimmerDirection.ltr,
                      highlightColor: Colors.red,
                      child: const Center(
                        child: Text(
                          "Danh Mục Sản Phẩm",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Categories(),
                  const DealOfDay(),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Shimmer.fromColors(
                      period: const Duration(seconds: 3),
                      baseColor: Colors.black,
                      highlightColor: Colors.orange,
                      child: const Text(
                        "Tất Cả Sản Phẩm",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  products == null
                      ? const Center(
                          child: Text(
                            "Đang Tải ...",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : AllProductsScreen(product: products!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
