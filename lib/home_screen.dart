
import 'package:bmicalculator/bloc/bmi_bloc/bmi_bloc.dart';
import 'package:bmicalculator/bloc/bmi_bloc/bmi_event.dart';
import 'package:bmicalculator/bloc/bmi_bloc/bmi_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/textfield_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController heightController = TextEditingController(),
        weightController = TextEditingController();
    return Scaffold(
      body:      SingleChildScrollView(
 
        child:  Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 30,),
                    const Text(
                      "BMI Calculator",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    TextfieldWidget(
                      title: 'Insert Weight',
                      hint: 'kg',
                      controller: weightController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextfieldWidget(
                      title: 'Insert Height',
                      hint: 'cm',
                      controller: heightController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 175,
                      child: ElevatedButton(
                        onPressed: () {
                          //calculate bmi and insert value of bmi result into table bmi
                          context.read<BmiBloc>().add(BmiEvent(
                              heightController.text, weightController.text));
                        },
                        child: const Text(
                          "calculate BMI",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BlocBuilder<BmiBloc, BmiState>(
                      builder: (context, state) {
                        if (state is InitialState) {
                          return const Text("");
                        } else if (state is ZeroState) {
                          return const Text("please enter a valid number");
                        } else if (state is ResultState) {
                          return Text(
                            "Your Bmi is: ${state.result}\naverage: ${state.average}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          );
                        } else {
                          if (state is EmptyState) {
                            return const Text(
                              "enter height and weight",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            );
                          } else {
                            return const Text(
                              "Error",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
