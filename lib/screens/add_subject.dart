import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

var _productIdList = {'product1', 'product2', 'product3'};

class AddSubject extends StatefulWidget {
  AddSubject({Key? key}) : super(key: key);

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  String status = 'NISTA';
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
      setState(() {
        status = 'GRESKA';
      });
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
        setState(() {
          status = 'CEKAM';
        });
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          setState(() {
            status = 'GRESKA';
          });
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = true;
          if (valid) {
            setState(() {
              status = 'VALIDNO';
            });
          } else {
            setState(() {
              status = 'NIJE VALIDNO';
            });
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
          setState(() {
            status = 'KUPLJENO';
          });
        }
      }
    });
  }

  String txt = "NIJE ZAPOCETO";

  Future<void> initPur() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      setState(() {
        txt = 'NE RADI';
      });
      return;
    }
    setState(() {
      txt = 'RADi';
    });
    const Set<String> _kIds = <String>{'donation'};
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(_kIds);

    if (response.notFoundIDs.isNotEmpty) {
      setState(() {
        txt = 'ne radi 2';
      });
    }
    setState(() {
      txt = 'radi 2';
    });
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Add Subject"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: Text(txt),
            onPressed: () {
              initPur();
            },
          ),
          Text(status)
        ],
      ),
    );
  }
}
