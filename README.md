# interro

A new Flutter project.



            // const Text(
            //   "Congratulation\nYou have successfully Login",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            // ),
            // MyButtons(
            //   onTap: () async {
            //     SharedPreferences prefs = await SharedPreferences.getInstance();
            //     prefs.setBool("isAuthenticated", false);
            //     await FirebaseServices().googleSignOut();
            //     Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(
            //         builder: (context) => const LogIn(),
            //       ),
            //     );
            //   },
            //   text: "Log Out",
            // ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                left: 16,
                right: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      print('setting');
                    },
                    child: const Icon(
                      Icons.settings,
                      color: secondColor,
                      size: 40,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("out");
                    },
                    child: const Icon(
                      Icons.exit_to_app_outlined,
                      size: 40,
                      color: secondColor,
                    ),
                  ),
                ],
              ),
            )