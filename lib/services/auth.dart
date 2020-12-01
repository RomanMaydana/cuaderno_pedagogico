import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  Future<bool> isLogged() async {
    final auth = FirebaseAuth.instance;

    User user = auth.currentUser;

    if (user != null) {
      return true;
    }
    return false;
  }

  Future<void> reload() async {
    final auth = FirebaseAuth.instance;
    User user = auth.currentUser;
    await user.reload();
  }

  User getUser() {
    final auth = FirebaseAuth.instance;
    return auth.currentUser;
  }

  Future<void> signOut() async {
    final auth = FirebaseAuth.instance;
    await auth.signOut();
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    final auth = FirebaseAuth.instance;

    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    return userCredential?.user?.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    final auth = FirebaseAuth.instance;

    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await signOut();
    return userCredential.user?.uid;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    final auth = FirebaseAuth.instance;
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    final auth = FirebaseAuth.instance;

    User user = auth.currentUser;

    if (user != null) {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: user.email, password: oldPassword);

        await userCredential.user.updatePassword(newPassword);
      } on FirebaseAuthException catch (e) {
        throw e.message;
      }
    } else
      throw 'Sign out and sign in again.';
  }

  Future<void> updateEmail(String password, String newEmail) async {
    final auth = FirebaseAuth.instance;
    User user = auth.currentUser;

    UserCredential userCredential = await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: user.email, password: password));

    await userCredential.user.verifyBeforeUpdateEmail(newEmail);
    await user.reload();
    print(user.toString());
    // print(user.email + " -  -  -  - ");
    // print(user);

    // await user.updateEmail(email);
    // await user.reload();

    // print(user.toString());

    // await user.verifyBeforeUpdateEmail(email);

    // print(user.toString());
    // await user.sendEmailVerification();
  }

  Stream<User> authChange() {
    final auth = FirebaseAuth.instance;
    return auth.authStateChanges();
  }
}
