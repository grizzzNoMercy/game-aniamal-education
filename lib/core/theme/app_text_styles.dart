import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Animal Explorer Typography
/// Headline: Plus Jakarta Sans | Body & Label: Nunito Sans
class AppTextStyles {
  AppTextStyles._();

  // Display XL — 48px, ExtraBold
  static TextStyle displayXl = GoogleFonts.plusJakartaSans(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    height: 56 / 48,
    letterSpacing: -0.96, // -0.02em
  );

  // Display XL Mobile — 32px, ExtraBold
  static TextStyle displayXlMobile = GoogleFonts.plusJakartaSans(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 40 / 32,
  );

  // Headline Large — 32px, Bold
  static TextStyle headlineLg = GoogleFonts.plusJakartaSans(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
  );

  // Headline Medium — 24px, Bold
  static TextStyle headlineMd = GoogleFonts.plusJakartaSans(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 32 / 24,
  );

  // Body Large — 20px, SemiBold
  static TextStyle bodyLg = GoogleFonts.nunitoSans(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
  );

  // Body Medium — 18px, Regular
  static TextStyle bodyMd = GoogleFonts.nunitoSans(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 26 / 18,
  );

  // Label Large — 16px, Bold
  static TextStyle labelLg = GoogleFonts.nunitoSans(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 20 / 16,
  );

  // Label Medium — 14px, SemiBold
  static TextStyle labelMd = GoogleFonts.nunitoSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 18 / 14,
  );
}
