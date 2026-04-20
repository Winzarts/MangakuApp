import 'package:flutter/material.dart';

/// Kumpulan warna yang digunakan di seluruh aplikasi MangaKu.
/// Dibagi menjadi dua palette: Dark dan Light.
class AppColors {
  AppColors._();

  // ──────────────────────────────────────────────
  //  DARK THEME COLORS
  // ──────────────────────────────────────────────

  // Warna Tipe Komik sepeti Manga, Manhwa, dan Manhua
  static const Color manga = Color(0xFF0f85fa);
  static const Color manhwa = Color(0xFFfa0fea);
  static const Color manhua = Color(0xFFfabf0f);

  /// Warna latar utama (Charcoal)
  static const Color darkBackground = Color(0xFF2F3437);

  /// Warna latar alternatif (Dark Navy)
  static const Color darkSurface = Color(0xFF1A202C);

  /// Warna surface yang sedikit lebih terang untuk card/elevated elements
  static const Color darkSurfaceVariant = Color(0xFF3A3F42);

  /// Warna teks utama (Creamy White)
  static const Color darkTextPrimary = Color(0xFFE2E8F0);

  /// Warna teks sekunder (Light Gray)
  static const Color darkTextSecondary = Color(0xFFA0AEC0);

  /// Warna aksen utama (Sky Blue)
  static const Color darkAccent = Color(0xFF63B3ED);

  /// Warna aksen sekunder (Mint Green)
  static const Color darkAccentSecondary = Color(0xFF4FD1C5);

  /// Warna divider / border gelap
  static const Color darkDivider = Color(0xFF4A5568);

  /// Warna error
  static const Color darkError = Color(0xFFFC8181);

  /// Warna success
  static const Color darkSuccess = Color(0xFF68D391);

  // ──────────────────────────────────────────────
  //  LIGHT THEME COLORS
  // ──────────────────────────────────────────────

  /// Warna latar utama (Off-white)
  static const Color lightBackground = Color(0xFFF7FAFC);

  /// Warna latar alternatif (Soft Cream)
  static const Color lightSurface = Color(0xFFFDF6E3);

  /// Warna surface yang sedikit lebih gelap untuk card/elevated elements
  static const Color lightSurfaceVariant = Color(0xFFEDF2F7);

  /// Warna teks utama (Charcoal Black)
  static const Color lightTextPrimary = Color(0xFF2D3748);

  /// Warna teks sekunder
  static const Color lightTextSecondary = Color(0xFF718096);

  /// Warna aksen utama (Brick Red)
  static const Color lightAccent = Color(0xFFE53E3E);

  /// Warna aksen sekunder (Navy)
  static const Color lightAccentSecondary = Color(0xFF2C5282);

  /// Warna divider / border terang
  static const Color lightDivider = Color(0xFFE2E8F0);

  /// Warna error
  static const Color lightError = Color(0xFFE53E3E);

  /// Warna success
  static const Color lightSuccess = Color(0xFF38A169);
}
