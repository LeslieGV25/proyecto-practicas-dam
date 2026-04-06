import 'package:flutter/material.dart';
import 'package:frontend/components/Cliente/codigo_qr.dart';
import 'package:frontend/components/Cliente/domicilio_button.dart';
import 'package:frontend/components/Cliente/reservar_mesa.dart';
import 'package:frontend/core/colors_style.dart';

// ─── Paleta 60-30-10 ───────────────────────────────────────────────
// 60% → negro cálido profundo:  AppColors.background
// 30% → marrón oscuro cálido:   AppColors.backgroundButton
// 10% → dorado:                 AppColors.gold
// ───────────────────────────────────────────────────────────────────

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "SELECCIONA UNA OPCIÓN:",
                      style: TextStyle(
                        color: Color(0xFF7a6a50),
                        fontSize: 10,
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Sin wrapper — cada componente ya lleva su propio diseño
                    const CodigoQr(),
                    const SizedBox(height: 40),
                    const DomicilioButton(),
                    const SizedBox(height: 40),
                    const ReservarMesa(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundButton,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gold, width: 1.5),
                ),
                child: const Icon(
                  Icons.room_service_outlined,
                  color: AppColors.gold,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Tu Restaurante",
                style: TextStyle(
                  fontFamily: 'Playfair Display',
                  color: Color(0xFFF5ECD4),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "BIENVENIDO",
            style: TextStyle(
              color: AppColors.gold.withOpacity(0.8),
              fontSize: 10,
              letterSpacing: 3,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(child: Divider(color: Color(0xFF2e2418))),
              Container(
                width: 60,
                height: 1.5,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.gold,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const Expanded(child: Divider(color: Color(0xFF2e2418))),
            ],
          ),
        ],
      ),
    );
  }
}