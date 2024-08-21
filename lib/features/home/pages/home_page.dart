import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../machine/bloc/machine_bloc.dart';
import '../widgets/home_add_button.dart';
import '../widgets/machine_card.dart';
import '../widgets/no_data.dart';
import '../widgets/product_card.dart';
import '../widgets/profit_card.dart';
import '../widgets/tab_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              const CustomAppbar('Onboard', home: true),
              const SizedBox(height: 15),
              const ProfitCard(),
              const SizedBox(height: 24),
              TabWidget(tabController: _tabController),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BlocBuilder<MachineBloc, MachineState>(
                      builder: (context, state) {
                        if (state is MachinesLoadedState) {
                          if (state.machines.isEmpty) return const NoData();
                          return ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            children: [
                              const SizedBox(height: 27),
                              ...List.generate(
                                state.machines.length,
                                (index) {
                                  return MachineCard(
                                    machine: state.machines[index],
                                  );
                                },
                              ),
                              const SizedBox(height: 80),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                    BlocBuilder<MachineBloc, MachineState>(
                      builder: (context, state) {
                        if (state is MachinesLoadedState) {
                          if (state.products.isEmpty) return const NoData();
                          return ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            children: [
                              const SizedBox(height: 27),
                              ...List.generate(
                                state.products.length,
                                (index) {
                                  return ProductCard(
                                    product: state.products[index],
                                  );
                                },
                              ),
                              const SizedBox(height: 80),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const HomeAddButton(),
        ],
      ),
    );
  }
}
