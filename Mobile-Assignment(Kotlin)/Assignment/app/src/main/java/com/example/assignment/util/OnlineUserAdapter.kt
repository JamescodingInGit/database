package com.example.assignment.util

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.assignment.data.ChatRoom
import com.example.assignment.databinding.ItemOnlineuserBinding

class OnlineUserAdapter(
    val fn: (ViewHolder, ChatRoom) -> Unit = { _, _ -> }
) : ListAdapter<ChatRoom, OnlineUserAdapter.ViewHolder>(Diff){

    companion object Diff : DiffUtil.ItemCallback<ChatRoom>() {
        override fun areItemsTheSame(a: ChatRoom, b: ChatRoom) = a.chatRoomId == b.chatRoomId
        override fun areContentsTheSame(a: ChatRoom, b: ChatRoom) = a == b
    }

    class ViewHolder(val binding: ItemOnlineuserBinding) : RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =
        ViewHolder(ItemOnlineuserBinding.inflate(LayoutInflater.from(parent.context), parent, false))

    override fun onBindViewHolder(holder: OnlineUserAdapter.ViewHolder, position: Int) {
        val chatRoom = getItem(position)

        holder.binding.imgMsgUser.setImageBlob(chatRoom.user.photo)
        holder.binding.txtName.text = chatRoom.user.name

        fn(holder, chatRoom)
    }
}