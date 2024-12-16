package com.example.assignment.data

import android.content.ContentValues.TAG
import android.util.Log
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import androidx.lifecycle.ViewModel
import com.google.firebase.firestore.ListenerRegistration
import com.google.firebase.firestore.toObjects
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await


class UserVM : ViewModel() {

    private val usersLD = MutableLiveData<List<User>?>()
    private var listener: ListenerRegistration? = null


    init {
        // TODO: Add snapshot listener (real-time updates)
        listener = USERS.addSnapshotListener { v, _ ->
            usersLD.value = v?.toObjects()
        }
    }

    override fun onCleared() {
        listener?.remove()
    }

    // ---------------------------------------------------------------------------------------------

    fun init() = Unit

    fun getUsersLD() = usersLD

    fun getAll() = usersLD.value

    fun get(email: String) = usersLD.value?.find { it.email == email }

    fun getUserUpdate(email: String): MutableLiveData<List<User>?> {
        val filteredUpdatedUser = MutableLiveData<List<User>?>()

        usersLD.observeForever {
            val filteredUser = it
                ?.filter { it.email == email }
            filteredUpdatedUser.value = filteredUser
        }

        return filteredUpdatedUser
    }
    fun set(user: User) {
        USERS.document(user.email).set(user);
    }

    fun delete(email: String) {
        USERS.document(email).delete()
    }

    fun deleteAll() {
        usersLD.value?.forEach { USERS.document(it.email).delete() }
    }

    fun restore() {
        USERS.get().addOnSuccessListener {
            // (1) DELETE users
            it.documents.forEach { it.reference.delete() }
        }
    }

    // ---------------------------------------------------------------------------------------------

    fun updatePassword(email: String, newPassword: String, callback: (Boolean, String) -> Unit) {
        Log.d("UserVM", "Trying to update password for email: $email")
        val user = get(email)
        if (user != null) {
            user.password = newPassword
            try {
                USERS.document(email).set(user)
                callback(true, "Password updated successfully.Please try to login")
            } catch (e: Exception) {
                callback(false, "Failed to update password.")
            }
        } else {
            callback(false, "User not found.")
        }
    }



    private fun emailExists(email: String) = usersLD.value?.any { it.email == email } ?: false

    suspend fun doesUserExist(email: String): Boolean {
        return try {
            val snapshot = USERS.document(email).get().await()
            snapshot.exists()
        } catch (e: Exception) {
            Log.e(TAG, "Error checking if user exists: ${e.message}", e)
            false
        }
    }

    fun validate(user: User, insert: Boolean = true): String {
        val regexEmail = Regex("""^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$""")
        var e = ""

        if (insert) {
            e += if (user.email == "") "- Email required.\n"
            else if (!user.email.matches(regexEmail)) "- Email format invalid.\n"
            else if (user.email.length > 100) "- Email too long (max 100 chars).\n"
            else if (emailExists(user.email)) "- Email already exist.\n"
            else ""
        }

        e += if (user.password == "") "- Password required.\n"
        else if (user.password.length < 6) "- Password too short (min 6 chars).\n"
        else if (user.password.length > 20) "- Password too long (max 20 chars).\n"
        else ""

        e += if (user.name == "") "- Name required.\n"
        else if (user.name.length < 3) "- Name too short (min 3 chars).\n"
        else if (user.name.length > 15) "- Name too long (max 15 chars).\n"
        else ""

        e += if (user.photo.toBytes().isEmpty()) "- Photo required.\n"
        else ""

        return e
    }

}
