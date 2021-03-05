part of 'screens.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: VStack(
          [
            'Selamat datang di AlgoDoc!'
                .text
                .textStyle(textCustom.headline)
                .make()
                .objectCenter()
                .pOnly(top: 90),
            'Cari dokter yang tepat untuk masalah anda konsultasikan, dan dapatkan solusi hanya dengan sekali sentuh.'
                .text
                .center
                .textStyle(textCustom.content)
                .make()
                .objectCenter()
                .pSymmetric(h: 40, v: 20),
            60.heightBox,
            Image.asset('assets/signin_illustration.png',scale: 1.2,)
                .centered()
                .pSymmetric(h: 40),
            60.heightBox,
            VxBox(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: colors.bluePrimary,
                      elevation: 0.0,
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      )),
                  onPressed: () {
                    context.read<UserBloc>().add(UserLogin());
                  },
                  child: 'Masuk dengan akun Google'.text.white.make()),
            ).make().wFull(context).pSymmetric(h: 40),
          ],
          alignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
