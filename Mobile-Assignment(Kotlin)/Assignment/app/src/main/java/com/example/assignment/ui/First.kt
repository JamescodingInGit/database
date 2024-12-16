package com.example.assignment.ui

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import androidx.core.os.bundleOf
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.example.assignment.MainActivity
import com.example.assignment.R
import com.example.assignment.data.AuthVM
import com.example.assignment.databinding.FragmentFirstBinding
import com.example.assignment.databinding.FragmentMessageChatBinding
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class First : Fragment() {

    private lateinit var binding: FragmentFirstBinding
    private val nav by lazy { findNavController() }
    private val auth: AuthVM by activityViewModels()

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {

        binding = FragmentFirstBinding.inflate(inflater, container, false)

        binding.btnLogin.setOnClickListener {
            nav.navigate(R.id.loginFragment)
        }

        return binding.root
    }

    override fun onStart() {
        super.onStart()
        lifecycleScope.launch {
            waitForUser()
            if(auth.getUser() != null){
                nav.navigate(R.id.homeFragment)
            }
        }
    }

    override fun onResume() {
        super.onResume();
        val mainActivity = requireActivity() as MainActivity
        (activity as AppCompatActivity?)!!.supportActionBar!!.hide()
        mainActivity.hideBV()
    }
    override fun onStop() {
        super.onStop();
        val mainActivity = requireActivity() as MainActivity
        (activity as AppCompatActivity?)!!.supportActionBar!!.show()
        mainActivity.showBV()
    }
    private suspend fun waitForUser() {
        while (auth.getUser() == null) {
            delay(40)
        }
    }
}