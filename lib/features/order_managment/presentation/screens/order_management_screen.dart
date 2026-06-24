import 'package:flutter/material.dart';
import 'package:order_booker/features/dashboard/presentation/screens/dashboard_screen.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  int index = 2;
  String selectedFilter = 'All';
  final List<String> filters = [
    'All',
    'Orders',
    'Complaints',
    'Payments',
    'Visitors',
  ];
  final List<Map<String, dynamic>> orders = [
    {
      'shop': 'Ali Brothers — Johar Town',
      'detail': 'Lays 50g x20, Kurkure x15...',
      'time': '10:32 AM',
      'status': 'Sent',
      'type': 'Orders',
      'icon': Icons.inventory_2_outlined,
      'iconBg': Color(0xFFE8F0FE),
      'iconColor': Color(0xFF1565C0),
    },
    {
      'shop': 'Raja General Store',
      'detail': 'Payment collection note',
      'time': '11:15 AM',
      'status': 'Synced',
      'type': 'Payments',
      'icon': Icons.payment_outlined,
      'iconBg': Color(0xFFE8F0FE),
      'iconColor': Color(0xFF1565C0),
    },
    {
      'shop': 'New City Mart',
      'detail': 'Complaint — wrong delivery',
      'time': '12:40 PM',
      'status': 'Pending',
      'type': 'Complaints',
      'icon': Icons.error_outline,
      'iconBg': Color(0xFFFFEBEE),
      'iconColor': Colors.red,
    },
    {
      'shop': 'Khan Traders — Wapda Town',
      'detail': 'Biscuits x10, Juice x5...',
      'time': '1:15 PM',
      'status': 'Sent',
      'type': 'Orders',
      'icon': Icons.inventory_2_outlined,
      'iconBg': Color(0xFFE8F0FE),
      'iconColor': Color(0xFF1565C0),
    },
    {
      'shop': 'Super Mart — Model Town',
      'detail': 'Visit note — closed today',
      'time': '2:00 PM',
      'status': 'Synced',
      'type': 'Visit',
      'icon': Icons.store_outlined,
      'iconBg': Color(0xFFE8F5E9),
      'iconColor': Color(0xFF2E7D32),
    },
  ];

  // ── FILTERED LIST ──────────────────────────────────────────────────────────
  List<Map<String, dynamic>> get filteredOrders {
    if (selectedFilter == 'All') return orders;
    return orders.where((o) => o['type'] == selectedFilter).toList();
  }

  // ── STATUS BADGE COLOR ─────────────────────────────────────────────────────
  Color _statusColor(String status) {
    switch (status) {
      case 'Sent':
        return Color(0xFF2E7D32);
      case 'Synced':
        return Color(0xFF1565C0);
      case 'Pending':
        return Color(0xFFE65100);
      default:
        return Colors.grey;
    }
  }

  Color _statusBgColor(String status) {
    switch (status) {
      case 'Sent':
        return Color(0xFFE8F5E9);
      case 'Synced':
        return Color(0xFFE8F0FE);
      case 'Pending':
        return Color(0xFFFFF3E0);
      default:
        return Colors.grey.shade100;
    }
  }

  // ── BUILD ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),

              // ── APP BAR ─────────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'History',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.3,
                        ),
                      ),

                      Text(
                        'Today — ${filteredOrders.length} records',

                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(width: 155),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(225),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Color(0x0A000000),
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search, color: Colors.black, size: 29),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 26),
              // ── FILTER CHIPS ─────────────────────────────────────────────
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: filters.map((filter) {
                    final isSelected = selectedFilter == filter;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black87 : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isSelected
                                ? Colors.grey.shade300
                                : Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 25),

              // ── ORDER LIST ───────────────────────────────────────────────
              Expanded(
                child: filteredOrders.isEmpty
                    ? Center(
                        child: Text(
                          'No records found',
                          style: TextStyle(color: Colors.black45, fontSize: 14),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          final order = filteredOrders[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 12),
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // ── ICON ──────────────────────────────────
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: order['iconBg'],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    order['icon'],
                                    color: order['iconColor'],
                                    size: 24,
                                  ),
                                ),

                                SizedBox(width: 12),

                                // ── SHOP NAME + DETAIL ────────────────────
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order['shop'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        order['detail'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 8),

                                // ── TIME + STATUS ─────────────────────────
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      order['time'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _statusBgColor(order['status']),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: _statusColor(
                                            order['status'],
                                          ).withValues(alpha: 0.4),
                                        ),
                                      ),
                                      child: Text(
                                        order['status'],
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: _statusColor(order['status']),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
