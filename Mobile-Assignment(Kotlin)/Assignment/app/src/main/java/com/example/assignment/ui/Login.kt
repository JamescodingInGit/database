package com.example.assignment.ui

import android.content.ContentValues.TAG
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.example.assignment.MainActivity
import com.example.assignment.R
import com.example.assignment.databinding.FragmentLoginBinding
import com.example.assignment.data.AuthVM
import com.example.assignment.data.User
import com.example.assignment.data.UserVM
import com.example.assignment.util.errorDialog
import com.example.assignment.util.toast
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInClient
import com.google.android.gms.auth.api.signin.GoogleSignInOptions
import com.google.android.gms.common.api.ApiException
import com.google.firebase.Firebase
import com.google.firebase.Timestamp
import com.google.firebase.auth.GoogleAuthProvider
import kotlinx.coroutines.launch
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.auth
import com.google.firebase.firestore.Blob
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.ByteArrayOutputStream
import java.io.InputStream
import java.net.HttpURLConnection
import java.net.URL

class Login : Fragment() {

    private lateinit var binding: FragmentLoginBinding
    private val nav by lazy { findNavController() }
    private val auth: AuthVM by activityViewModels()
    private val vm: UserVM by activityViewModels()
    private lateinit var mGoogleSignInClient: GoogleSignInClient
    private lateinit var mauth: FirebaseAuth
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?

    ): View? {
        // Inflate the layout for this fragment
        binding = FragmentLoginBinding.inflate(inflater, container, false)

        mauth = Firebase.auth
        setupGoogleSignIn()

        reset()
        binding.btnLogin.setOnClickListener { login() }
        binding.goRegister.setOnClickListener { signup() }
        binding.googleSignIn.setOnClickListener { signIn() }
        binding.lblForgetPassword.setOnClickListener { forgetPsw() }


        return binding.root
    }

    private fun reset() {
        binding.edtEmail.text?.clear()
        binding.edtPassword.text?.clear()
        binding.chkRemember.isChecked = false
        binding.edtEmail.requestFocus()
    }

    private fun signup() {
        nav.navigate(R.id.registerFragment)
    }

    private fun forgetPsw() {
        nav.navigate(R.id.emailFragement)
    }

    private fun login() {

        if (binding.edtEmail.text.toString().isEmpty()){
            errorDialog("Email required")
            return
        } else if(binding.edtPassword.text.toString().isEmpty()){
            errorDialog("Password required")
            return
        }

        val email    = binding.edtEmail.text.toString().trim()
        val password = binding.edtPassword.text.toString().trim()
        val remember = binding.chkRemember.isChecked

        lifecycleScope.launch {
            val success = auth.login(email, password, remember)
            if (success) {
               nav.navigate(R.id.homeFragment)

            } else {
                errorDialog("Invalid Login credentials.")
            }
        }

    }


    private fun signIn() {
        val signInIntent = mGoogleSignInClient.signInIntent
        startActivityForResult(signInIntent, RC_SIGN_IN)


    }

    private fun firebaseAuthWithGoogle(idToken: String) {
        val credential = GoogleAuthProvider.getCredential(idToken, null)
        mauth.signInWithCredential(credential)
            .addOnCompleteListener(requireActivity()) { task ->
                if (task.isSuccessful) {
                    Log.d(TAG, "signInWithCredential:success")

                    val googleAccount = GoogleSignIn.getLastSignedInAccount(requireContext())
                    val displayName = googleAccount?.displayName
                    val googleEmail = googleAccount?.email
                    val photoUrl = googleAccount?.photoUrl?.toString()

                    if (googleEmail != null) {
                        lifecycleScope.launch {
                            val userExists = vm.doesUserExist(googleEmail)
                            if (userExists) {
                                val user = vm.get(googleEmail)
                                if (user != null) {
                                    auth.setUser(user)
                                }
                                nav.navigate(R.id.accountFragment)
                                toast("Login Success")
                            } else {
                                val blob = urlToBlob(photoUrl)
                                val newUser = User(
                                    email = googleEmail,
                                    name = displayName ?: "",
                                    photo = Blob.fromBytes(blob ?: ByteArray(0)),
                                    password = "",
                                    gender = "",
                                    age = 0,
                                    mobile = "",
                                    birthday = Timestamp(0, 0)
                                )

                                vm.set(newUser)

                                // Also update user data in AuthVM
                                auth.setUser(newUser)

                                nav.navigate(R.id.homeFragment)
                                toast("Login Successful")
                            }
                        }


                    } else {
                        Log.w(TAG, "signInWithCredential:failure", task.exception)
                        toast("Authentication failed")
                    }
                }
            }
    }


    @Deprecated("Deprecated in Java")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == RC_SIGN_IN) {
            val task = GoogleSignIn.getSignedInAccountFromIntent(data)
            try {
                val account = task.getResult(ApiException::class.java)
                firebaseAuthWithGoogle(account.idToken!!)
            } catch (e: ApiException) {
                toast("Google sign in failed")
                Log.e(TAG, "Google sign in failed: ${e.message}", e)
            }
        }
    }
    private fun setupGoogleSignIn() {
        val gso = GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
            .requestIdToken(getString(R.string.server_client_id))
            .requestEmail()
            .build()
        mGoogleSignInClient = GoogleSignIn.getClient(requireActivity(), gso)
    }

    private suspend fun urlToBlob(photoUrl: String?): ByteArray? {
        return withContext(Dispatchers.IO) {
            try {
                photoUrl?.let {
                    val url = URL(it)
                    val connection: HttpURLConnection = url.openConnection() as HttpURLConnection
                    connection.doInput = true
                    connection.connect()
                    val inputStream: InputStream = connection.inputStream
                    val bitmap: Bitmap = BitmapFactory.decodeStream(inputStream)
                    val outputStream = ByteArrayOutputStream()
                    bitmap.compress(Bitmap.CompressFormat.JPEG, 100, outputStream)
                    outputStream.toByteArray()
                }
            } catch (e: Exception) {
                Log.e("URLToBlob", "Error converting URL to Blob: ${e.message}", e)
                null
            }
        }
    }

    companion object {
        private const val TAG = "LoginFragment"
        private const val RC_SIGN_IN = 5619685
    }

    override fun onResume() {
        super.onResume();
        val mainActivity = requireActivity() as MainActivity
        mainActivity.hideBV()
    }

    override fun onStop() {
        super.onStop();
        val mainActivity = requireActivity() as MainActivity
        mainActivity.showBV()
    }

}

