import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/core/color/app_colors.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart'; 

class MyDetailsView extends StatefulWidget {
  @override
  _MyDetailsViewState createState() => _MyDetailsViewState();
}

class _MyDetailsViewState extends State<MyDetailsView> {
  String gender = 'Select Gender'; 
  String phoneNumber = ''; 
  String selectedDate = ''; 

  PhoneNumber phoneController = PhoneNumber(isoCode: 'US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Details', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Full Name', ''),
            _buildTextField('Email Address', ''),
            _buildDateField(),
            _buildGenderField(),
            _buildPhoneField(),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                _showSuccessDialog();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1A1A1A)),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Date of Birth',
          filled: true,
          fillColor: AppColors.inputFieldBorder1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today, color: Colors.grey),
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        controller: TextEditingController(text: selectedDate),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, 
            colorScheme: ColorScheme.light().copyWith(secondary: Colors.blue),
            dialogBackgroundColor: Colors.white, 
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }


  Widget _buildGenderField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        readOnly: true, 
        decoration: InputDecoration(
          labelText: 'Gender',
          filled: true,
          fillColor: AppColors.inputFieldBorder1, 
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
            onPressed: () {
              _showGenderDialog();
            },
          ),
        ),
        controller: TextEditingController(text: gender),
      ),
    );
  }

 
  void _showGenderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
      
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Male'),
                onTap: () {
                  setState(() {
                    gender = 'Male';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Female'),
                onTap: () {
                  setState(() {
                    gender = 'Female';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          setState(() {
            phoneNumber = number.phoneNumber!;
          });
        },
        onInputValidated: (bool isValid) {
        },
        initialValue: phoneController,
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
          showFlags: true, 
        ),
        inputDecoration: InputDecoration(
          labelText: 'Phone Number',
          filled: true,
          fillColor: AppColors.inputFieldBorder1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: AppColors.inputFieldBorder1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        ),
        controller: TextEditingController(text: value),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Success'),
          content: Text('Your details have been saved successfully!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
