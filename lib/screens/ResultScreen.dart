import 'package:flutter/material.dart';
import 'package:insta_med_ui/components/bottom_navigation_widget.dart';
import 'package:insta_med_ui/theme/colors.dart';
import 'package:insta_med_ui/widgets/custom_button.dart';

class ResultScreen extends StatelessWidget {
  final String result;
  final Map<String, dynamic> inputData;

  ResultScreen({required this.result, required this.inputData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prediction Result:',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              result,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.accentColor,
                  ),
            ),
            const SizedBox(height: 32),
            Text(
              'Input Data:',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
            ),
            const SizedBox(height: 16),
            _buildInputDataRow(context, 'Age', '${inputData['age']}'), // Passing context
            _buildInputDataRow(context, 'Gender', inputData['sex'] == 1 ? 'Male' : 'Female'), // Passing context
            _buildInputDataRow(context, 'Resting Blood Pressure', '${inputData['restingBloodPressure']} mmHg'), // Passing context
            _buildInputDataRow(context, 'Serum Cholesterol', '${inputData['serumCholesterol']} mg/dL'), // Passing context
            _buildInputDataRow(context, 'Fasting Blood Sugar Level', '${inputData['fastingBloodSugarLevel']} mg/dL'), // Passing context
            _buildInputDataRow(context, 'Maximum Heart Rate', '${inputData['maximumHeartRate']} bpm'), // Passing context
            const SizedBox(height: 32),
            Center(
              child: CustomButton(
                text: 'Go Back to Home',
                onPressed: () {
              
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNavigationWidget()),
                    (route) => false,
                  );
                },
                color: AppColors.primaryColor,
                textColor: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputDataRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textColor,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.accentColor,
                ),
          ),
        ],
      ),
    );
  }
}
