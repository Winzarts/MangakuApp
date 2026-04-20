import 'package:flutter/material.dart';
import 'package:mangaku/screens/searchScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangaku/themes/app_colors.dart';
import 'package:mangaku/themes/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:mangaku/providers/homeProvider.dart';
import 'package:mangaku/providers/activityProviders.dart';
import 'package:mangaku/widgets/Carousel.dart';
import 'package:mangaku/widgets/HistoryCard.dart';
import 'package:mangaku/widgets/MangaCard.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routename = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<Homeprovider>().fetchPopular();
        context.read<Homeprovider>().fetchLatest();
        context.read<Activityproviders>().loadAll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.darkAccent,
                      child: SvgPicture.asset(
                        "assets/icons/Icon.svg",
                        width: 25,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Mangaku",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextPrimary,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.notifications, size: 30),
                      color: AppColors.darkTextPrimary,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("assets/images/Profile.jpg"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Divider(thickness: 1, color: AppColors.darkDivider),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  readOnly: true,
                  onTap: () {
                    Navigator.pushNamed(context, Searchscreen.routename);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    hintText: "Search manga, manhwa or manhua",
                    hintStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkTextSecondary,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.darkTextSecondary,
                    ),
                    filled: true,
                    fillColor: AppColors.darkSurfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Consumer<Homeprovider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return _buildCarouselShimmer();
                  }
                  if (provider.popularManga.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return CustomCarousel(mangas: provider.popularManga);
                },
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Text(
                      "New Release",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextPrimary,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "See all",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Consumer<Homeprovider>(
                builder: (context, provider, child) {
                  if (provider.isLoading && provider.latestManga.isEmpty) {
                    return _buildLatestShimmer();
                  }
                  if (provider.latestManga.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: provider.latestManga.length > 10
                          ? 10
                          : provider.latestManga.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: SizedBox(
                            width: 140,
                            child: MangaCard.latest(
                              provider.latestManga[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              Consumer<Activityproviders>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "History",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkTextPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (provider.histories.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                          child: Text(
                            "kamu masih belum baca apapun nih ayo lanjut baca biar ada kegiatan disini ;)",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: AppColors.darkTextSecondary,
                              height: 1.5,
                            ),
                          ),
                        )
                      else ...[
                        ...provider.histories.take(5).toList().asMap().entries.map((entry) {
                          return HistoryCard(
                            index: entry.key,
                            history: entry.value,
                          );
                        }),
                      ],
                      const SizedBox(height: 12),
                    ],
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[800]!,
        highlightColor: Colors.grey[700]!,
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }

  Widget _buildLatestShimmer() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(width: 140, child: MangaCard.shimmer()),
          );
        },
      ),
    );
  }
}
