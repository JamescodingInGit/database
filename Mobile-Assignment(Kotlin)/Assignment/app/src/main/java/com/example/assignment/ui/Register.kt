package com.example.assignment.ui

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.result.contract.ActivityResultContracts
import androidx.fragment.app.activityViewModels
import androidx.navigation.fragment.findNavController
import com.example.assignment.MainActivity
import com.example.assignment.R
import com.example.assignment.data.UserVM
import com.example.assignment.databinding.FragmentRegisterBinding
import com.example.assignment.data.User
import com.example.assignment.util.cropToBlob
import com.example.assignment.util.errorDialog
import com.example.assignment.util.infoDialog


class Register : Fragment() {

    private lateinit var binding: FragmentRegisterBinding
    private val nav by lazy { findNavController() }
    private val vm: UserVM by activityViewModels()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        // Inflate the layout for this fragment
        binding = FragmentRegisterBinding.inflate(inflater, container, false)
        reset()
        binding.imgPhoto.setOnClickListener { select() }
        binding.btnRegister.setOnClickListener { register() }


        return binding.root
    }

    private fun reset() {
        binding.edtEmail.text?.clear()
        binding.edtPassword.text?.clear()
        binding.edtName.text?.clear()
        binding.imgPhoto.setImageDrawable(null)
        binding.edtEmail.requestFocus()
    }

    private val getContent = registerForActivityResult(ActivityResultContracts.GetContent()) {
        binding.imgPhoto.setImageURI(it)
    }

    private fun select() {
        getContent.launch("image/*")
    }

    private fun register() {

        val value = binding.confirmedtPassword.text.toString()

        if (value.isEmpty()) {
            errorDialog("Confirm Password required.")

        } else if(binding.edtPassword.text.toString() != value) {
            errorDialog("Passwords do not match.")
            return
        }

        val user = User(
            email = binding.edtEmail.text.toString().trim(),
            password = binding.edtPassword.text.toString().trim(),
            name = binding.edtName.text.toString().trim(),
            photo = binding.imgPhoto.cropToBlob(300, 300)

        )

        val e = vm.validate(user)
         if (e != "") {
            errorDialog(e)
            return
        }

        vm.set(user)
        nav.navigateUp()
        infoDialog("Register Successful!\n" +
                "Please Login")
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



