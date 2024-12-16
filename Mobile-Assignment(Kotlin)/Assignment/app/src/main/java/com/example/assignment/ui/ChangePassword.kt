package com.example.assignment.ui

import android.os.Bundle
import android.text.method.HideReturnsTransformationMethod
import android.text.method.PasswordTransformationMethod
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import android.widget.ImageView
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.example.assignment.R
import com.example.assignment.data.AuthVM
import com.example.assignment.data.User
import com.example.assignment.data.UserVM
import com.example.assignment.databinding.FragmentChangePasswordBinding
import com.example.assignment.util.errorDialog
import com.example.assignment.util.toast
import kotlinx.coroutines.launch

class ChangePassword : Fragment() {

    private lateinit var binding: FragmentChangePasswordBinding
    private val auth: AuthVM by activityViewModels()
    private val vm: UserVM by activityViewModels()
    private val nav by lazy { findNavController() }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding = FragmentChangePasswordBinding.inflate(inflater, container, false)
        requireActivity().findViewById<View>(R.id.bv).visibility = View.GONE

        binding.btnVerifyCurrentPsw.setOnClickListener { verifyCurrentPassword() }
        binding.btnConfirm.setOnClickListener { confirmNewPassword() }

        binding.imgViewChangeNewPsw.setOnClickListener { togglePasswordVisibility(binding.edtChangeNewPsw, binding.imgViewChangeNewPsw) }
        binding.imgViewConfirmChangeNewPsw.setOnClickListener { togglePasswordVisibility(binding.edtConfirmChangeNewPsw, binding.imgViewConfirmChangeNewPsw) }

        return binding.root
    }

    private fun togglePasswordVisibility(editText: EditText, imageView: ImageView) {
        if (editText.transformationMethod == PasswordTransformationMethod.getInstance()) {
            // Show Password
            editText.transformationMethod = HideReturnsTransformationMethod.getInstance()
            imageView.setImageResource(R.drawable.ic_visibility_off) // Change icon to indicate password is visible
        } else {
            // Hide Password
            editText.transformationMethod = PasswordTransformationMethod.getInstance()
            imageView.setImageResource(R.drawable.ic_visibility_on) // Change icon to indicate password is hidden
        }
        // Move cursor to the end of the text
        editText.setSelection(editText.text.length)
    }


    private fun verifyCurrentPassword() {
        val currentPsw = binding.edtCurrentPsw.text.toString().trim()

        if (currentPsw.isEmpty()) {
            errorDialog("Current Password cannot be empty.")
            return
        }

        auth.getUserLD().observe(viewLifecycleOwner) { user ->
            if (user != null) {
                if (user.password == currentPsw) {
                    // Current password is correct
                    binding.lblChangeNewPsw.visibility = View.VISIBLE
                    binding.edtChangeNewPsw.visibility = View.VISIBLE
                    binding.lblConfirmChangeNewPsw.visibility = View.VISIBLE
                    binding.edtConfirmChangeNewPsw.visibility = View.VISIBLE
                    binding.imgViewChangeNewPsw.visibility = View.VISIBLE
                    binding.imgViewConfirmChangeNewPsw.visibility = View.VISIBLE
                    binding.btnConfirm.visibility = View.VISIBLE
                    binding.edtChangeNewPsw.requestFocus()
                    binding.edtCurrentPsw.isEnabled = false
                    binding.btnVerifyCurrentPsw.isEnabled = false
                } else {
                    errorDialog("Current Password is incorrect.")
                }
            }
        }
    }

    private fun confirmNewPassword() {
        val newPsw = binding.edtChangeNewPsw.text.toString().trim()
        val confirmPsw = binding.edtConfirmChangeNewPsw.text.toString().trim()

        if (newPsw.isEmpty() || confirmPsw.isEmpty()) {
            errorDialog("Password fields cannot be empty.")
            return
        }

        if (newPsw.length < 6 || confirmPsw.length < 6) {
            errorDialog("Password too short (min 6 chars).")
            return
        }

        if (newPsw != confirmPsw) {
            errorDialog("New Password and Confirm Password do not match.")
            return
        }


        auth.getUserLD().observe(viewLifecycleOwner) { user ->
            if (user != null) {
                if (user.password == newPsw) {
                    errorDialog("New Password cannot be the same as the current password.")
                } else {
                    val updatedUser = user.copy(password = newPsw)
                    lifecycleScope.launch {
                        vm.set(updatedUser)
                        toast("Password changed successfully!")
                        nav.navigateUp()
                        nav.popBackStack(R.id.accountFragment, false)
                    }
                }
            }
        }
    }
}
