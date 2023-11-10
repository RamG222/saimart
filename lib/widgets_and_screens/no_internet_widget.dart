import 'package:flutter/material.dart';
import 'homepage.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 70),
          Image.asset("assets/splash.png"),
          const SizedBox(height: 150),
          const Center(
            child: Text(
              'No internet Conncetion',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ),
          const SizedBox(height: 150),
          OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Homepage(),
                    ));
              },
              child: const Text(
                "Reload",
                style: TextStyle(color: Colors.blue),
              )),
        ],
      ),
    );
  }
}
