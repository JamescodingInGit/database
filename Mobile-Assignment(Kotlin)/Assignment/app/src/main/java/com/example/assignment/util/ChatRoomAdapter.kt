package com.example.assignment.util

import android.graphics.Typeface
import android.util.Log
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.assignment.data.ChatRoom
import com.example.assignment.databinding.ItemUsermessageBinding
import com.google.firebase.Timestamp
import java.text.SimpleDateFormat
import java.util.Locale

class ChatRoomAdapter (
    val fn: (ViewHolder, ChatRoom) -> Unit = { _, _ -> }
) :ListAdapter<ChatRoom, ChatRoomAdapter.ViewHolder>(Diff){

    companion object Diff : DiffUtil.ItemCallback<ChatRoom>() {
        override fun areItemsTheSame(a: ChatRoom, b: ChatRoom) = a.chatRoomId == b.chatRoomId
        override fun areContentsTheSame(a: ChatRoom, b: ChatRoom) = a == b
    }
    class ViewHolder(val binding: ItemUsermessageBinding) : RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =
        ViewHolder(ItemUsermessageBinding.inflate(LayoutInflater.from(parent.context), parent, false))

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val chatRoom = getItem(position)
        val dateFormat = SimpleDateFormat("yyyy/MM/dd", Locale.getDefault())
        val timeFormat = SimpleDateFormat("hh:mm a", Locale.getDefault())

        if(dateFormat.format(chatRoom.lastMessageTime.toDate()) == dateFormat.format(Timestamp.now().toDate())){
            holder.binding.msgTime.text = timeFormat.format(chatRoom.lastMessageTime.toDate())
        }
        else{
            holder.binding.msgTime.text = dateFormat.format(chatRoom.lastMessageTime.toDate())
        }
        if(chatRoom.isRead == false){
            holder.binding.txtNewMsg.setTypeface(holder.binding.txtNewMsg.typeface, Typeface.BOLD)
            holder.binding.imgChatRead.isSelected = false
        }else{
            holder.binding.imgChatRead.isSelected = true
        }
        holder.binding.txtMsgUserName.text = chatRoom.user.name
        holder.binding.imgMsgUser.setImageBlob(chatRoom.user.photo)
        holder.binding.txtNewMsg.text = chatRoom.lastMessage

        fn(holder, chatRoom)
    }

}