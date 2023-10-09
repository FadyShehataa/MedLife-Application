import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../Patient%20Home/presentation/manager/rating_cubit/rating_cubit.dart';
import '../../../../../Resignation/presentation/views/widgets/show_snake_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({Key? key, required this.pharmacyId}) : super(key: key);
  final String pharmacyId;

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double _rating = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingCubit, RatingState>(
      listener: (context, state) {
        if (state is RatingLoading) {
          isLoading = true;
        } else if (state is RatingSuccess) {
          Navigator.pop(context);
          isLoading = false;
        } else if (state is RatingFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: AlertDialog(
            
            title: const Text(
              'How would you rate this pharmacy?',
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RatingBar.builder(
                  allowHalfRating: false,
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 30,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<RatingCubit>(context).reviewPharmacy(
                    pharmacyID: widget.pharmacyId,
                    bodyRequest: {"rate": _rating.toInt()},
                  );
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }
}
