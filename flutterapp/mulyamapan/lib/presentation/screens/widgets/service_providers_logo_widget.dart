import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mulyankan/core/ui.dart';
import 'package:mulyankan/presentation/screens/widgets/gap_widget.dart';

class ServiceProvidersLogoWidget extends StatelessWidget {
  final String title;
  final List<String> imageUrls;

  const ServiceProvidersLogoWidget({
    super.key,
    required this.title,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.withOpacity(0.5), width: 2.0),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(2, 2),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          const GapWidget(
            size: -5,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const GapWidget(
            size: -5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Directly add rows to children (no need for empty braces)
              for (int i = 0; i < imageUrls.length; i += 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const GapWidget(
                      size: -5,
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (i < imageUrls.length)
                            Image.asset(
                              imageUrls[i],
                              width: kIsWeb ? 50 : 24,
                              height: kIsWeb
                                  ? imageUrls.length <= 4
                                      ? 50
                                      : 33
                                  : imageUrls.length <= 4
                                      ? 24
                                      : 15,
                              fit: BoxFit.scaleDown,
                            ),
                          const GapWidget(size: -10),
                        ],
                      ),
                    ),
                    const GapWidget(
                      size: -10,
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          if (i + 1 < imageUrls.length)
                            Image.asset(
                              imageUrls[i + 1],
                              width: kIsWeb ? 50 : 24,
                              height: kIsWeb
                                  ? imageUrls.length <= 4
                                      ? 50
                                      : 33
                                  : imageUrls.length <= 4
                                      ? 24
                                      : 15,
                              fit: BoxFit.contain,
                            ),
                          const GapWidget(size: -10),
                        ],
                      ),
                    ),
                    const GapWidget(
                      size: -5,
                    ),
                  ],
                ),
            ],
          ),
          const GapWidget(size: -10),
        ],
      ),
    );
  }
}
