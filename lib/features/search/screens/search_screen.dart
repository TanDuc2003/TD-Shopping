import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:td_shoping/common/widgets/loadding.dart';
import 'package:td_shoping/constants/utils.dart';
import 'package:td_shoping/features/details_product/screens/products_details_screen.dart';
import 'package:td_shoping/features/home/widgets/address_box.dart';
import 'package:td_shoping/features/search/services/search_services.dart';
import 'package:td_shoping/features/search/widgets/search_product.dart';
import 'package:td_shoping/models/product.dart';

import '../../../constants/global_variables.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({
    super.key,
    required this.searchQuery,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

//speech to text
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';

  @override
  void initState() {
    super.initState();
    fetchSearchProducts();
    _initSpeech();
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

// lấy tất cả sản phẩm
  void fetchSearchProducts() async {
    products = await searchServices.fetchSearchProducts(
      context: context,
      searchQuery: widget.searchQuery,
    );
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: SizedBox(
                  height: 42,
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
                              color: Colors.black,
                              size: 23,
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
                          hintText: widget.searchQuery,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          )),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Ấn để nói',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Khi nói xong giữ tiếp 2 giây rồi ấn thả",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.amber),
                        ),
                        Container(
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
                      ],
                    ),
                  ),
                ),
                borderRadius: BorderRadius.circular(50),
                splashColor: Colors.black12,
                child: Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.only(left: 10, right: 5),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.black54,
                    size: 35,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: products == null
          ? const Loading()
          : Column(
              children: [
                const AddressBox(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ProductDetailsScreen.routeName,
                              arguments: products![index],
                            );
                          },
                          child: SearchProduct(product: products![index]));
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
