import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tiktok_clone/config/app_router.dart';
import 'package:tiktok_clone/config/locator.dart';
import 'package:tiktok_clone/firebase_options.dart';
import 'package:tiktok_clone/utils/widgets/ui_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter.config(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<GoogleSignInAccount?> _googleSignInAccount =
      ValueNotifier<GoogleSignInAccount?>(null);

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'openid',
    'profile',
  ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(
          valueListenable: _googleSignInAccount,
          builder: (context, GoogleSignInAccount? googleSignInAccount, child) {
            return Center(
              child: googleSignInAccount == null
                  ? UiButton(
                      icon: SvgPicture.asset('assets/images/ic_like_inactive.svg'),
                      value: 'Google Sign In',
                      onTap: () async {
                        try {
                          GoogleSignInAccount? googleSignInAcc = await _googleSignIn.signIn();
                          debugPrint("=====Google Sign In Account: $googleSignInAcc");
                          GoogleSignInAuthentication? auth;
                          if (googleSignInAcc != null) {
                            auth = await googleSignInAcc.authentication;
                          }
                          debugPrint("=====Google Sign In Auth 1: ${auth?.idToken}");
                          if (googleSignInAcc != null && auth?.idToken == null) {
                            googleSignInAcc =
                                await _googleSignIn.signInSilently(reAuthenticate: true);
                            if (googleSignInAcc != null) {
                              auth = await googleSignInAcc.authentication;
                            }
                            debugPrint("=====Google Sign In Auth: ${auth?.idToken}");
                          }
                          _googleSignInAccount.value = googleSignInAcc;
                        } catch (error) {
                          debugPrint("=====Error: $error");
                        }
                      },
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GoogleUserCircleAvatar(
                          identity: googleSignInAccount,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          googleSignInAccount.displayName ?? '',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        )
                      ],
                    ),
            );
          }),
    );
  }
}
