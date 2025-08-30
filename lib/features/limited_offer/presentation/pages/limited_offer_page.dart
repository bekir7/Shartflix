import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inner_shadow_container/inner_shadow_container.dart';

class LimitedOfferDialog extends StatefulWidget {
  const LimitedOfferDialog({super.key});

  @override
  State<LimitedOfferDialog> createState() => _LimitedOfferDialogState();
}

class _LimitedOfferDialogState extends State<LimitedOfferDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxHeight: 654),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Stack(children: [
        // Radial gradient background
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFE53935),
                  const Color(0xFFB71C1C),
                  const Color(0xFF8E0000),
                  const Color(0xFF4A0000),
                  const Color(0xFF000000),
                ],
                stops: [0.0, 0.2, 0.4, 0.7, 1.0],
                radius: 0.6,
                center: Alignment.topCenter,
              ),
            ),
          ),
        ),
        // Content
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                child: Column(
                  children: [
                    const Text(
                      'Sınırlı Teklif',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Euclid Circular A',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Jeton paketin\'ni seçerek bonus kazanın ve yeni bölümlerin kilidini açın!',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12,
                        height: 1.4,
                        fontFamily: 'Euclid Circular A',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Bonuses Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 366.08,
                        height: 173.71,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(20, 255, 255, 255),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Alacağınız Bonuslar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'EuclidCircularA',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: _buildBonusItem(
                                    'assets/icons/Ellipse.png',
                                    'assets/icons/diamond.png',
                                    'Premium\nHesap',
                                    const Color(0xFFFF3B30),
                                  ),
                                ),
                                Expanded(
                                  child: _buildBonusItem(
                                    'assets/icons/Ellipse.png',
                                    'assets/icons/ikikalp.png',
                                    'Daha Fazla\nEşleşme',
                                    const Color(0xFFFF6B9D),
                                  ),
                                ),
                                Expanded(
                                  child: _buildBonusItem(
                                    'assets/icons/Ellipse.png',
                                    'assets/icons/ok.png',
                                    'Öne\nÇıkarma',
                                    const Color(0xFFFF3B30),
                                  ),
                                ),
                                Expanded(
                                  child: _buildBonusItem(
                                    'assets/icons/Ellipse.png',
                                    'assets/icons/kalp.png',
                                    'Daha Fazla\nBeğeni',
                                    const Color(0xFFFF6B9D),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Token Packages Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kilidi açmak için bir jeton paketi seçin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'EuclidCircularA',
                      ),
                    ),
                    const SizedBox(height: 16),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // Ekran genişliğini al (padding'leri çıkar)
                        final availableWidth = constraints.maxWidth;
                        // 3 kutucuk + 2 boşluk için hesapla
                        final totalSpacing = 16.0; // 2 * 8px boşluk
                        final totalWidth = availableWidth - totalSpacing;
                        final itemWidth = totalWidth / 3;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: itemWidth,
                              child: _buildTokenPackage(
                                10,
                                200,
                                330,
                                '₺99,99',
                                const Color(0xFFFF3B30),
                              ),
                            ),
                            SizedBox(
                              width: itemWidth,
                              child: _buildTokenPackage(
                                70,
                                2000,
                                3375,
                                '₺799,99',
                                const Color(0xFF8A2BE2),
                              ),
                            ),
                            SizedBox(
                              width: itemWidth,
                              child: _buildTokenPackage(
                                35,
                                1000,
                                1350,
                                '₺399,99',
                                const Color(0xFFFF3B30),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Bottom Button
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                child: Container(
                  width: 367.14,
                  height: 53.31,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE50914).withOpacity(0.6),
                        blurRadius: 12,
                        spreadRadius: 1,
                        offset: const Offset(0, -8),
                      ),
                      BoxShadow(
                        color: const Color(0xFFE50914).withOpacity(0.3),
                        blurRadius: 24,
                        spreadRadius: 0.5,
                        offset: const Offset(0, -16),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE50914),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Tüm Jetonları Gör',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Euclid Circular A',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildBonusItem(
      String backgroundIcon, String foregroundIcon, String label, Color color) {
    return Column(
      children: [
        SizedBox(
          width: 55,
          height: 55,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background ellipse
              backgroundIcon.endsWith('.png')
                  ? Image.asset(
                      backgroundIcon,
                      width: 55,
                      height: 55,
                    )
                  : SvgPicture.asset(
                      backgroundIcon,
                      width: 55,
                      height: 55,
                    ),
              // Foreground icon - check if it's PNG or SVG
              foregroundIcon.endsWith('.png')
                  ? Image.asset(
                      foregroundIcon,
                      width: 28,
                      height: 28,
                    )
                  : SvgPicture.asset(
                      foregroundIcon,
                      width: 28,
                      height: 28,
                    ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.2,
            fontFamily: 'Euclid Circular A',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTokenPackage(int bonusPercent, int originalAmount,
      int finalAmount, String price, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final containerWidth = constraints.maxWidth;
          final containerHeight =
              containerWidth * (217.83 / 111.71); // Oranı koru

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: containerWidth,
                height: containerHeight,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topLeft,
                    radius: 2.5,
                    colors: finalAmount == 330
                        ? [
                            const Color(0xFF6F060B),
                            const Color(0xFFE50914),
                          ]
                        : finalAmount == 3375
                            ? [
                                const Color(0xFF5949E6),
                                const Color(0xFFE50914),
                              ]
                            : finalAmount == 1350
                                ? [
                                    const Color(0xFF6F060B),
                                    const Color(0xFFE50914),
                                  ]
                                : [
                                    const Color(0xFF6F060B),
                                    const Color(0xFFE50914),
                                  ],
                    stops: const [0.0, 0.7],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 16, 8, 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 12),
                          // Center content
                          Column(
                            children: [
                              // Original Price (crossed out)
                              Text(
                                '$originalAmount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.white,
                                  fontFamily: 'Euclid Circular A',
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Final Amount
                              Text(
                                '$finalAmount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  height: 1.1,
                                  fontFamily: 'Montserrat',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Jeton',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  height: 1.1,
                                  fontFamily: 'Euclid Circular A',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          // Bottom content
                          Column(
                            children: [
                              // Price
                              Text(
                                price,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Montserrat',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 2),
                              // Subscription Detail
                              Text(
                                'Başına haftalık',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                  fontFamily: 'Euclid Circular A',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Inset shadow overlay
                    Container(
                      width: containerWidth,
                      height: containerHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.3),
                            Colors.transparent,
                            Colors.transparent,
                            Colors.white.withOpacity(0.1),
                          ],
                          stops: const [0.0, 0.3, 0.7, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Bonus Badge - positioned outside the container
              Positioned(
                top: -10,
                left: 0,
                right: 0,
                child: Center(
                  child: InnerShadowContainer(
                    width: 61,
                    height: 25,
                    backgroundColor: bonusPercent == 10
                        ? const Color(0xFF6F060B)
                        : bonusPercent == 35
                            ? const Color(0xFF6F060B)
                            : bonusPercent == 70
                                ? const Color(0xFF5949E6)
                                : color,
                    borderRadius: 12,
                    blur: 4,
                    offset: const Offset(2, 2),
                    shadowColor: Colors.white.withOpacity(0.4),
                    isShadowTopLeft: true,
                    isShadowTopRight: true,
                    isShadowBottomLeft: true,
                    isShadowBottomRight: true,
                    child: Center(
                      child: Text(
                        '+$bonusPercent%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Euclid Circular A',
                          shadows: (bonusPercent == 10 ||
                                  bonusPercent == 35 ||
                                  bonusPercent == 70)
                              ? [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    offset: const Offset(0, 1),
                                    blurRadius: 1,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Static method to show the dialog
class LimitedOfferPage {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: const LimitedOfferDialog(),
      ),
    );
  }
}
