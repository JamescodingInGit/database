package com.example.assignment.ui

import android.app.AlertDialog
import android.content.Context
import android.graphics.BitmapFactory
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatDelegate
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.navigation.fragment.findNavController
import com.example.assignment.R
import com.example.assignment.data.AuthVM
import com.example.assignment.data.User
import com.example.assignment.data.UserVM
import com.example.assignment.databinding.FragmentAccountBinding
import com.example.assignment.util.cropToBlob
import com.example.assignment.util.infoDialog
import com.example.assignment.util.setImageBlob
import com.example.assignment.util.toast
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.GoogleAuthProvider


@Suppress("DEPRECATION")
class Account : Fragment() {

    private lateinit var binding: FragmentAccountBinding
    private val nav by lazy { findNavController() }
    private val auth: AuthVM by activityViewModels()
    private val vm: UserVM by activityViewModels()
    private lateinit var mauth: FirebaseAuth

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?

    ): View? {
        // Inflate the layout for this fragment
        binding = FragmentAccountBinding.inflate(inflater, container, false)

        requireActivity().findViewById<View>(R.id.bv).visibility = View.VISIBLE

        binding.LayoutProfileInfo.setOnClickListener { ToProfile() }

        binding.LayoutHelpCentre.setOnClickListener { ToHelpCentre() }

        binding.LayoutSetting.setOnClickListener { ToSetting() }

        binding.LayoutLogin.setOnClickListener { ToLogin() }

        binding.LayoutLogout.setOnClickListener { ToLogout() }

        binding.btnChangePicture.setOnClickListener { select() }

        // Nightmode
        val sharedPreferences = requireContext().getSharedPreferences("Mode", Context.MODE_PRIVATE)
        val editor = sharedPreferences.edit()
        val nightMode = sharedPreferences.getBoolean("night", false)
        binding.switchNight.isChecked = nightMode
        binding.switchNight.setOnCheckedChangeListener { _, isChecked ->
            if (isChecked) {
                AppCompatDelegate.setDefaultNightMode(AppCompatDelegate.MODE_NIGHT_YES)
                editor.putBoolean("night", true).apply()
            } else {
                AppCompatDelegate.setDefaultNightMode(AppCompatDelegate.MODE_NIGHT_NO)
                editor.putBoolean("night", false).apply()
            }
        }

        auth.getUserLD().observe(viewLifecycleOwner) { user ->
           // Log.d("User:", user.toString())

            if (user != null) {
                updateUI(user)
            } else {
                logoutState()
            }
        }
            return binding.root
        }

    private fun updateUI(user: User) {
        binding.LblUsername.text = user.name
        binding.profilePicture.setImageBlob(user.photo)
        binding.relativeProfileInfo.visibility = View.VISIBLE
        binding.LayoutProfileInfo.visibility = View.VISIBLE
        binding.relativeLogin.visibility = View.GONE
        binding.LayoutLogin.visibility = View.GONE
        binding.relativeLogout.visibility = View.VISIBLE
        binding.LayoutLogout.visibility = View.VISIBLE
        binding.changephotolayout.visibility = View.VISIBLE
    }
    private fun logoutState() {
        nav.popBackStack(R.id.accountFragment, false)
        binding.LblUsername.text = "GUEST"
        setDefaultProfliePicture()
        binding.relativeProfileInfo.visibility = View.GONE
        binding.LayoutProfileInfo.visibility = View.GONE
        binding.relativeLogout.visibility = View.GONE
        binding.LayoutLogout.visibility = View.GONE
        binding.relativeLogin.visibility = View.VISIBLE
        binding.LayoutLogin.visibility = View.VISIBLE
        binding.changephotolayout.visibility = View.GONE
    }
    private fun ToProfile() {
        nav.navigate(R.id.profileInfoFragment)
    }
    private fun ToSetting() {
        nav.navigate(R.id.settingFragment)
    }
    private fun ToHelpCentre() {
        nav.navigate(R.id.helpCentreFragment)
    }
    private fun ToLogin() {
        nav.navigate(R.id.loginFragment)
    }
    private fun ToLogout(): Boolean {
        auth.updateUserStatus("offline")

        val confirmDialog = AlertDialog.Builder(requireContext())
            .setTitle("Confirm Logout")
            .setMessage("Are you sure you want to log out?")
            .setPositiveButton("Yes") { _, _ ->
                auth.logout()
                auth.googleLogout()
                infoDialog("LogOut Successful!")
                nav.popBackStack(R.id.accountFragment, false)

        auth.logout()
        auth.googleLogout()
        infoDialog("LogOut Successful!")
        nav.navigate(R.id.firstFragment)

            }
            .setNegativeButton("Cancel", null)
            .create()
        confirmDialog.show()
        return true
    }


    private fun setDefaultProfliePicture() {
        val bitmap = BitmapFactory.decodeResource(resources, R.drawable.profile)
        binding.profilePicture.setImageBitmap(bitmap)
    }

    private val getContent = registerForActivityResult(ActivityResultContracts.GetContent()) {
        binding.profilePicture.setImageURI(it)
        changePhoto()

    }
    private fun select() {
        getContent.launch("image/*")
    }
    private fun changePhoto() {

        val user = auth.getUserLD().value?.let {
            User(
                photo = binding.profilePicture.cropToBlob(300, 300),
                password = it.password,
                name = it.name,
                email = it.email,
                gender = it.gender,
                age = it.age,
                birthday = it.birthday,
                mobile = it.mobile
            )
        }
        if (user != null) {
            vm.set(user)
            auth.setUser(user)
        }
    }

}




