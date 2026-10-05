import 'package:flutter/material.dart';

void main() => runApp(const BankingDemoApp());

class BankingDemoApp extends StatelessWidget {
  const BankingDemoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Banking Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF16734B)),
        scaffoldBackgroundColor: const Color(0xFFF5F7F6),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class DemoBanner extends StatelessWidget {
  const DemoBanner({super.key});
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    color: const Color(0xFFFFE8A3),
    child: const Text('DEMO / STUDENT PROJECT — No real banking or transactions',
      textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final pin = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: Column(children: [
      const DemoBanner(),
      Expanded(child: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(28), child: Column(children: [
        ClipRRect(borderRadius: BorderRadius.circular(22), child: Image.asset('assets/images/project_logo.jpeg', width: 125, height: 125, fit: BoxFit.cover)),
        const SizedBox(height: 16),
        const Text('Banking UI Demo', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
        const SizedBox(height: 5),
        const Text('Educational project • Local demo data only', style: TextStyle(color: Colors.black54)),
        const SizedBox(height: 34),
        TextField(controller: pin, keyboardType: TextInputType.number, obscureText: true, maxLength: 4,
          decoration: const InputDecoration(labelText: 'Demo MPIN', hintText: 'Enter any 4 digits', border: OutlineInputBorder())),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, height: 52, child: FilledButton(onPressed: () {
          if (pin.text.length == 4) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeShell()));
          else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter any 4 digits for this demo.')));
        }, child: const Text('Login to Demo'))),
        const SizedBox(height: 12),
        const Text('Do not enter a real bank PIN, password, OTP or account credential.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.black54)),
      ]))))
    ])),
  );
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override State<HomeShell> createState() => _HomeShellState();
}
class _HomeShellState extends State<HomeShell> {
  int index = 0;
  final pages = const [DashboardPage(), TransactionsPage(), ServicesPage(), ProfilePage()];
  @override Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: Column(children: [const DemoBanner(), Expanded(child: pages[index])])),
    bottomNavigationBar: NavigationBar(selectedIndex: index, onDestinationSelected: (v) => setState(() => index = v), destinations: const [
      NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Activity'),
      NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'Services'),
      NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
    ]),
  );
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Good day', style: TextStyle(color: Colors.black54)),
    const Text('Demo Customer', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
    const SizedBox(height: 18),
    Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
      Text('DEMO SAVINGS ACCOUNT', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)), SizedBox(height: 18),
      Text('Available balance', style: TextStyle(color: Colors.black54)), Text('₹ 24,860.50', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
      SizedBox(height: 12), Text('A/C •••• 4821    •    Demo data', style: TextStyle(color: Colors.black54)),
      SizedBox(height: 16), Divider(), SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Lien amount', style: TextStyle(fontWeight: FontWeight.w700)), Text('₹ 20,000.00', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800))]),
      SizedBox(height: 4), Text('Project demonstration value only', style: TextStyle(fontSize: 12, color: Colors.black54)),
    ]))),
    const SizedBox(height: 18),
    const Text('Quick actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
    const SizedBox(height: 10),
    Wrap(spacing: 10, runSpacing: 10, children: [
      _action(context, Icons.swap_horiz, 'Transfer', const TransferPage()),
      _action(context, Icons.account_balance_wallet_outlined, 'Pay bills', const InfoPage(title:'Bill Payments')),
      _action(context, Icons.credit_card, 'Cards', const CardControlsPage()),
      _action(context, Icons.savings_outlined, 'Deposits', const DepositsPage()),
    ]),
    const SizedBox(height: 22),
    const Text('Recent activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
    const TransactionTile(title: 'Demo UPI Payment', subtitle: 'Today • Simulation', amount: '- ₹420.00'),
    const TransactionTile(title: 'Demo Credit', subtitle: 'Yesterday • Simulation', amount: '+ ₹2,500.00'),
  ]);
  static Widget _action(BuildContext context, IconData icon, String label, Widget page) => SizedBox(width: 155, height: 95, child: Card(elevation:0, child: InkWell(borderRadius: BorderRadius.circular(12), onTap:()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>page)), child: Padding(padding:const EdgeInsets.all(14), child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[Icon(icon), const Spacer(), Text(label, style:const TextStyle(fontWeight:FontWeight.w700))])))));
}

class TransactionTile extends StatelessWidget {
  final String title, subtitle, amount;
  const TransactionTile({super.key, required this.title, required this.subtitle, required this.amount});
  @override Widget build(BuildContext context) => ListTile(contentPadding: EdgeInsets.zero, leading: const CircleAvatar(child: Icon(Icons.currency_rupee)), title: Text(title), subtitle: Text(subtitle), trailing: Text(amount, style: const TextStyle(fontWeight: FontWeight.w700)));
}

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: const [
    Text('Activity', style: TextStyle(fontSize: 26,fontWeight: FontWeight.w800)), SizedBox(height: 8),
    Text('All entries below are fictional demo data.', style: TextStyle(color: Colors.black54)), SizedBox(height: 12),
    TransactionTile(title:'Demo UPI Payment',subtitle:'04 Oct • Simulation',amount:'- ₹420.00'),
    TransactionTile(title:'Demo Credit',subtitle:'03 Oct • Simulation',amount:'+ ₹2,500.00'),
    TransactionTile(title:'Demo Recharge',subtitle:'01 Oct • Simulation',amount:'- ₹299.00'),
  ]);
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Services', style: TextStyle(fontSize:26,fontWeight:FontWeight.w800)), const SizedBox(height:12),
    ..._serviceTiles(context),
  ]);
}


  static List<Widget> _serviceTiles(BuildContext context) {
    final items = <(String, IconData, Widget)>[
      ('Fund Transfer (Demo)', Icons.swap_horiz, const TransferPage()),
      ('Beneficiaries', Icons.people_outline, const InfoPage(title:'Beneficiaries')),
      ('Bill Payments & Recharge', Icons.receipt_long_outlined, const InfoPage(title:'Bill Payments & Recharge')),
      ('Debit Card Controls', Icons.credit_card, const CardControlsPage()),
      ('Fixed / Recurring Deposits', Icons.savings_outlined, const DepositsPage()),
      ('Cheque Services', Icons.description_outlined, const InfoPage(title:'Cheque Services')),
      ('Statements', Icons.article_outlined, const InfoPage(title:'Statements')),
      ('Notifications', Icons.notifications_none, const InfoPage(title:'Notifications')),
    ];
    return items.map((e) => Card(elevation:0, child: ListTile(leading:Icon(e.$2), title:Text(e.$1), trailing:const Icon(Icons.chevron_right), onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>e.$3))))).toList();
  }

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override Widget build(BuildContext context) => ListView(padding:const EdgeInsets.all(18), children:[
    const Text('Profile',style:TextStyle(fontSize:26,fontWeight:FontWeight.w800)), const SizedBox(height:12),
    const Card(elevation:0,child:ListTile(leading:CircleAvatar(child:Icon(Icons.person)),title:Text('Demo Customer'),subtitle:Text('Project profile • No real bank account'))),
    Card(elevation:0,child:ListTile(leading:const Icon(Icons.logout),title:const Text('Logout'),onTap:()=>Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(_)=>const LoginPage()),(_)=>false))),
  ]);
}

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});
  @override State<TransferPage> createState()=>_TransferPageState();
}
class _TransferPageState extends State<TransferPage>{
  final amount=TextEditingController();
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Demo Transfer')),body:ListView(padding:const EdgeInsets.all(20),children:[
    const DemoBanner(), const SizedBox(height:20),
    const Text('This screen never sends money. It only demonstrates UI behavior.'), const SizedBox(height:20),
    TextField(decoration:const InputDecoration(labelText:'Demo beneficiary',border:OutlineInputBorder(),hintText:'Example: Project User')),
    const SizedBox(height:14), TextField(controller:amount,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Demo amount',prefixText:'₹ ',border:OutlineInputBorder())),
    const SizedBox(height:18), FilledButton(onPressed:()=>showDialog(context:context,builder:(_)=>AlertDialog(title:const Text('Simulation complete'),content:Text('No money was transferred. Demo amount: ₹${amount.text.isEmpty?'0':amount.text}'),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('OK'))])),child:const Text('Simulate Transfer')),
  ]));
}

class InfoPage extends StatelessWidget {
  final String title;
  const InfoPage({super.key, required this.title});
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:Text(title)),body:const Padding(padding:EdgeInsets.all(24),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[DemoBanner(),SizedBox(height:24),Text('Interactive project module',style:TextStyle(fontSize:22,fontWeight:FontWeight.w800)),SizedBox(height:8),Text('This module is intentionally limited to fictional/local demonstration data and does not connect to a bank or payment network.')]));
}


class CardControlsPage extends StatefulWidget {
  const CardControlsPage({super.key});
  @override State<CardControlsPage> createState()=>_CardControlsPageState();
}
class _CardControlsPageState extends State<CardControlsPage>{
  bool online=true, contactless=false, atm=true;
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Debit Card Controls')),body:ListView(padding:const EdgeInsets.all(20),children:[
    const DemoBanner(), const SizedBox(height:16),
    Card(elevation:0,child:Container(padding:const EdgeInsets.all(20),height:190,child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('DEMO DEBIT CARD',style:TextStyle(fontWeight:FontWeight.w800)),Spacer(),Text('••••  ••••  ••••  4821',style:TextStyle(fontSize:22,fontWeight:FontWeight.w700)),SizedBox(height:10),Text('DEMO CUSTOMER   •   VALID 12/30')]))),
    SwitchListTile(title:const Text('Online transactions'),value:online,onChanged:(v)=>setState(()=>online=v)),
    SwitchListTile(title:const Text('Contactless payments'),value:contactless,onChanged:(v)=>setState(()=>contactless=v)),
    SwitchListTile(title:const Text('ATM withdrawals'),value:atm,onChanged:(v)=>setState(()=>atm=v)),
    const Text('Controls are local simulation only.',style:TextStyle(color:Colors.black54)),
  ]));
}

class DepositsPage extends StatelessWidget {
  const DepositsPage({super.key});
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Deposits')),body:ListView(padding:const EdgeInsets.all(20),children:[
    const DemoBanner(), const SizedBox(height:18),
    const Text('Deposit products',style:TextStyle(fontSize:24,fontWeight:FontWeight.w800)),
    const SizedBox(height:10),
    const Card(elevation:0,child:ListTile(leading:Icon(Icons.lock_clock_outlined),title:Text('Fixed Deposit'),subtitle:Text('Create a fictional FD for UI demonstration'),trailing:Icon(Icons.chevron_right))),
    const Card(elevation:0,child:ListTile(leading:Icon(Icons.calendar_month_outlined),title:Text('Recurring Deposit'),subtitle:Text('Monthly demo deposit setup'),trailing:Icon(Icons.chevron_right))),
    const SizedBox(height:12),
    const Card(elevation:0,child:Padding(padding:EdgeInsets.all(18),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Demo FD •••• 1024',style:TextStyle(fontWeight:FontWeight.w800)),SizedBox(height:8),Text('Principal  ₹ 50,000.00'),Text('Maturity   ₹ 53,240.00'),Text('Status     Active (simulation)')]))),
  ]));
}
