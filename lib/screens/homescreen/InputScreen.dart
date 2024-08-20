import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_med_ui/provider/HistoryProvider.dart';
import 'package:insta_med_ui/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:insta_med_ui/screens/ResultScreen.dart';
import 'package:insta_med_ui/service.dart/api_service.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _restingBloodPressureController = TextEditingController();
  final _serumCholesterolController = TextEditingController();
  final _maximumHeartRateController = TextEditingController();
  final _stDepressionController = TextEditingController();
  final _numberOfMajorVesselsController = TextEditingController();

  String _gender = 'Male';
  String _chestPainTypeController = 'Typical angina';
  String _fastingBloodSugarLevelController = 'True';
  String _restingElectrocardiographicController = 'Normal';
  String _exerciseInducedAnginaController = 'Yes';
  String _slopeController = 'Upsloping';
  String _thalliumStressController = 'Normal';

  final ApiService _apiService = ApiService();

  @override
  void dispose() {
    _ageController.dispose();
    _restingBloodPressureController.dispose();
    _serumCholesterolController.dispose();
    _maximumHeartRateController.dispose();
    _stDepressionController.dispose();
    _numberOfMajorVesselsController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final inputData = {
          'age': int.parse(_ageController.text),
          'sex': _gender == 'Male' ? 1 : 0,
          'chestPainType' :  _chestPainTypeController == 'Typical angina'
            ? 1
            : _chestPainTypeController == 'Atypical angina'
                ? 2
                : _chestPainTypeController == 'Non-anginal pain'
                    ? 3
                    : 4,
          'restingBloodPressure':
              double.parse(_restingBloodPressureController.text),
          'serumCholesterol': double.parse(_serumCholesterolController.text),
          'fastingBloodSugarLevel':  _fastingBloodSugarLevelController == 'True' ? 1 : 0,
          'restingElectrocardiographicResults':
            _restingElectrocardiographicController == 'Normal'
                ? 0
                : _restingElectrocardiographicController == 'Having ST-T wave abnormality'
                    ? 1
                    : 2,
          'maximumHeartRate': int.parse(_maximumHeartRateController.text),
          'exerciseInducedAngina': _exerciseInducedAnginaController == 'Yes' ? 1 : 0,
          'stDepression': double.parse(_stDepressionController.text),
          'slope': _slopeController == 'Upsloping'
            ? 1
            : _slopeController == 'Flat'
                ? 2
                : 3,
        'numberOfMajorVessels': int.parse(_numberOfMajorVesselsController.text),
        'thalliumStressTestResults': _thalliumStressController == 'Normal'
            ? 1
            : _thalliumStressController == 'Fixed defect'
                ? 2
                : _thalliumStressController == 'Reversible defect'
                ? 3
                : 4
        };

        final response = await _apiService.checkHeartDisease(
          age: inputData['age'] as int,
          sex: inputData['sex'] as int,
          chestPainType: inputData['chestPainType'] as int,
          restingBloodPressure: inputData['restingBloodPressure'] as double,
          serumCholesterol: inputData['serumCholesterol'] as double,
          fastingBloodSugarLevel: inputData['fastingBloodSugarLevel'] as int,
          restingElectrocardiographicResults: inputData['restingElectrocardiographicResults'] as int,
          maximumHeartRate: inputData['maximumHeartRate'] as int,
          exerciseInducedAngina: inputData['exerciseInducedAngina'] as int,
          stDepression: inputData['stDepression'] as double,
          slope: inputData['slope'] as int,
          numberOfMajorVessels: inputData['numberOfMajorVessels'] as int,
          thalliumStressTestResults: inputData['thalliumStressTestResults'] as int
        );

        // Print the raw API response
        print('API response: $response');

        if (response is Map<String, dynamic>) {
          if (response.containsKey('error')) {
            print('Error found in response: ${response['error']}');
            _showDialog(
                'Error', 'Failed to check heart disease: ${response['error']}');
          } else {
            final resultMessage =
                response['prediction_result'] ?? 'No result found';
            print('Prediction result received: $resultMessage');

            // Save result to history
            await Provider.of<HistoryProvider>(context, listen: false)
                .addResult(resultMessage);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ResultScreen(result: resultMessage, inputData: inputData),
              ),
            );
          }
        } else if (response is String) {
          // Handle the case where the response is a plain string
          print('Prediction result received: $response');

          // Save result to history
          await Provider.of<HistoryProvider>(context, listen: false)
              .addResult(response);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ResultScreen(result: response, inputData: inputData),
            ),
          );
        } else {
          print('Unexpected error: Unknown response format.');
          _showDialog('Error', 'Unexpected error: unknown response format.');
        }
      } catch (e) {
        print('Exception occurred during API call: $e');
        _showDialog('Error', 'An unexpected error occurred: $e');
      }
    } else {
      print('Form validation failed.');
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart Disease Check'),
        backgroundColor: const Color(0xFF1259e4),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.h),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                controller: _ageController,
                labelText: 'Age',
                
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your age'
                    : null,
              ),
              SizedBox(height: 16.0.h),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  labelStyle: TextStyle(
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(),
                ),
                items: ['Male', 'Female'].map((label) {
                  return DropdownMenuItem(
                    value: label,
                    child: Text(label),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _gender = value!),
              ),
               SizedBox(height: 16.0.h),
              DropdownButtonFormField<String>(
                value: _chestPainTypeController,
                decoration: const InputDecoration(
                  labelText: 'Chest Pain type',
                  labelStyle: TextStyle(
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(),
                ),
                items: [
                    'Typical angina',
                    'Atypical angina',
                    'Non-anginal pain',
                    'Asymptomatic'
                   ].map((label) {
                  return DropdownMenuItem(
                    value: label,
                    child: Text(label),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _chestPainTypeController = value!),
              ),
              SizedBox(height: 16.0.h),
              _buildTextField(
                controller: _restingBloodPressureController,
                labelText: 'Resting Blood Pressure (mmHg)',
                
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your resting blood pressure'
                    : null,
              ),
              SizedBox(height: 16.0.h),
              _buildTextField(
                controller: _serumCholesterolController,
                labelText: 'Serum Cholesterol (mg/dL)',
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your serum cholesterol level'
                    : null,
              ),
               SizedBox(height: 16.0.h),
              DropdownButtonFormField<String>(
                value: _fastingBloodSugarLevelController,
                decoration: const InputDecoration(
                  labelText: 'Sugar Level',
                  border: OutlineInputBorder(),
                ),
                items: ['True', 'False'].map((label) {
                  return DropdownMenuItem(
                    value: label,
                    child: Text(label),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _fastingBloodSugarLevelController = value!),
              ),
              SizedBox(height: 16.0.h),
              DropdownButtonFormField<String>(
                value: _restingElectrocardiographicController,
                decoration: const InputDecoration(
                  labelText: 'RESTING_ELECTROCARDIOGRAPHOC',
                  border: OutlineInputBorder(),
                ),
                items: ['Normal', 'Having ST-T wave abnormality', 'Showing probable'].map((label) {
                  return DropdownMenuItem(
                    value: label,
                    child: Text(label),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _restingElectrocardiographicController = value!),
              ),
              SizedBox(height: 16.0.h),
              _buildTextField(
                controller: _maximumHeartRateController,
                labelText: 'Maximum Heart Rate (bpm)',
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your maximum heart rate'
                    : null,
              ),
              SizedBox(height: 16.0.h),
              DropdownButtonFormField<String>(
                value: _exerciseInducedAnginaController,
                decoration: const InputDecoration(
                  labelText: 'Induced Angina',
                  border: OutlineInputBorder(),
                ),
                items: ['Yes', 'No', ].map((label) {
                  return DropdownMenuItem(
                    value: label,
                    child: Text(label),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _exerciseInducedAnginaController = value!),
              ),
              SizedBox(height: 16.0.h),
              _buildTextField(
                controller: _stDepressionController,
                labelText: 'Depression',
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'st Depression'
                    : null,
              ),
              SizedBox(height: 16.0.h),
              DropdownButtonFormField<String>(
                value: _slopeController,
                decoration: const InputDecoration(
                  labelText: 'Slope',
                  border: OutlineInputBorder(),
                ),
                items: ['Upsloping', 'Flat', 'Downsloping'].map((label) {
                  return DropdownMenuItem(
                    value: label,
                    child: Text(label),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _slopeController = value!),
              ),
               SizedBox(height: 16.0.h),
              _buildTextField(
                controller: _numberOfMajorVesselsController,
                labelText: 'Vesseels',
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'major vessels'
                    : null,
              ),
               SizedBox(height: 16.0.h),
              DropdownButtonFormField<String>(
                value: _thalliumStressController,
                decoration: const InputDecoration(
                  labelText: 'Stress Results',
                  border: OutlineInputBorder(),
                ),
                items: ['Normal', 'Fixed defect', 'Reversible defect', 'Not described'].map((label) {
                  return DropdownMenuItem(
                    value: label,
                    child: Text(label),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _thalliumStressController = value!),
              ),
              SizedBox(height: 16.0.h),
              CustomButton(
                text: 'Submit',
                onPressed: _submitForm,
                color: const Color(0xFF16cdac),
                textColor: Colors.white,
                borderRadius: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0.h),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 16.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 20.0.w),
        ),
      ),
    );
  }
}
