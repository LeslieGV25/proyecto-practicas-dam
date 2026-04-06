import 'package:flutter/material.dart';
import 'package:frontend/core/colors_style.dart';
import 'package:frontend/screens/Cliente/login_screen.dart';

class ReservarMesa extends StatefulWidget {
  const ReservarMesa({super.key});

  @override
  State<ReservarMesa> createState() => _ReservarMesaState();
}

class _ReservarMesaState extends State<ReservarMesa> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.backgroundButton,
          border: Border.all(color: const Color(0xFF2e2418)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Línea dorada izquierda — acento 10%
            Container(
              width: 3,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 16),
            // Icono
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF251D12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF3a2e1e)),
              ),
              child: const Icon(
                Icons.table_bar_rounded,
                color: AppColors.gold,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            // Textos
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Reservar mesa",
                    style: TextStyle(
                      color: Color(0xFFF0E4C8),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Reserva ya tu mesa",
                    style: TextStyle(
                      color: Color(0xFF7a6a50),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
            // Flecha dorada
            Icon(
              Icons.chevron_right,
              color: AppColors.gold.withOpacity(0.7),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}