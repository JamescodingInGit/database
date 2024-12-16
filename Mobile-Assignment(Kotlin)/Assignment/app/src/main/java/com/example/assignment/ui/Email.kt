package com.example.assignment.ui

import android.os.Bundle
import android.text.method.HideReturnsTransformationMethod
import android.text.method.PasswordTransformationMethod
import android.util.Log
import android.util.Patterns
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import android.widget.ImageView
import androidx.fragment.app.activityViewModels
import androidx.navigation.fragment.findNavController
import androidx.room.util.copy
import com.example.assignment.R
import com.example.assignment.data.AuthVM
import com.example.assignment.data.User
import com.example.assignment.data.UserVM
import com.example.assignment.databinding.FragmentEmailBinding
import com.example.assignment.util.SimpleEmail
import com.example.assignment.util.errorDialog
import com.example.assignment.util.hideKeyboard
import com.example.assignment.util.snackbar

class Email : Fragment() {


    private lateinit var binding: FragmentEmailBinding
    private val nav by lazy { findNavController() }
    private val auth: AuthVM by activityViewModels()
    private val vm: UserVM by activityViewModels()
    private var verificationCode: String? = null
    private var verificationAttempts = 0


    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding =  FragmentEmailBinding.inflate(inflater, container, false)

        requireActivity().findViewById<View>(R.id.bv).visibility = View.GONE

        binding.EmailCode.requestFocus()
        binding.btnSend.setOnClickListener { send() }
        binding.btnVerify.setOnClickListener { verify() }
        binding.btnSubmitPassword.setOnClickListener { submitPassword() }

        binding.imgViewedtNewPassword.setOnClickListener { togglePasswordVisibility(binding.edtNewPassword, binding.imgViewedtNewPassword) }
        binding.imgViewedtConfirmPassword.setOnClickListener { togglePasswordVisibility(binding.edtConfirmPassword, binding.imgViewedtConfirmPassword) }

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

    private fun send() {
        hideKeyboard()

        val email = binding.EmailCode.text.toString().trim()
        if (!isEmail(email)) {
            errorDialog("Invalid email.");
            binding.EmailCode.requestFocus()
            return
        }
        sendVerificationCode(email)
    }
    private fun sendVerificationCode(email: String) {

        verificationCode  = "%04d".format((0..9999).random())

        val subject = "Reset Password Code - $verificationCode";
        val content = """
            <p>Your <b>Reset Password Code</b> is:</p>
            <h1 style="color: red">$verificationCode</h1>
            <p>Thank you.</p>
        """.trimIndent();

        // TODO(1): Send email
        SimpleEmail()
            .to(email)
            .subject(subject)
            .content(content)
            .isHtml()
            .send {
                snackbar("Email sent...")
                binding.btnSend.isEnabled = true
                binding.EmailCode.requestFocus()

                binding.lblVerify.visibility = View.VISIBLE
                binding.edtVerifyCode.visibility = View.VISIBLE
                binding.btnVerify.visibility = View.VISIBLE
                binding.EmailCode.isEnabled = false
                binding.btnSend.isEnabled = false
                binding.edtVerifyCode.requestFocus()
                verificationAttempts = 0
            }

        snackbar("Sending email...")
        binding.btnSend.isEnabled = false
    }

    private fun verify() {
        hideKeyboard()

        val enteredCode = binding.edtVerifyCode.text.toString().trim()
        if (enteredCode == verificationCode) {
            snackbar("Verification successful!")
            binding.lblVerify.visibility = View.GONE
            binding.edtVerifyCode.visibility = View.GONE
            binding.btnVerify.visibility = View.GONE

            // Show new password elements
            binding.lblNewPassword.visibility = View.VISIBLE
            binding.edtNewPassword.visibility = View.VISIBLE
            binding.lblConfirmNewPassword.visibility = View.VISIBLE
            binding.edtConfirmPassword.visibility = View.VISIBLE
            binding.imgViewedtNewPassword.visibility = View.VISIBLE
            binding.imgViewedtConfirmPassword.visibility = View.VISIBLE
            binding.btnSubmitPassword.visibility = View.VISIBLE

            val email = binding.EmailCode.text.toString().trim()
            Log.d("Verify", "Email retained for password update: $email")
        } else {
            // Increment the verification attempts counter
            verificationAttempts++

            if (verificationAttempts >= 3) {
                // If more than three attempts, allow the user to re-enter the email and send the code again
                // Reset the verification attempts counter
                verificationAttempts = 0

                // Clear the verification code field
                binding.edtVerifyCode.setText("")

                binding.lblVerify.visibility = View.GONE
                binding.edtVerifyCode.visibility = View.GONE
                binding.btnVerify.visibility = View.GONE

                // Enable the email field and send button
                binding.EmailCode.requestFocus()
                binding.EmailCode.isEnabled = true
                binding.btnSend.isEnabled = true

                // Display a message to the user indicating that they need to re-enter the email
                snackbar("Please re-enter your email and click 'Send' to receive a new verification code.")
            } else {
                errorDialog("Invalid verification code.")
                binding.edtVerifyCode.requestFocus()
            }
        }
    }

    private fun isEmail(email: String) = Patterns.EMAIL_ADDRESS.matcher(email).matches()

    private fun submitPassword() {
        hideKeyboard()

        val newPassword = binding.edtNewPassword.text.toString().trim()
        val confirmPassword = binding.edtConfirmPassword.text.toString().trim()
        val email = binding.EmailCode.text.toString().trim()

        if (email.isEmpty()) {
            errorDialog("Email field cannot be empty.")
            return
        }
        if (newPassword.isEmpty() || confirmPassword.isEmpty()) {
            errorDialog("Password fields cannot be empty.")
            return
        }
        if (newPassword.length < 6 || confirmPassword.length < 6) {
            errorDialog("Password too short (min 6 chars).")
            return
        }

        if (newPassword != confirmPassword) {
            errorDialog("Passwords do not match.")
            return
        }  else {
            Log.d("Email", "Email used for password update: $email") // Log the email
            vm.updatePassword(email, newPassword) { success, message ->
                if (success) {
                    snackbar(message)
                    nav.popBackStack()
                } else {
                    errorDialog(message)
                }
            }
        }
    }



}