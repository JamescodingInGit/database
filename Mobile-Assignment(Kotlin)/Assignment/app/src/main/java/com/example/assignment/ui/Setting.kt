package com.example.assignment.ui

import android.app.AlertDialog
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.app.NotificationCompat
import androidx.fragment.app.activityViewModels
import androidx.navigation.fragment.findNavController
import com.example.assignment.R
import com.example.assignment.data.AuthVM
import com.example.assignment.data.User
import com.example.assignment.data.UserVM
import com.example.assignment.databinding.FragmentSettingBinding
import com.example.assignment.util.setImageBlob
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.messaging.FirebaseMessaging


class Setting : Fragment() {

    private lateinit var binding: FragmentSettingBinding
    private val nav by lazy { findNavController() }
    private val auth: AuthVM by activityViewModels()
    private val vm: UserVM by activityViewModels()


    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding = FragmentSettingBinding.inflate(inflater, container, false)

        requireActivity().findViewById<View>(R.id.bv).visibility = View.VISIBLE

        auth.getUserLD().observe(viewLifecycleOwner) { user ->
            // Log.d("User:", user.toString())
            if (user != null) {
                updateUI(user)
            } else {
                logoutState()
            }
        }

        val sharedPreferences = requireContext().getSharedPreferences("Settings", Context.MODE_PRIVATE)
        val isNotificationsEnabled = sharedPreferences.getBoolean("notifications_enabled", true)

        if(isNotificationsEnabled){
            binding.switchNotification.isChecked = true
        }else{
            binding.switchNotification.isChecked = false
        }

        binding.switchNotification.setOnCheckedChangeListener { _, isChecked ->
            sharedPreferences.edit().putBoolean("notifications_enabled", isChecked).apply()
            if (isChecked) {
                sendNotification(this.requireContext(), "Notification Enabled", "Notifications are enabled")
                getFCMToken()
            }else{
                disable()
            }
        }
        createNotificationChannel()

        binding.LayoutChangePsw.setOnClickListener { ToChangePassword() }
        binding.LayoutDltAccount.setOnClickListener { showDeleteAccountConfirmationDialog()}


        return binding.root
    }
    private fun updateUI(user: User) {

        binding.LayoutChangePsw.visibility = View.VISIBLE
        binding.LayoutDltAccount.visibility = View.VISIBLE
        binding.rltChangePsw.visibility = View.VISIBLE
        binding.rltDltAccount.visibility = View.VISIBLE

    }

    private fun logoutState() {
        binding.rltChangePsw.visibility = View.GONE
        binding.rltDltAccount.visibility = View.GONE
        binding.LayoutChangePsw.visibility = View.GONE
        binding.LayoutDltAccount.visibility = View.GONE
    }

    private fun createNotificationChannel() {
        val channel = NotificationChannel(
            "default",
            "Default Channel",
            NotificationManager.IMPORTANCE_DEFAULT
        ).apply {
            description = "Default Channel for app notifications"
        }
        val notificationManager = requireContext().getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.createNotificationChannel(channel)
    }

    private fun sendNotification(context: Context, title: String, message: String) {

        val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        val notification = NotificationCompat.Builder(context, "default")
            .setContentTitle(title)
            .setContentText(message)
            .setSmallIcon(android.R.drawable.ic_dialog_info)
            .build()

        notificationManager.notify(1, notification)
    }

    private fun ToChangePassword() {
        nav.navigate(R.id.changePasswordFragment)

    }

    private fun showDeleteAccountConfirmationDialog() {
        val builder = AlertDialog.Builder(requireContext())
        builder.setTitle("Delete Account")
        builder.setMessage("Are you sure you want to delete your account? This action cannot be undo.")
        builder.setPositiveButton("Yes") { _, _ ->
            DeleteAccount()
        }
        builder.setNegativeButton("No") { dialog, _ ->
            dialog.dismiss()
        }
        builder.show()
    }

    private fun DeleteAccount() {
        val u = auth.getUser()
        if (u != null) {
            vm.delete(u.email)
            nav.navigate(R.id.accountFragment)
        }
    }

    private fun disable(){
        FirebaseMessaging.getInstance().deleteToken()
            .addOnCompleteListener { task ->
                if (task.isSuccessful) {
                    var user: User? = auth.getUser()
                    if(user != null){
                        user.fcmToken = ""
                    }
                    user?.let { vm.set(it) }
                }
            }
    }

    private fun getFCMToken() {
        FirebaseMessaging.getInstance().token.addOnCompleteListener(OnCompleteListener { task ->
            if (task.isSuccessful) {
                val token = task.result
                if(auth.getUser() != null){
                    val user = auth.getUser()
                    if(user!= null){
                        user.fcmToken = token
                        vm.set(user)
                    }

                }
            }

        })
    }

}