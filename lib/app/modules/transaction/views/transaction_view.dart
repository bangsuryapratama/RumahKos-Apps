import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});

  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color slate900 = Color(0xFF1E293B);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: Text(
          'Riwayat Transaksi',
          style: TextStyle(
            color: isDark ? Colors.white : slate900,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _buildTransactionTile(
            context,
            "Pembayaran Sewa - Maret",
            "12 Mar 2024",
            "Rp 1.250.000",
            index == 0 ? "Pending" : "Berhasil",
          );
        },
      ),
    );
  }

  Widget _buildTransactionTile(BuildContext context, String title, String date, String amount, String status) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    bool isPending = status == "Pending";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isPending ? Colors.orange.withOpacity(0.1) : Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPending ? Icons.timer_outlined : Icons.check_circle_outline_rounded,
              color: isPending ? Colors.orange : Colors.green,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isDark ? Colors.white : slate900,
                  ),
                ),
                Text(date, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 14,
              color: isDark ? Colors.white : slate900,
            ),
          ),
        ],
      ),
    );
  }
}
