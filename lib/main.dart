import 'package:flutter/material.dart';

void main() {
  runApp(const FemmeWellApp());
}

/// ===============================================================
/// ROOT APP + PENGENDALI TEMA (LIGHT / DARK PINK)
/// ===============================================================
class FemmeWellApp extends StatefulWidget {
  const FemmeWellApp({super.key});

  // supaya halaman lain bisa mengubah tema
  static _FemmeWellAppState of(BuildContext context) {
    final state = context.findAncestorStateOfType<_FemmeWellAppState>();
    assert(state != null, 'FemmeWellApp state not found');
    return state!;
  }

  @override
  State<FemmeWellApp> createState() => _FemmeWellAppState();
}

class _FemmeWellAppState extends State<FemmeWellApp> {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FemmeWell',
      debugShowCheckedModeBanner: false,

      // ====== TEMA TERANG ======
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF48FB1),
          primary: const Color(0xFFF48FB1),
          secondary: const Color(0xFFFFC1E3),
          background: const Color(0xFFFFF7FB),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF7FB),
        fontFamily: 'Roboto',
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // ====== TEMA GELAP PINK ======
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF8ECF),
          secondary: Color(0xFFFFA9DD),
          background: Color(0xFF140812),
        ),
        scaffoldBackgroundColor: const Color(0xFF140812),
        cardColor: const Color(0xFF201320),
        fontFamily: 'Roboto',
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      themeMode: _themeMode,
      home: const MainScreen(),
    );
  }
}

/// ===============================================================
/// MODEL DATA TREATMENT & KUNJUNGAN
/// ===============================================================
class TreatmentData {
  final String title;
  final String duration;
  final String price;
  final String image;
  final String description;

  TreatmentData({
    required this.title,
    required this.duration,
    required this.price,
    required this.image,
    required this.description,
  });
}

// Anti-Aging Gold Mask DIHAPUS di sini
final List<TreatmentData> treatmentList = [
  TreatmentData(
    title: 'Glow Facial Premium',
    duration: '60 menit',
    price: 'Rp350.000',
    image: 'https://images.pexels.com/photos/3738344/pexels-photo-3738344.jpeg',
    description:
        'Facial untuk mencerahkan dan melembapkan kulit dengan masker premium, massage, dan serum glow booster.',
  ),
  TreatmentData(
    title: 'Acne Clear Treatment',
    duration: '45 menit',
    price: 'Rp280.000',
    image: 'https://images.pexels.com/photos/3738355/pexels-photo-3738355.jpeg',
    description:
        'Perawatan khusus kulit berjerawat untuk mengurangi kemerahan, minyak berlebih, dan bekas jerawat.',
  ),
  TreatmentData(
    title: 'Brightening Serum Boost',
    duration: '30 menit',
    price: 'Rp220.000',
    image: 'https://images.pexels.com/photos/3738342/pexels-photo-3738342.jpeg',
    description:
        'Treatment singkat namun efektif dengan serum brightening berkonsentrat tinggi untuk kulit tampak lebih cerah.',
  ),
];

class VisitData {
  final TreatmentData treatment;
  final String dateTime;
  final String location;
  final String status; // Selesai / Dibatalkan / Dijadwalkan

  VisitData({
    required this.treatment,
    required this.dateTime,
    required this.location,
    required this.status,
  });
}

/// list kunjungan sekarang KOSONG, nanti diisi saat booking
List<VisitData> visitList = [];

/// ===============================================================
/// MAIN SCREEN : NAVIGASI & FAB BOOKING
/// ===============================================================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final _pages = const [
    HomePage(),
    TreatmentPage(),
    VisitsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _pages),
      ),

      // ===== FAB BOOKING DI TENGAH (DIRAPIHKAN + JARAK + FLOATING) =====
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(
          height: 80,
          width: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // base putih / gelap biar kelihatan melayang
              Container(
                height: 68,
                width: 68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? const Color(0xFF201320)
                      : Colors.white, // base lingkaran
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
              ),
              // tombol gradient
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFF48FB1), Color(0xFFFFC1E3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x33F48FB1),
                      blurRadius: 18,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () async {
                    // buka halaman booking
                    final result = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(builder: (_) => const BookingPage()),
                    );

                    // kalau booking sukses -> pindah ke tab KUNJUNGAN (index 2) & refresh
                    if (result == true) {
                      setState(() {
                        _currentIndex = 2;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // ===== BOTTOM NAV BAR CANTIK =====
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF201320).withOpacity(0.96)
              : Colors.white.withOpacity(0.96),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.spa_rounded),
              label: 'Treatment',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_rounded),
              label: 'Kunjungan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}

/// ===============================================================
/// HALAMAN BERANDA
/// ===============================================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== HEADER PINK =====
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF48FB1), Color(0xFFFFC1E3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bar atas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'FemmeWell',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.3),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  'Hi, Ratu ✨',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Siap tampil glowing hari ini?',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Janji Berikutnya',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                Text(
                  'Glow Facial Premium',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Hari ini • 15:30',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ===== MENU CEPAT =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                QuickMenu(
                  icon: Icons.calendar_month_rounded,
                  text: 'Booking',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BookingPage()),
                    );
                  },
                ),
                const SizedBox(width: 10),
                QuickMenu(
                  icon: Icons.local_fire_department_rounded,
                  text: 'Promo',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Belum ada promo, nanti menyusul ya ✨'),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
                QuickMenu(
                  icon: Icons.favorite_rounded,
                  text: 'Favorit',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fitur favorit masih coming soon 💗'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ===== TREATMENT POPULER =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Treatment Populer',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Lihat Semua',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: treatmentList.length,
              separatorBuilder: (_, __) => const SizedBox(width: 15),
              itemBuilder: (context, index) {
                final t = treatmentList[index];
                return TreatmentCard(
                  treatment: t,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TreatmentDetailPage(treatment: t),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuickMenu extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const QuickMenu({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 6),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TreatmentCard extends StatelessWidget {
  final TreatmentData treatment;
  final VoidCallback onTap;

  const TreatmentCard({
    super.key,
    required this.treatment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: Image.network(
                treatment.image,
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    treatment.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    treatment.duration,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    treatment.price,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ===============================================================
/// HALAMAN TREATMENT – LIST
/// ===============================================================
class TreatmentPage extends StatelessWidget {
  const TreatmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: treatmentList.length,
      itemBuilder: (context, index) {
        final t = treatmentList[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFFFC1E3),
              backgroundImage: NetworkImage(t.image),
            ),
            title: Text(t.title),
            subtitle: Text('${t.duration} • ${t.price}'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TreatmentDetailPage(treatment: t),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

/// ===============================================================
/// HALAMAN DETAIL TREATMENT
/// ===============================================================
class TreatmentDetailPage extends StatelessWidget {
  final TreatmentData treatment;

  const TreatmentDetailPage({super.key, required this.treatment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          // HEADER GAMBAR + GRADIENT
          Stack(
            children: [
              SizedBox(
                height: 260,
                width: double.infinity,
                child: Image.network(treatment.image, fit: BoxFit.cover),
              ),
              Container(
                height: 260,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black54, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.black45,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                right: 20,
                child: Text(
                  treatment.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          // KONTEN
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  children: [
                    Chip(
                      avatar: const Icon(Icons.timer_rounded, size: 16),
                      label: Text(treatment.duration),
                    ),
                    const SizedBox(width: 10),
                    Chip(
                      avatar: const Icon(Icons.price_change_rounded, size: 16),
                      label: Text(treatment.price),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Deskripsi Treatment',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(treatment.description, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BookingPage()),
              );
            },
            child: const Text(
              'Booking Sekarang',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ===============================================================
/// HALAMAN BOOKING – MEWAH + TOMBOL KEMBALI
/// ===============================================================
class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String? selectedTreatment;
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;
  final nameController = TextEditingController();

  Future<void> pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (d != null) setState(() => selectedDate = d);
  }

  Future<void> pickTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (t != null) setState(() => selectedTime = t);
  }

  @override
  Widget build(BuildContext context) {
    final treatments = treatmentList.map((t) => t.title).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER MEWAH + TOMBOL KEMBALI
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 45, 20, 35),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF48FB1), Color(0xFFFFC1E3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Buat Boking',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Atur jadwal treatment cantikmu ✨',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // FORM
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  bookingInputCard(
                    context: context,
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  bookingInputCard(
                    context: context,
                    child: DropdownButtonFormField<String>(
                      value: selectedTreatment,
                      decoration: const InputDecoration(
                        labelText: 'Pilih Treatment',
                        border: InputBorder.none,
                      ),
                      items: treatments
                          .map(
                            (t) => DropdownMenuItem(value: t, child: Text(t)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => selectedTreatment = v),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: bookingInputCard(
                          context: context,
                          onTap: pickDate,
                          child: Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: bookingInputCard(
                          context: context,
                          onTap: pickTime,
                          child: Text(
                            selectedTime == null
                                ? 'Pilih Jam'
                                : selectedTime!.format(context),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // BUTTON KONFIRMASI
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF48FB1), Color(0xFFFFA6D1)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        if (selectedTreatment == null || selectedTime == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Lengkapi semua data booking terlebih dahulu',
                              ),
                            ),
                          );
                          return;
                        }

                        // cari treatment yang dipilih
                        final treatment = treatmentList.firstWhere(
                          (t) => t.title == selectedTreatment,
                        );

                        final dateText =
                            '${selectedDate.day.toString().padLeft(2, '0')}/'
                            '${selectedDate.month.toString().padLeft(2, '0')}/'
                            '${selectedDate.year} • '
                            '${selectedTime!.format(context)}';

                        // tambahkan ke visitList
                        visitList.add(
                          VisitData(
                            treatment: treatment,
                            dateTime: dateText,
                            location: 'Klinik FemmeWell - Bandung',
                            status: 'Dijadwalkan',
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Booking berhasil disimpan!'),
                          ),
                        );

                        // kirim "true" ke MainScreen
                        Navigator.pop(context, true);
                      },
                      child: const Text(
                        'Konfirmasi Booking',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget bookingInputCard({
  required BuildContext context,
  required Widget child,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    ),
  );
}

/// ===============================================================
/// HALAMAN KUNJUNGAN – EMPTY STATE CANTIK + LIST
/// ===============================================================
class VisitsPage extends StatelessWidget {
  const VisitsPage({super.key});

  Color _statusColor(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.green;
      case 'Dibatalkan':
        return Colors.redAccent;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (visitList.isEmpty) {
      // EMPTY STATE LEBIH MANIS
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // icon / ilustrasi
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary.withOpacity(0.08),
                ),
                child: Icon(
                  Icons.calendar_month_rounded,
                  color: theme.colorScheme.primary,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Belum ada kunjungan',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Yuk booking dulu janji treatment supaya kamu nggak ketinggalan slot ✨',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 46,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BookingPage()),
                    );
                  },
                  icon: const Icon(Icons.add_rounded),
                  label: const Text(
                    'Buat Kunjungan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
      itemCount: visitList.length,
      itemBuilder: (context, index) {
        final v = visitList[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: NetworkImage(v.treatment.image),
            ),
            title: Text(
              v.treatment.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2),
                Text(v.dateTime, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded, size: 14),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        v.location,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(v.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    v.status,
                    style: TextStyle(
                      color: _statusColor(v.status),
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Icon(Icons.arrow_forward_ios_rounded, size: 14),
              ],
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Detail kunjungan: ${v.treatment.title} (${v.status})',
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

/// ===============================================================
/// HALAMAN PROFIL + SWITCH MODE GELAP PINK
/// ===============================================================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = FemmeWellApp.of(context);
    final isDark = appState.themeMode == ThemeMode.dark;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Center(
          child: Column(
            children: const [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg',
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Ratu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text('Member Platinum', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const ListTile(
          leading: Icon(Icons.phone_rounded),
          title: Text('WhatsApp'),
          subtitle: Text('+62 812-3456-7890'),
        ),
        const ListTile(
          leading: Icon(Icons.email_rounded),
          title: Text('Email'),
          subtitle: Text('ratu@example.com'),
        ),
        const Divider(height: 32),
        SwitchListTile(
          secondary: const Icon(Icons.dark_mode_rounded),
          title: const Text('Mode gelap pink'),
          value: isDark,
          onChanged: (val) {
            appState.setThemeMode(val ? ThemeMode.dark : ThemeMode.light);
          },
        ),
        const ListTile(
          leading: Icon(Icons.settings_rounded),
          title: Text('Pengaturan Akun'),
        ),
        const ListTile(
          leading: Icon(Icons.logout_rounded),
          title: Text('Keluar'),
        ),
      ],
    );
  }
}
