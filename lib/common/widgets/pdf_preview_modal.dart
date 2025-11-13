import 'dart:io';
//
// import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_file/internet_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:recharge_max/common/models/pdf_preview_item.dart';
import 'package:recharge_max/common/widgets/app_button.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/utils/app_logger.dart';

// ...other imports...

class PdfPreviewModal extends StatefulWidget {
  final String title;
  final String? desc;
  final List<PdfPreviewItem> pdfItems;
  final bool showButtons, canEdit;
  final Function()? uploadFile;

  const PdfPreviewModal({
    super.key,
    required this.title,
    required this.pdfItems,
    this.uploadFile,
    this.desc,
    this.showButtons = true, this.canEdit = false
  });

  @override
  State<PdfPreviewModal> createState() => _PdfPreviewModalState();
}

class _PdfPreviewModalState extends State<PdfPreviewModal> {
  late final PageController _pageController;
  late final List<Future<PdfDocument>> _pdfFutures;
  late final List<PdfController?> _pdfControllers;
  int currentPdfIndex = 0;
  bool downloadingFile = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pdfFutures = widget.pdfItems
        .map((item) =>  PdfDocument.openData(InternetFile.get((item.path))))
        .toList();
    _pdfControllers = List.generate(widget.pdfItems.length, (_) => null);
  }


  Future<void> _downloadPdf(String url, String fileName, BuildContext context) async {
    try {
      setState(() {
        downloadingFile = true;
      });
      String savePath;
      AppLogger.info('_downloadPdf ${url}');

      final dir = await getTemporaryDirectory();
      savePath = "${dir.path}/$fileName";
      await Dio().download(url, savePath);

      await Share.shareXFiles(
        [XFile(savePath, mimeType: 'application/pdf')],
        text: 'Sample Doc',
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("File saved to device")),
        );
      }

    } catch (e) {
      AppLogger.info('_downloadPdf ${e}');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Download failed: $e")),
        );
      }
    }

    setState(() {
      downloadingFile = false;
    });
  }

  @override
  void dispose() {
    for (final c in _pdfControllers) {
      c?.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 8,
                  width: 56,
                  decoration: BoxDecoration(
                    color: AppColors.grey400,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.pdfItems[currentPdfIndex]?.title ?? widget.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.desc ?? 'This sample shows the correct format and details expected.',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey300),
                ),
              ),
              // PDF PageView
              Expanded(
                child: PageView.builder(
                  itemCount: widget.pdfItems.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPdfIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Expanded(
                          child: FutureBuilder<PdfDocument>(
                            future: _pdfFutures[index],
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              }
                              final pdfDoc = snapshot.data!;
                              _pdfControllers[index] ??= PdfController(
                                document: Future.value(pdfDoc),
                                initialPage: 1,
                              );
                              return PdfView(
                                controller: _pdfControllers[index]!,
                                builders: PdfViewBuilders<DefaultBuilderOptions>(
                                  options: const DefaultBuilderOptions(),
                                  documentLoaderBuilder: (_) =>
                                      const Center(child: CircularProgressIndicator()),
                                  pageLoaderBuilder: (_) =>
                                      const Center(child: CircularProgressIndicator()),
                                  errorBuilder: (_, err) =>
                                      Center(child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Text('Unable to view pdf file'),
                                      )),
                                ),
                              );
                            },
                          ),
                        ),
                        if (widget.pdfItems[index].subtitle != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Text(
                              widget.pdfItems[index].subtitle!,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.grey300,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),

              // Worm Effect Page Indicator
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: widget.pdfItems.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 6,
                      dotWidth: 7,
                      activeDotColor: AppColors.deepGreen,
                      dotColor: const Color(0xff4f6642).withAlpha(40),
                    ),
                  ),
                ),
              ),

              if (widget.showButtons)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: widget.canEdit ? AppButton.fill(
                    context: context,
                    text: 'Re-Upload Document',
                    backgroundColor: AppColors.colorPrimary,
                    size: Size(1.sw, 48.h),
                    onPressed: widget.uploadFile,
                  )
            : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppButton.outlined(
                        context: context,
                        text: 'Download Sample',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        size: Size(0.43.sw, 48.h),
                        isLoading: downloadingFile,
                        disabled: downloadingFile,
                        radius: BorderRadius.circular(8),
                        textColor: Colors.black,
                        borderColor: AppColors.grey400,
                          onPressed: () {
                            final item = widget.pdfItems[currentPdfIndex];
                            final url = item.path;
                            final fileName = url.split('/').last; // Extract filename from URL
                            _downloadPdf(url, fileName, context);
                          }
                      ),
                      const SizedBox(width: 12),
                      AppButton.fill(
                        context: context,
                        text: 'Upload Document',
                        backgroundColor: AppColors.colorPrimary,
                        size: Size(0.43.sw, 48.h),
                        onPressed: widget.uploadFile,
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}