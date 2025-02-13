import 'package:flutter/material.dart';
import 'package:oruphones/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class Accordion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.fetchFAQs(),
      builder: (context, viewModel, child) {
        return viewModel.isBusy || viewModel.faqs == null || viewModel.faqs!.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: viewModel.faqs!.length,
          itemBuilder: (context, index) {
            var faq = viewModel.faqs![index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.grey.shade400),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: ExpansionTile(
                    backgroundColor: Colors.white,
                    collapsedBackgroundColor: Colors.white,
                    tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
                    childrenPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    title: Text(
                      faq.question,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(faq.isExpanded ? Icons.close : Icons.add, color: Colors.black54),
                    onExpansionChanged: (bool expanded) {
                      viewModel.toggleFAQ(index);
                    },
                    children: [
                      Container(
                        color: Colors.white,
                        child: Text(
                          faq.answer,
                          style: TextStyle(fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
