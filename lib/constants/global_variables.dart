import 'package:flutter/material.dart';

// String uri = "https://td-shoping-server.herokuapp.com";

String ipconfig = "192.168.0.113";
// String ipconfig = "192.168.1.8";
String uri = "http://$ipconfig:3000";

class GlobalVariables {
  // Màu sắc
  static String igError =
      "https://cuocsongdungnghia.com/wp-content/uploads/2018/05/loi-hinh-anh.jpg";
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );
  // Colors
  static const kBackgroundColor = Color(0xFFD2FFF4);
  static const kPrimaryColor = Color(0xFFD2FFF4);
  static const kSecondaryColor = Color.fromARGB(255, 20, 6, 15);
  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  //ảnh demo
  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
    'https://lh3.googleusercontent.com/cC64vTeWiJ2n1gpkch8RKAX2p-tB3PgXhS3WNmvJDNFsr0hNNdx5SdjXKYAHQkTJ41GHSc3CREjtPrPgBFdkfIGWSa-COMhy=w1920-rw',
    'https://lh3.googleusercontent.com/qj1ewOX6-3x_2ythkRnxLD0I_Mx1eXsr6zLzUnbFbBXh1r63uR_aON6mBXrJepDeWVAvMTTctCBbeCOz9u0sEVNPA5_OnBhf=w1920-rw',
    'https://lh3.googleusercontent.com/a3s0ARkoipVKnKMr1YN7xRIvS-s3HM4EYXfzlKhpZNMBGhNvYmNTU8xzLlCLjqBN_2pNTo2EUdzQ5iYv2VeyZNeOVhN29QJs=w1920-rw',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Điện Thoại',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Thiết Yếu',
      'image': 'assets/images/essentials.jpeg',
    },
    {
      'title': 'Gia Dụng',
      'image': 'assets/images/appliances.jpeg',
    },
    {
      'title': 'Sách',
      'image': 'assets/images/books.jpeg',
    },
    {
      'title': 'Thời Trang',
      'image': 'assets/images/fashion.jpeg',
    },
  ];
}
