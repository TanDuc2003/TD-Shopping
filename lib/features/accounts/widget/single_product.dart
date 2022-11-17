import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final int? index;
  final int? status;
  final bool ishowStatus;
  const SingleProduct({
    super.key,
    required this.image,
    this.status,
    this.index = 0,
    this.ishowStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.4), width: 1.5),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: ishowStatus
            ? Container(
                width: 180,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SizedBox(
                  height: 120,
                  child: Image.network(
                    image,
                    fit: BoxFit.contain,
                    width: 160,
                  ),
                ),
              )
            : Column(
                children: [
                  Container(
                    width: 180,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: SizedBox(
                      height: 120,
                      child: Image.network(
                        image,
                        fit: BoxFit.contain,
                        width: 160,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (status == 0)
                    const Text(
                      "Chờ xác nhận",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  if (status == 1)
                    const Text(
                      "Chờ lấy hàng",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  if (status == 2)
                    const Text(
                      "Đang giao",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  if (status == 3)
                    const Text(
                      "Giao thành công",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
