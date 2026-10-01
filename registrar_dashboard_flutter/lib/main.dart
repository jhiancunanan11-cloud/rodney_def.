import 'package:flutter/material.dart';

void main() => runApp(const RegistrarApp());

const Color brandRed = Color(0xFFB5091B);
const Color deepRed = Color(0xFF980817);
const Color pageBg = Color(0xFFF4F6FB);
const Color ink = Color(0xFF17243A);
const Color muted = Color(0xFF718096);
const Color line = Color(0xFFE8ECF2);

class RegistrarApp extends StatelessWidget {
  const RegistrarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Registrar's Office",
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pageBg,
        colorScheme: ColorScheme.fromSeed(seedColor: brandRed),
        fontFamily: 'Roboto',
      ),
      home: const RegistrarDashboard(),
    );
  }
}

class RegistrarDashboard extends StatefulWidget {
  const RegistrarDashboard({super.key});

  @override
  State<RegistrarDashboard> createState() => _RegistrarDashboardState();
}

class _RegistrarDashboardState extends State<RegistrarDashboard> {
  int selectedNav = 0;
  final List<String> navItems = const [
    'Dashboard',
    'View Registrar Services',
    'Appointment Schedules',
    'Queue Status',
    'Transaction History',
    'Manage Profile',
  ];

  final List<IconData> navIcons = const [
    Icons.home_outlined,
    Icons.fact_check_outlined,
    Icons.calendar_month_outlined,
    Icons.format_list_bulleted,
    Icons.description_outlined,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool compact = constraints.maxWidth < 950;
      final bool mobile = constraints.maxWidth < 650;
      return Scaffold(
        drawer: mobile ? Drawer(child: _sidebar(showLogout: true)) : null,
        body: Column(
          children: [
            _topBar(mobile),
            Expanded(
              child: Row(
                children: [
                  if (!mobile) SizedBox(width: compact ? 220 : 260, child: _sidebar()),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(mobile ? 12 : 24),
                      child: _dashboardContent(compact: compact, mobile: mobile),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _topBar(bool mobile) {
    return Container(
      height: 84,
      padding: EdgeInsets.symmetric(horizontal: mobile ? 12 : 28),
      color: brandRed,
      child: Row(
        children: [
          if (mobile)
            Builder(builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, color: Colors.white),
            )),
          Container(
            width: 58, height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white70, width: 1.5),
            ),
            child: const Icon(Icons.account_balance_outlined, color: Colors.white, size: 33),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Registrar's Office", style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w600)),
                SizedBox(height: 2),
                Text('Student Services System', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(onPressed: () => _showMessage('You have 2 notifications.'), icon: const Icon(Icons.notifications_none, color: Colors.white, size: 27)),
              Positioned(right: 3, top: 2, child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: Color(0xFFE83D4C), shape: BoxShape.circle),
                child: const Text('2', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
              )),
            ],
          ),
          const SizedBox(width: 12),
          const CircleAvatar(radius: 20, backgroundColor: Color(0xFFF4F0F3), child: Icon(Icons.person, color: Color(0xFFB9BAC5), size: 27)),
          if (!mobile) ...[
            const SizedBox(width: 12),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Juan Dela Cruz', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                SizedBox(height: 3),
                Text('BSIT - 3rd Year', style: TextStyle(color: Colors.white70, fontSize: 11)),
              ],
            ),
            const SizedBox(width: 12),
            IconButton(onPressed: () => _showMessage('Account menu'), icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white)),
          ],
        ],
      ),
    );
  }

  Widget _sidebar({bool showLogout = false}) {
    return Container(
      color: brandRed,
      child: Column(
        children: [
          const SizedBox(height: 22),
          ...List.generate(navItems.length, (i) {
            final active = selectedNav == i;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  setState(() => selectedNav = i);
                  if (MediaQuery.of(context).size.width < 650) Navigator.of(context).pop();
                  if (i != 0) _showMessage('${navItems[i]} selected');
                },
                child: Container(
                  height: 54,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: active ? Colors.white.withOpacity(.10) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: active ? Border.all(color: Colors.white.withOpacity(.06)) : null,
                  ),
                  child: Row(
                    children: [
                      Icon(navIcons[i], color: Colors.white, size: 24),
                      const SizedBox(width: 20),
                      Expanded(child: Text(navItems[i], style: const TextStyle(color: Colors.white, fontSize: 13.5))),
                    ],
                  ),
                ),
              ),
            );
          }),
          const Spacer(),
          SizedBox(
            height: 210,
            width: double.infinity,
            child: CustomPaint(painter: BuildingPainter()),
          ),
          InkWell(
            onTap: () => _showMessage('You have been logged out (demo).'),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(28, 24, 20, 28),
              child: Row(children: [
                Icon(Icons.logout, color: Colors.white, size: 23),
                SizedBox(width: 20),
                Text('Logout', style: TextStyle(color: Colors.white, fontSize: 13.5)),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dashboardContent({required bool compact, required bool mobile}) {
    final mainColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _welcomeHeader(mobile),
        const SizedBox(height: 22),
        GridView.count(
          crossAxisCount: mobile ? 2 : 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: mobile ? 1.28 : (compact ? 1.08 : 1.12),
          children: [
            _statCard('Upcoming Appointments', '1', 'View Schedule', Icons.calendar_month, const Color(0xFFB5091B), const Color(0xFFFBE9ED), () => _showMessage('Opening appointment schedule')),
            _statCard('Current Queue Status', 'Q015', 'View Queue', Icons.groups, const Color(0xFF0878D1), const Color(0xFFE6F3FF), () => _showMessage('Current queue: Q015')),
            _statCard('Transactions', '3', 'View History', Icons.description, const Color(0xFF17965B), const Color(0xFFE7F7EF), () => _showMessage('Opening transaction history')),
            _statCard('Available Services', '5', 'View Services', Icons.account_balance, const Color(0xFF7B39C6), const Color(0xFFF1E8FF), () => _showMessage('Opening registrar services')),
          ],
        ),
        const SizedBox(height: 22),
        _upcomingAppointment(),
        const SizedBox(height: 18),
        _recentTransactions(),
      ],
    );

    final sideColumn = Column(
      children: [
        _serviceBanner(),
        const SizedBox(height: 18),
        _quickActions(),
        const SizedBox(height: 18),
        _notifications(),
      ],
    );

    if (compact) {
      return Column(
        children: [
          mainColumn,
          const SizedBox(height: 18),
          sideColumn,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 7, child: mainColumn),
        const SizedBox(width: 20),
        SizedBox(width: 390, child: sideColumn),
      ],
    );
  }

  Widget _welcomeHeader(bool mobile) {
    return Row(
      children: [
        Container(
          width: mobile ? 52 : 66,
          height: mobile ? 52 : 66,
          decoration: const BoxDecoration(color: Color(0xFFE8EDFF), shape: BoxShape.circle),
          child: Icon(Icons.person, color: const Color(0xFF263F83), size: mobile ? 37 : 48),
        ),
        const SizedBox(width: 16),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good morning, Juan!', style: TextStyle(color: ink, fontSize: mobile ? 19 : 23, fontWeight: FontWeight.w700)),
            const SizedBox(height: 5),
            const Text("Here's an overview of your account and upcoming appointments.", style: TextStyle(color: muted, fontSize: 12.5)),
          ],
        )),
        if (!mobile) ...[
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: line)),
            child: const Row(children: [
              Icon(Icons.calendar_month_outlined, color: Color(0xFF43546B), size: 23),
              SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('October 1, 2026', style: TextStyle(color: ink, fontSize: 14, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text('Thursday, 10:24 AM', style: TextStyle(color: muted, fontSize: 11)),
              ]),
            ]),
          ),
        ],
      ],
    );
  }

  Widget _statCard(String title, String value, String action, IconData icon, Color accent, Color tint, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 14, 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: line)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
          child: Icon(icon, color: accent, size: 25),
        ),
        const SizedBox(height: 13),
        Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: ink, fontSize: 12.5)),
        const Spacer(),
        Text(value, style: const TextStyle(color: ink, fontSize: 25, fontWeight: FontWeight.w700)),
        const SizedBox(height: 9),
        InkWell(
          onTap: onTap,
          child: Row(children: [
            Flexible(child: Text(action, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: accent, fontSize: 12.5, fontWeight: FontWeight.w500))),
            const SizedBox(width: 5),
            Icon(Icons.arrow_forward, color: accent, size: 15),
          ]),
        ),
      ]),
    );
  }

  Widget _panel({required Widget child, EdgeInsets padding = const EdgeInsets.all(18)}) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(9), border: Border.all(color: line)),
      child: child,
    );
  }

  Widget _panelTitle(IconData icon, String title, {String? trailing, VoidCallback? onTrailing}) {
    return Row(children: [
      Container(width: 30, height: 30, decoration: BoxDecoration(color: const Color(0xFFFBE9ED), borderRadius: BorderRadius.circular(7)), child: Icon(icon, color: brandRed, size: 19)),
      const SizedBox(width: 12),
      Expanded(child: Text(title, style: const TextStyle(color: ink, fontSize: 16, fontWeight: FontWeight.w700))),
      if (trailing != null) TextButton(onPressed: onTrailing, child: Text(trailing, style: const TextStyle(color: brandRed, fontSize: 12))),
    ]);
  }

  Widget _upcomingAppointment() {
    return _panel(child: Column(children: [
      _panelTitle(Icons.calendar_month, 'Upcoming Appointment', trailing: 'View All', onTrailing: () => _showMessage('Showing all appointments')),
      const SizedBox(height: 14),
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: const Color(0xFFFCF4F6), borderRadius: BorderRadius.circular(7)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.calendar_month, color: brandRed, size: 24),
          const SizedBox(width: 18),
          const SizedBox(width: 60, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('OCT', style: TextStyle(color: muted, fontSize: 12)),
            SizedBox(height: 3),
            Text('03', style: TextStyle(color: brandRed, fontSize: 26, fontWeight: FontWeight.w700)),
            Text('2026', style: TextStyle(color: muted, fontSize: 12)),
          ])),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(spacing: 10, crossAxisAlignment: WrapCrossAlignment.center, children: [
              const Text('Enrollment', style: TextStyle(color: ink, fontSize: 14, fontWeight: FontWeight.w600)),
              Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFDDF5E7), borderRadius: BorderRadius.circular(4)), child: const Text('Confirmed', style: TextStyle(color: Color(0xFF21834B), fontSize: 10))),
            ]),
            const SizedBox(height: 12),
            const _IconText(Icons.access_time, '09:00 AM – 10:00 AM'),
            const SizedBox(height: 8),
            const _IconText(Icons.location_on_outlined, "Registrar's Office"),
            const SizedBox(height: 8),
            const Text('Reference No. 2026-1003-001', style: TextStyle(color: muted, fontSize: 11.5)),
          ])),
          const SizedBox(width: 8),
          Align(alignment: Alignment.center, child: FilledButton(
            style: FilledButton.styleFrom(backgroundColor: brandRed, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13)),
            onPressed: () => _showMessage('Appointment: Enrollment, Oct 3, 2026 at 9:00 AM'),
            child: const Text('View Details', style: TextStyle(fontSize: 12)),
          )),
        ]),
      ),
    ]));
  }

  Widget _recentTransactions() {
    final rows = [
      ['Sep 28, 2026', 'Enrollment', 'Completed', '2026-0928-003', 'green'],
      ['Sep 20, 2026', 'Certificate Request', 'Completed', '2026-0920-001', 'green'],
      ['Sep 15, 2026', 'Transcript of Records', 'In Progress', '2026-0915-002', 'orange'],
      ['Sep 10, 2026', 'Subject Adjustment', 'Completed', '2026-0910-004', 'green'],
    ];
    return _panel(child: Column(children: [
      _panelTitle(Icons.description_outlined, 'Recent Transactions', trailing: 'View All', onTrailing: () => _showMessage('Showing transaction history')),
      const SizedBox(height: 15),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: const BoxDecoration(color: Color(0xFFF5F7FB), borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
        child: const Row(children: [
          Expanded(flex: 3, child: Text('Date', style: TextStyle(color: muted, fontSize: 11, fontWeight: FontWeight.w600))),
          Expanded(flex: 4, child: Text('Service', style: TextStyle(color: muted, fontSize: 11, fontWeight: FontWeight.w600))),
          Expanded(flex: 3, child: Text('Status', style: TextStyle(color: muted, fontSize: 11, fontWeight: FontWeight.w600))),
          Expanded(flex: 4, child: Text('Reference No.', style: TextStyle(color: muted, fontSize: 11, fontWeight: FontWeight.w600))),
          SizedBox(width: 10),
        ]),
      ),
      ...rows.map((r) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: line))),
        child: Row(children: [
          Expanded(flex: 3, child: Text(r[0], style: const TextStyle(color: Color(0xFF445269), fontSize: 11.5))),
          Expanded(flex: 4, child: Text(r[1], style: const TextStyle(color: Color(0xFF445269), fontSize: 11.5))),
          Expanded(flex: 3, child: Align(alignment: Alignment.centerLeft, child: _status(r[2], r[4]))),
          Expanded(flex: 4, child: Text(r[3], style: const TextStyle(color: Color(0xFF445269), fontSize: 11.5))),
          const Icon(Icons.chevron_right, color: Color(0xFF8A98AA), size: 18),
        ]),
      )),
    ]));
  }

  Widget _status(String label, String type) {
    final color = type == 'green' ? const Color(0xFF22854B) : const Color(0xFFB97912);
    final bg = type == 'green' ? const Color(0xFFDDF5E7) : const Color(0xFFFFF0D4);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
      child: Text(label, style: TextStyle(color: color, fontSize: 10.5)),
    );
  }

  Widget _serviceBanner() {
    return Container(
      height: 234,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: deepRed, borderRadius: BorderRadius.circular(10)),
      child: Stack(children: [
        Positioned(right: -35, top: -45, child: Container(width: 140, height: 140, decoration: BoxDecoration(color: Colors.white.withOpacity(.035), shape: BoxShape.circle))),
        Positioned(right: -45, bottom: -60, child: Container(width: 180, height: 180, decoration: BoxDecoration(color: Colors.white.withOpacity(.045), shape: BoxShape.circle))),
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 25, 24, 22),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(Icons.account_balance_outlined, color: Colors.white, size: 40),
            const SizedBox(height: 14),
            const Text('Need a service?', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)),
            const SizedBox(height: 7),
            const Text('Browse all available registrar services\nand start your request.', style: TextStyle(color: Colors.white, fontSize: 12.5, height: 1.5)),
            const Spacer(),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: deepRed, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 13)),
              onPressed: () => _showMessage('Opening registrar services'),
              child: const Row(mainAxisSize: MainAxisSize.min, children: [Text('View Registrar Services', style: TextStyle(fontSize: 12)), SizedBox(width: 9), Icon(Icons.arrow_forward, size: 15)]),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _quickActions() {
    final actions = [
      [Icons.calendar_month, 'Book Appointment'],
      [Icons.groups, 'Check Queue Status'],
      [Icons.description, 'View Transaction History'],
      [Icons.person, 'Update Profile'],
    ];
    return _panel(child: Column(children: [
      Row(children: const [Icon(Icons.bolt, color: brandRed, size: 23), SizedBox(width: 12), Text('Quick Actions', style: TextStyle(color: ink, fontSize: 15, fontWeight: FontWeight.w700))]),
      const SizedBox(height: 15),
      ...actions.map((a) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Material(
          color: const Color(0xFFFCF4F6),
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () => _showMessage('${a[1]} selected'),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(children: [
                Container(width: 38, height: 38, decoration: const BoxDecoration(color: Color(0xFFFBE6EB), shape: BoxShape.circle), child: Icon(a[0] as IconData, color: brandRed, size: 21)),
                const SizedBox(width: 14),
                Expanded(child: Text(a[1] as String, style: const TextStyle(color: Color(0xFF3B485D), fontSize: 12.5))),
                const Icon(Icons.chevron_right, color: Color(0xFF8B98A9), size: 20),
              ]),
            ),
          ),
        ),
      )),
    ]));
  }

  Widget _notifications() {
    final items = [
      [Icons.check_circle, 'Your appointment has been confirmed', 'Enrollment • Oct 3, 2026 • 09:00 AM', '2h ago', const Color(0xFF15965A), const Color(0xFFE4F7EC)],
      [Icons.info, 'Transaction completed', 'Certificate Request • Sep 28, 2026', '1d ago', const Color(0xFF0878D1), const Color(0xFFE5F2FF)],
      [Icons.error, 'Queue update', 'You are now on Queue 015.', '2d ago', brandRed, const Color(0xFFFBE9ED)],
    ];
    return _panel(child: Column(children: [
      _panelTitle(Icons.notifications, 'Notifications', trailing: 'View All', onTrailing: () => _showMessage('Showing all notifications')),
      const SizedBox(height: 12),
      ...items.map((n) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(width: 39, height: 39, decoration: BoxDecoration(color: n[5] as Color, shape: BoxShape.circle), child: Icon(n[0] as IconData, color: n[4] as Color, size: 20)),
          const SizedBox(width: 13),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(n[1] as String, style: const TextStyle(color: ink, fontSize: 12.5, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(n[2] as String, style: const TextStyle(color: muted, fontSize: 11.5, height: 1.4)),
          ])),
          const SizedBox(width: 8),
          Text(n[3] as String, style: const TextStyle(color: muted, fontSize: 10)),
        ]),
      )),
    ]));
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color(0xFF27364C),
    ));
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  const _IconText(this.icon, this.text);

  @override
  Widget build(BuildContext context) => Row(children: [
    Icon(icon, color: brandRed, size: 14),
    const SizedBox(width: 8),
    Flexible(child: Text(text, style: const TextStyle(color: Color(0xFF536176), fontSize: 11.5))),
  ]);
}

class BuildingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.white.withOpacity(.07)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final path = Path()
      ..moveTo(-10, size.height * .42)
      ..lineTo(size.width * .32, size.height * .20)
      ..lineTo(size.width * .98, size.height * .52)
      ..lineTo(size.width * .98, size.height * .98)
      ..lineTo(-10, size.height * .98)
      ..close();
    canvas.drawPath(path, p);
    canvas.drawLine(Offset(0, size.height * .55), Offset(size.width, size.height * .55), p);
    canvas.drawLine(Offset(0, size.height * .70), Offset(size.width, size.height * .70), p);
    canvas.drawLine(Offset(size.width * .32, size.height * .20), Offset(size.width * .32, size.height * .98), p);
    canvas.drawLine(Offset(size.width * .55, size.height * .31), Offset(size.width * .55, size.height * .98), p);
    canvas.drawLine(Offset(size.width * .78, size.height * .42), Offset(size.width * .78, size.height * .98), p);
    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 5; c++) {
        final x = size.width * (.05 + c * .18);
        final y = size.height * (.60 + r * .12);
        canvas.drawRect(Rect.fromLTWH(x, y, 8, 12), p);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
