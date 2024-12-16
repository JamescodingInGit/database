package com.example.assignment.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.SearchView
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.navigation.fragment.findNavController
import com.example.assignment.R
import com.example.assignment.data.AuthVM
import com.example.assignment.data.ChatRoom
import com.example.assignment.data.ChatRoomVM
import com.example.assignment.data.User
import com.example.assignment.data.UserVM
import com.example.assignment.databinding.FragmentMessageBinding
import com.example.assignment.util.ChatRoomAdapter
import com.example.assignment.util.OnlineUserAdapter

class Message : Fragment() {

    private lateinit var binding: FragmentMessageBinding
    private val nav by lazy { findNavController() }
    private val chatRoomVM: ChatRoomVM by activityViewModels()
    private val auth: AuthVM by activityViewModels()
    private val userVM: UserVM by activityViewModels()
    private val email by lazy { auth.getUserLD().value!!.email }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {

        binding = FragmentMessageBinding.inflate(inflater, container, false)

        val roomAdapter =  ChatRoomAdapter { h, f ->
            h.binding.root.setOnClickListener { chat(f.chatRoomId,f.user.fcmToken, f.user.email) }
        }

        val onlineAdapter =  OnlineUserAdapter { h, f ->
            h.binding.root.setOnClickListener { chat(f.chatRoomId,f.user.fcmToken, f.user.email) }
        }

        binding.msgRV.adapter = roomAdapter
        chatRoomVM.getAllByEmail(email).observe(viewLifecycleOwner) {
            it.forEach { it.user = getOtherUser(it.userId) }
            if(it.size==0) binding.txtNoChat.visibility = View.VISIBLE
            else binding.txtNoChat.visibility = View.GONE
            roomAdapter.submitList(it)
        }

        binding.msgOnlineUserRV.adapter = onlineAdapter
        chatRoomVM.getAllByEmail(email).observe(viewLifecycleOwner) {
            val onlineChat: MutableList<ChatRoom> = mutableListOf()
            var count: Int = 0
            it.forEach {
                it.user = getOtherUser(it.userId)
                if(it.user.status == "online"){
                    onlineChat.add(it)
                    count++
                }

            }
            if(count == 0) binding.txtNoOnline.visibility = View.VISIBLE
            else binding.txtNoChat.visibility = View.GONE
            onlineAdapter.submitList(onlineChat)
        }

        userVM.getUsersLD().observe(viewLifecycleOwner){
            val onlineChat: MutableList<ChatRoom> = mutableListOf()
            var count: Int = 0
            chatRoomVM.getAllByEmail(email).observe(viewLifecycleOwner) {
                it.forEach {
                    it.user = getOtherUser(it.userId)
                    if(it.user.status == "online"){
                        onlineChat.add(it)
                        count++
                    }
                }
                if(count == 0) binding.txtNoOnline.visibility = View.VISIBLE
                else binding.txtNoChat.visibility = View.GONE
            }
            onlineAdapter.submitList(onlineChat)
        }

        binding.searchMsg.setOnQueryTextListener(object : SearchView.OnQueryTextListener{
            override fun onQueryTextSubmit(name: String) = true
            override fun onQueryTextChange(name: String): Boolean {
                chatRoomVM.search(name)
                return true
            }

        })

        binding.swipeRefreshChat.setOnRefreshListener {
            // Refresh both RecyclerViews
            refreshData()
        }
        // -----------------------------------------------------------------------------------------
        return binding.root
    }

    private fun refreshData() {
        binding.msgOnlineUserRV.adapter?.notifyDataSetChanged()
        binding.msgRV.adapter?.notifyDataSetChanged()
        binding.swipeRefreshChat.isRefreshing = false
    }

    private fun chat(chatRoomId: String, token: String, userChat: String) {
        nav.navigate(R.id.messageChatFragment, bundleOf(
            "chatRoomId" to chatRoomId,
            "token" to token,
            "userMail" to userChat
        )
        )
    }

    private fun getOtherUser(userId: List<String>): User{
        var user = User()
        userId.forEach{
            if(it != email){
                user = userVM.get(it)!!
                return user
            }
        }
        return user
    }

}