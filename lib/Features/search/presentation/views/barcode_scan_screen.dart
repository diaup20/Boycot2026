import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../Core/helpers/navigation_helpers.dart';
import '../../../home/data/models/product_model.dart';
import '../../../home/presentation/view_model/home_cubit/home_cubit.dart';
import '../view_model/cubit/search_cubit.dart';
import 'search_screen.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({Key? key}) : super(key: key);
   

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _handling = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _safePause();
    controller?.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller == null) return;
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _safePause();
    } else if (state == AppLifecycleState.resumed) {
      _safeResume();
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _safePause();
    }
    _safeResume();
  }

  void _onQRViewCreated(QRViewController ctrl) {
    controller = ctrl;
    _safeResume();

    ctrl.scannedDataStream.listen((scanData) async {
      if (_handling) return;
      _handling = true;

      final code = scanData.code?.trim();
      if (code == null || code.isEmpty) {
        _handling = false;
        return;
      }

      final cubit = context.read<SearchCubit>();
          final allProducts = context.read<HomeCubit>().cachedAllProducts ?? [];

      if (cubit.cacheIsEmpty) {
        await cubit.loadAll();
      }
      final results = await cubit.getSearchResults(code);

      if (!mounted) return;

      if (results.isEmpty) {
        await _safePause();
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: const Text('منتج غير متوفر'),
            content: const Text(
              'هذا المنتج غير موجود.\nاضغط "رجوع" لإعادة المحاولة.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('رجوع'),
              ),
            ],
          ),
        );
        await _safeResume();
        _handling = false;
      } else if (results.length == 1) {
        await _safePause();
        final ProductModel product = results.first;
          navigateToProductDetail(
                            context,
                            product: product,
                            allProducts: allProducts,
                          );
        await _safeResume();
        _handling = false;
      } else {
        await _safePause();
        cubit.emit(SearchLoadedList(results));
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const SearchScreen()),
        );
        await _safeResume();
        _handling = false;
      }
    });
  }

  Future<void> _safePause() async {
    try {
      await controller?.pauseCamera();
    } catch (_) {}
  }

  Future<void> _safeResume() async {
    try {
      await controller?.resumeCamera();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Theme.of(context).primaryColor,
          borderRadius: 0,
          borderLength: 40,
          borderWidth: 5,
          cutOutSize: MediaQuery.of(context).size.width * 0.9,
        ),
      ),
    );
  }
}
