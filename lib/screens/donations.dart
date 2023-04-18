import 'dart:async';

import 'package:classschedule_app/Blocs/SettingsBloc/settings_bloc.dart';
import 'package:classschedule_app/Services/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../constants/words.dart';
import '../constants/themes.dart';

class Donations extends StatefulWidget {
  const Donations({Key? key}) : super(key: key);

  @override
  State<Donations> createState() => _DonationsState();
}

class _DonationsState extends State<Donations> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        setState(() {});
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          setState(() {});
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = true;
          if (valid) {
          } else {}
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
          setState(() {});
        }
      }
    });
  }

  Future<void> initPur() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      setState(() {});
      return;
    }
    setState(() {});
    const Set<String> _kIds = <String>{'donation'};
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(_kIds);

    if (response.notFoundIDs.isNotEmpty) {
      setState(() {});
    }
    setState(() {});
    List<ProductDetails> products = response.productDetails;
    print(products[0].title);

    final ProductDetails productDetails =
        products[0]; // Saved earlier from queryProductDetails().
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);

    InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
  }

  @override
  Widget build(BuildContext context) {
    SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return BlocBuilder(
      bloc: settingsBloc,
      builder: (BuildContext context, SettingsState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              donations[state.settings.langID]!,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            iconTheme: settingsBloc.state.settings.theme == 'light'
                ? iconThemeDark
                : iconThemeLight,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    donations1[state.settings.langID]!,
                    style: TextStyle(color: Theme.of(context).backgroundColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    donations2[state.settings.langID]!,
                    style: TextStyle(color: Theme.of(context).backgroundColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    donations3[state.settings.langID]!,
                    style: TextStyle(color: Theme.of(context).backgroundColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    donations4[state.settings.langID]!,
                    style: TextStyle(color: Theme.of(context).backgroundColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      initPur();
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.blueAccent),
                    ),
                    child: const Text(
                      "          2\$          ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    donations5[state.settings.langID]!,
                    style: TextStyle(color: Theme.of(context).backgroundColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      UtilityService.launchURL(
                          "https://www.buymeacoffee.com/petarspajdermen");
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.amber),
                    ),
                    child: const Text(
                      "Buy me a coffee",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
