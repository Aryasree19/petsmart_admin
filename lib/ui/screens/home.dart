import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsmart_admin/blocs/manage_listings/manage_listings_bloc.dart';
import 'package:petsmart_admin/ui/screens/home_screen_sections/complaints_screen.dart';
import 'package:petsmart_admin/ui/screens/home_screen_sections/doctor_screen.dart';
import 'package:petsmart_admin/ui/screens/home_screen_sections/listing_screen.dart';
import 'package:petsmart_admin/ui/screens/home_screen_sections/dashboard_and_order_screen.dart';
import 'package:petsmart_admin/ui/screens/home_screen_sections/pet_categories_screen.dart';
import 'package:petsmart_admin/ui/screens/home_screen_sections/suggestions_screen.dart';
import 'package:petsmart_admin/ui/screens/home_screen_sections/trainer_screen.dart';
import 'package:petsmart_admin/ui/screens/home_screen_sections/user_screen.dart';
import 'package:petsmart_admin/ui/screens/login_screen.dart';
import 'package:petsmart_admin/ui/widgets/change_password_dialog.dart';
import 'package:petsmart_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:petsmart_admin/ui/widgets/custom_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final ManageListingsBloc manageListingsBloc = ManageListingsBloc();

  @override
  void initState() {
    Future.delayed(
      const Duration(
        milliseconds: 100,
      ),
      () {
        if (Supabase.instance.client.auth.currentUser == null) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => true,
          );
        }
      },
    );

    tabController = TabController(
      length: 8,
      initialIndex: 0,
      vsync: this,
    );
    super.initState();
  }

  String getName() {
    switch (tabController.index) {
      case 0:
        return 'DASHBOARD & ORDERS';
      case 1:
        return 'LISTINGS';
      case 2:
        return 'USERS';
      case 3:
        return 'DOCTORS';
      case 4:
        return 'TRAINERS';
      case 5:
        return 'PET CATEGORIES';
      case 6:
        return 'COMPLAINTS';
      case 7:
        return 'SUGGESTIONS';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManageListingsBloc>.value(
      value: manageListingsBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.pink,
          ),
          centerTitle: true,
          title: Text(
            getName(),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
          ),
          elevation: 1,
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Logout',
                    message: 'Are you sure that you want to logout ?',
                    primaryButtonLabel: 'Logout',
                    primaryOnPressed: () async {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => true,
                      );
                      await Supabase.instance.client.auth.signOut();
                    },
                    secondaryButtonLabel: 'Cancel',
                    secondaryOnPressed: () => Navigator.pop(context),
                  ),
                );
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.pink,
              ),
            ),
          ],
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            DashboardAndOrderScreen(
              manageListingsBloc: manageListingsBloc,
            ),
            ListingScreen(
              manageListingsBloc: manageListingsBloc,
            ),
            UserScreen(),
            DoctorScreen(),
            TrainerScreen(),
            PetCategoriesScreen(),
            ComplaintsScreen(),
            SuggestionsScreen(),
          ],
        ),
        drawer: Material(
          color: Colors.pink[50],
          child: SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "MENU",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.pink[700],
                        ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDrawerButton(
                    label: "Dashboard & Orders",
                    iconData: Icons.sell_outlined,
                    onPressed: () {
                      tabController.animateTo(0);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    isSelected: tabController.index == 0,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDrawerButton(
                    label: "Listings",
                    iconData: Icons.list_outlined,
                    onPressed: () {
                      tabController.animateTo(1);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    isSelected: tabController.index == 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDrawerButton(
                    label: "Users",
                    iconData: Icons.people_alt_outlined,
                    onPressed: () {
                      tabController.animateTo(2);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    isSelected: tabController.index == 2,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDrawerButton(
                    label: "Doctors",
                    iconData: Icons.medical_information_outlined,
                    onPressed: () {
                      tabController.animateTo(3);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    isSelected: tabController.index == 3,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDrawerButton(
                    label: "Trainers",
                    iconData: Icons.fitness_center_outlined,
                    onPressed: () {
                      tabController.animateTo(4);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    isSelected: tabController.index == 4,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDrawerButton(
                    label: "Pet Categories",
                    iconData: Icons.pets_outlined,
                    onPressed: () {
                      tabController.animateTo(5);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    isSelected: tabController.index == 5,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDrawerButton(
                    label: "Complaints",
                    iconData: Icons.report_outlined,
                    onPressed: () {
                      tabController.animateTo(6);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    isSelected: tabController.index == 6,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDrawerButton(
                    label: "Suggestions",
                    iconData: Icons.assistant_outlined,
                    onPressed: () {
                      tabController.animateTo(7);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    isSelected: tabController.index == 7,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDrawerButton(
                    label: "Change Password",
                    iconData: Icons.lock_open_outlined,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => const ChangePasswordDialog());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDrawerButton extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Function() onPressed;
  final bool isSelected;
  const CustomDrawerButton({
    Key? key,
    required this.iconData,
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: isSelected ? Colors.pink : Colors.white,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              color: isSelected ? Colors.white : Colors.black,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerButtonCollection extends StatefulWidget {
  final Widget child;
  final IconData icon;
  final String label;
  final bool isExpanded, isActive;
  const DrawerButtonCollection({
    Key? key,
    required this.child,
    required this.icon,
    required this.label,
    this.isExpanded = false,
    this.isActive = false,
  }) : super(key: key);

  @override
  State<DrawerButtonCollection> createState() => _DrawerButtonCollectionState();
}

class _DrawerButtonCollectionState extends State<DrawerButtonCollection> {
  bool _isExpanded = false;

  @override
  void initState() {
    _isExpanded = widget.isExpanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: widget.isActive ? Colors.white : Colors.lightBlueAccent[700],
            child: InkWell(
              borderRadius: BorderRadius.circular(0),
              onTap: () {
                _isExpanded = !_isExpanded;
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      widget.icon,
                      size: 25,
                      color: widget.isActive
                          ? Colors.lightBlueAccent[700]
                          : Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.label,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: widget.isActive
                                      ? Colors.lightBlueAccent[700]
                                      : Colors.white,
                                  fontWeight: widget.isActive
                                      ? FontWeight.w500
                                      : FontWeight.w500,
                                ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: widget.isActive
                          ? Colors.lightBlueAccent[700]
                          : Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          _isExpanded
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                  ),
                  child: widget.child,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
