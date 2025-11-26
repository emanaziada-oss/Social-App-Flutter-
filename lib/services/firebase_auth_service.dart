import 'package:firebase_auth/firebase_auth.dart';
class FirebaseAuthService{
  // Private Constructor
  FirebaseAuthService._();

// Singleton Instance
static final FirebaseAuthService instance = FirebaseAuthService._();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<User?> login (String email, String pass) async{
  try{
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: pass);
    return userCredential.user;
  }on FirebaseAuthException catch(e){
    rethrow;
  }
}

  Future<User?> register (String email, String pass) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      return userCredential.user;
    }on FirebaseAuthException catch(e){
      rethrow;
    }
  }


  Future<bool> signOut () async{
    try{
      await _auth.signOut();
      return true;
    } on FirebaseAuthException catch(e){
      rethrow;
    }
  }

  User? getCurrentUser (){
  return _auth.currentUser;
  }
}