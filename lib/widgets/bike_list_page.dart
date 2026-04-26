import 'package:flutter/material.dart';

class BikeListPage extends StatefulWidget {
  const BikeListPage({super.key});

  @override
  State<BikeListPage> createState() => _BikeListPageState();
}

class _BikeListPageState extends State<BikeListPage> {
  int selectedIndex = 0;
  double sheetSize = 0.55;

  final List<Map<String, String>> bikes = [
    {
      "title": "Xanh SM Bike",
      "price": "70,000đ",
      "subtitle": "Affordable • 4 offers"
    },
    {"title": "Xanh SM Premium", "price": "90,000đ", "subtitle": "Nhanh • Êm"},
    {"title": "Xanh SM Luxury", "price": "120,000đ", "subtitle": "Cao cấp"},
  ];

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      bikes.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          setState(() {
            sheetSize = notification.extent;
          });
          return true;
        },
        child: Stack(
          children: [
            /// ================= MAP (CO GIÃN) =================
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: screenHeight * (1 - sheetSize),
              width: double.infinity,
              child: Stack(
                children: [
                  Container(color: Colors.grey[300]),

                  const Center(
                    child: Text(
                      "Map here",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  /// BACK BUTTON
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 6)
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// SEARCH BOX
                  Positioned(
                    top: 80,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 6)
                        ],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Text("Bạn muốn đi đâu?"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// ================= SHEET =================
            DraggableScrollableSheet(
              initialChildSize: 0.55,
              minChildSize: 0.4,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10)
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                    child: RefreshIndicator(
                      onRefresh: _refreshData,
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                        children: [
                          /// DRAG HANDLE
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          /// TITLE
                          const Text(
                            "Chọn loại xe",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          /// LIST XE
                          ...List.generate(bikes.length, (index) {
                            final item = bikes[index];

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: BikeItem(
                                title: item['title']!,
                                price: item['price']!,
                                subtitle: item['subtitle']!,
                                selected: selectedIndex == index,
                              ),
                            );
                          }),

                          const SizedBox(height: 16),

                          /// BUTTON
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                final selected = bikes[selectedIndex];
                                debugPrint("Chọn: ${selected['title']}");
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00B14F),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Book",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= ITEM =================
class BikeItem extends StatelessWidget {
  final String title;
  final String price;
  final String subtitle;
  final bool selected;

  const BikeItem({
    super.key,
    required this.title,
    required this.price,
    required this.subtitle,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: selected ? const Color(0xFF00B14F) : Colors.grey.shade300,
          width: selected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: selected ? const Color(0xFFE8F5E9) : Colors.white,
      ),
      child: Row(
        children: [
          const Icon(Icons.two_wheeler, size: 32, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
