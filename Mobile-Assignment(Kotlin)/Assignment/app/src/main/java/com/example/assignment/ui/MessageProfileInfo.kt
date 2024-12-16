package com.example.assignment.ui

import android.annotation.SuppressLint
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.activityViewModels
import androidx.navigation.fragment.findNavController
import com.example.assignment.R
import com.example.assignment.data.AuthVM
import com.example.assignment.data.ChatRoomVM
import com.example.assignment.data.UserVM
import com.example.assignment.databinding.FragmentMessageProfileInfoBinding
import com.example.assignment.databinding.FragmentProfileInfoBinding
import com.example.assignment.util.setImageBlob
import com.google.firebase.Timestamp
import java.text.SimpleDateFormat
import java.util.Locale

class MessageProfileInfo : Fragment() {

    private lateinit var binding: FragmentMessageProfileInfoBinding
    private val nav by lazy { findNavController() }
    private val users: UserVM by activityViewModels()
    private val userMail by lazy { arguments?.getString("userMail") ?: "" }
    private val chatRoomId by lazy { arguments?.getString("chatRoomId") ?: "" }
    private val chatRoomVM: ChatRoomVM by activityViewModels()

    @SuppressLint("SetTextI18n")
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding = FragmentMessageProfileInfoBinding.inflate(inflater, container, false)

        val user = users.get(userMail)
        chatRoomVM.get(chatRoomId)!!.user.email = userMail

            // Log.d("User:", user.toString())

        if (user != null) {
            binding.profileInfoPicture.setImageBlob(user.photo)
            binding.ProfileName.text = user.name
            binding.PfUsername.text = user.name
            binding.PfEmail.text = user.email

            if (user.gender == "") {
                binding.PfGender.text = "Please select your gender"
            } else {
                binding.PfGender.text = user.gender
            }

            if (user.age == 0) {
                binding.PfAge.text = "Please enter your age"
            } else {
                    binding.PfAge.text = user.age.toString()
            }

            if (user.birthday == Timestamp(0, 0)) {
                binding.PfBirthday.text = "Please select your birthday"
            } else {
                val dateFormat = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
                binding.PfBirthday.text = dateFormat.format(user.birthday.toDate())
            }

            if (user.mobile == "") {
                binding.PfMobile.text = "Please enter your mobile"
            } else {
                binding.PfMobile.text = user.mobile
            }


        }

        return binding.root

    }

}