package com.example.assignment.ui

import android.app.AlertDialog
import android.app.DatePickerDialog
import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.DatePicker
import androidx.fragment.app.activityViewModels
import androidx.navigation.fragment.findNavController
import com.example.assignment.R
import com.example.assignment.data.AuthVM
import com.example.assignment.data.User
import com.example.assignment.data.UserVM
import com.example.assignment.databinding.FragmentEditProfileBinding
import com.example.assignment.util.errorDialog
import com.example.assignment.util.infoDialog
import com.google.firebase.Timestamp
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale

class EditProfile : Fragment(), DatePickerDialog.OnDateSetListener {

    private lateinit var binding: FragmentEditProfileBinding
    private val nav by lazy { findNavController() }
    private val auth: AuthVM by activityViewModels()
    private val vm: UserVM by activityViewModels()

    val dateFormat = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding = FragmentEditProfileBinding.inflate(inflater, container, false)
        requireActivity().findViewById<View>(R.id.bv).visibility = View.GONE

        binding.buttonSave.setOnClickListener { savebutton() }

        binding.btnDatePicker.setOnClickListener {
            val calendar = Calendar.getInstance()
            val year = calendar.get(Calendar.YEAR)
            val month = calendar.get(Calendar.MONTH)
            val dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH)

            val datePickerDialog = DatePickerDialog(requireContext(), this, year, month, dayOfMonth)
            datePickerDialog.datePicker.maxDate = System.currentTimeMillis()
            datePickerDialog.show()
        }

        auth.getUserLD().observe(viewLifecycleOwner) { user ->

            if (user != null) {

                binding.editTextEmail.setText(user.email)

                if (user.name == ""){
                    binding.editTextName.setHint("Please enter your username")
                } else {
                    binding.editTextName.setText(user.name)
                }

                if (user.gender == "") {
                    binding.lblgender.setText("Please select your gender")
                } else {
                    //binding.editTextGender.setText(user.gender)
                    when (user.gender) {
                        "Male" -> binding.radioGroupGender.check(R.id.radioMale)
                        "Female" -> binding.radioGroupGender.check(R.id.radioFemale)
                    }
                }

                if (user.age == 0) {
                    binding.editTextAge.setHint("Please enter your age")
                } else {
                    binding.editTextAge.setText(user.age.toString())
                }

                if (user.birthday == Timestamp(0, 0)) {
                    binding.lblselectdate.setHint("Please select your birthday")
                } else {
                    binding.editTextBirthday.setText(dateFormat.format(user.birthday.toDate()))
                }

                if(user.mobile == "") {
                    binding.editTextMobile.setHint("Please enter your mobile")
                } else {
                    binding.editTextMobile.setText(user.mobile)
                }
            }
        }

        return binding.root
    }


    private  fun savebutton() {
        val username = binding.editTextName.text.toString().trim()
        if (username.isEmpty()) {
            errorDialog("Username cannot be empty")
            return
        }
        if (username.length > 15) {
            errorDialog("Username length cannot more than 15")
            return
        }

        val selectedGender = when (binding.radioGroupGender.checkedRadioButtonId) {
            R.id.radioMale -> "Male"
            R.id.radioFemale -> "Female"
            else -> ""
        }

        val pickbirthday = binding.editTextBirthday.text.toString().trim()
        val birthdayTimestamp = if (pickbirthday.isNotEmpty()) {
            val date = dateFormat.parse(pickbirthday)
            Timestamp(date)
        } else {
            Timestamp(0, 0)
        }

        val ageNumber = binding.editTextAge.text.toString().trim()
        val age = if (ageNumber.isEmpty()) {
            0 // Default value if age is empty
        } else {
            ageNumber.toIntOrNull().takeIf { it in 1..120 } ?: run {
                errorDialog("Please enter a valid age between 1 and 120")
                return
            }
        }

        val phoneNumber = binding.editTextMobile.text.toString().trim()
        if (phoneNumber.isNotEmpty() && !isValidPhoneNumber(phoneNumber)) {
            errorDialog("Invalid phone number!")
            return
        }

        // Confirm to save
        val confirmDialog = AlertDialog.Builder(requireContext())
            .setTitle("Confirm Save")
            .setMessage("Are you sure you want to save changes?")
            .setPositiveButton("Yes") { _, _ ->

                val u = auth.getUserLD().value?.let {
                    User(
                        photo = it.photo,
                        password = it.password,
                        name = username,
                        email = binding.editTextEmail.text.toString().trim(),
                        gender = selectedGender,
                        age = age,
                        birthday = birthdayTimestamp,
                        mobile = binding.editTextMobile.text.toString().trim()

                    )

                }
                if (u != null) {
                    vm.set(u)
                    auth.setUser(u)
                }
                nav.navigateUp()
            }
            .setNegativeButton("Cancel", null)
            .create()

        confirmDialog.show()
    }

    override fun onDateSet(view: DatePicker?, year: Int, month: Int, dayOfMonth: Int) {
        val calendar = Calendar.getInstance()
        calendar.set(Calendar.YEAR, year)
        calendar.set(Calendar.MONTH, month)
        calendar.set(Calendar.DAY_OF_MONTH, dayOfMonth)

        val selectedDate = dateFormat.format(calendar.time)
        binding.editTextBirthday.setText(selectedDate)
    }

    private fun isValidPhoneNumber(phoneNumber: String): Boolean {
        val PhoneRegex = Regex("^\\+?\\d{3}-\\d{7,8}\$")
        return PhoneRegex.matches(phoneNumber)
    }


}