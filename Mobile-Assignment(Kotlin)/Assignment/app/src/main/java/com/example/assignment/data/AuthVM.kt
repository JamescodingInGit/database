package com.example.assignment.data

import android.app.Application
import android.content.Context
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInOptions
import com.google.firebase.auth.FirebaseAuth
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.firestore.FieldPath
import com.google.firebase.firestore.ListenerRegistration
import com.google.firebase.firestore.toObject
import com.google.firebase.firestore.toObjects
import kotlinx.coroutines.tasks.await
import com.google.firebase.Timestamp
import com.google.firebase.messaging.FirebaseMessaging

class AuthVM (val app: Application) : AndroidViewModel(app) {

    private var listener: ListenerRegistration? = null
    private val userLD = MutableLiveData<User?>()
    init {
        userLD.value = null

    }

    // ---------------------------------------------------------------------------------------------

    fun init() = Unit
    fun setUser(user: User) {
        userLD.value = user
    }

    fun getUserLD() = userLD

    fun getUser() = userLD.value

    fun googleLogout() {
        FirebaseAuth.getInstance().signOut()

        // Sign out from Google Sign-In
        val googleSignInClient = GoogleSignIn.getClient(app, GoogleSignInOptions.DEFAULT_SIGN_IN)
        googleSignInClient.signOut()

        // Clear any session data or preferences if needed
        clearSessionData()
    }
    private fun clearSessionData() {
        // Clear any session data or preferences here
        // For example, you can clear SharedPreferences if you stored any user data
    }

    // Method to clear shared preferences
    private fun clearPreferences() {
        getPreferences().edit()
            .remove("email")
            .remove("password")
            .apply()
    }

    // TODO(1): Login
    suspend fun login(email: String, password: String, remember: Boolean = false) : Boolean {
        // TODO(1A): Get the user record with matching email + password
        //           Return false is no matching found
        val user = USERS
            .whereEqualTo(FieldPath.documentId(), email)
            .whereEqualTo("password", password)
            .get()
            .await()
            .toObjects<User>()
            .firstOrNull() ?: return false

        // TODO(1B): Setup snapshot listener
        //           Update live data -> user
        listener?.remove()
        listener = USERS.document(user.email).addSnapshotListener { snap, _->
            userLD.value = snap?.toObject()
        }

        // TODO(6A): Handle remember-me -> add shared preferences
        if (remember) {
            getPreferences()
                .edit()
                .putString("email", email)
                .putString("password", password)
                .apply()
        }

        updateUserStatus("online")
        return true
    }

    // TODO(2): Logout
    fun logout() {
        // TODO(2A): Remove snapshot listener
        //           Update live data -> null
        deleteToken()
        listener?.remove()
        userLD.value = null
        // TODO(6B): Handle remember-me -> clear shared preferences
        getPreferences()
            .edit()
            .remove("email")
            .remove("password")
            .apply()

        // [OR] getPreferences().edit().apply()
        // [OR] app.deleteSharedPreferences("AUTH")


    }

    // TODO(6): Get shared preferences
    private fun getPreferences() = app.getSharedPreferences("AUTH", Context.MODE_PRIVATE)

    // TODO(7): Auto login from shared preferences
    suspend fun loginFromPreferences() {
        val email = getPreferences().getString("email", null)
        val password = getPreferences().getString("password", null)

        if (email != null && password != null) {
            login(email, password)
        }
    }

     fun updateUserStatus(status: String) {
        val user = userLD.value
        if (user != null) {
            user.status = status
            if (status == "offline") {
                user.lastLoginTime = Timestamp.now()
            }
            USERS.document(user.email).set(user)
        }
    }

    private fun deleteToken(){
        FirebaseMessaging.getInstance().deleteToken().addOnCompleteListener(OnCompleteListener { task ->
            if (task.isSuccessful) {
                if(getUser() != null){
                    val user = getUser()
                    if(user != null){
                        user.fcmToken = ""
                        USERS.document(user.email).set(user)
                    }
                }
            }

        })
    }

}