package com.example.assignment.util

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.assignment.data.Chat
import com.example.assignment.databinding.ItemMessagedateBinding
import com.example.assignment.databinding.ItemReceiverimageBinding
import com.example.assignment.databinding.ItemReceivermessageBinding
import com.example.assignment.databinding.ItemSenderimageBinding
import com.example.assignment.databinding.ItemSendermessageBinding
import java.text.SimpleDateFormat
import java.util.Locale

class ChatAdapter(
    val fn: (RecyclerView.ViewHolder, Chat) -> Unit = { _, _ -> }
) : ListAdapter<Chat, RecyclerView.ViewHolder>(Diff) {

    companion object Diff : DiffUtil.ItemCallback<Chat>() {
        override fun areItemsTheSame(a: Chat, b: Chat): Boolean = a.chatId == b.chatId
        override fun areContentsTheSame(a: Chat, b: Chat): Boolean = a == b
    }

    class LeftViewHolder(val binding: ItemReceivermessageBinding) : RecyclerView.ViewHolder(binding.root)
    class RightViewHolder(val binding: ItemSendermessageBinding) : RecyclerView.ViewHolder(binding.root)
    class LeftImageViewHolder(val binding: ItemReceiverimageBinding) : RecyclerView.ViewHolder(binding.root)
    class RightImageViewHolder(val binding: ItemSenderimageBinding) : RecyclerView.ViewHolder(binding.root)
    class DateViewHolder(val binding: ItemMessagedateBinding) : RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        return when (viewType) {
            1 -> {
                val binding = ItemReceivermessageBinding.inflate(inflater, parent, false)
                LeftViewHolder(binding)
            }
            2 -> {
                val binding = ItemSendermessageBinding.inflate(inflater, parent, false)
                RightViewHolder(binding)
            }
            3 -> {
                val binding = ItemReceiverimageBinding.inflate(inflater, parent, false)
                LeftImageViewHolder(binding)
            }
            4 -> {
                val binding = ItemSenderimageBinding.inflate(inflater, parent, false)
                RightImageViewHolder(binding)
            }
            else -> {
                val binding = ItemMessagedateBinding.inflate(inflater, parent, false)
                DateViewHolder(binding)
            }
        }
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        val chatRoom = getItem(position)
        val dateFormat = SimpleDateFormat("yyyy - MM - dd", Locale.getDefault())
        val timeFormat = SimpleDateFormat("hh:mm a", Locale.getDefault())
        when (holder) {
            is RightViewHolder -> {
                holder.binding.txtSendMsg.text = chatRoom.message
                holder.binding.txtMsgTime.text = timeFormat.format(chatRoom.messageTime.toDate())
                if(chatRoom.isRead){
                    holder.binding.imgReadStatus.isSelected = true
                }else{
                    holder.binding.imgReadStatus.isSelected = false
                }
            }
            is RightImageViewHolder -> {
                holder.binding.imgSend.setImageBlob(chatRoom.image)
                holder.binding.txtMsgTime.text = timeFormat.format(chatRoom.messageTime.toDate())
                if(chatRoom.isRead){
                    holder.binding.imgReadStatus.isSelected = true
                }else{
                    holder.binding.imgReadStatus.isSelected = false
                }
            }
            is LeftImageViewHolder -> {
                holder.binding.imgMsgUser.setImageBlob(chatRoom.user.photo)
                holder.binding.imgSend.setImageBlob(chatRoom.image)
                holder.binding.txtMsgTime.text = timeFormat.format(chatRoom.messageTime.toDate())
            }
            is LeftViewHolder -> {
                holder.binding.imgMsgUser.setImageBlob(chatRoom.user.photo)
                holder.binding.txtReceiveMsg.text = chatRoom.message
                holder.binding.txtMsgTime.text = timeFormat.format(chatRoom.messageTime.toDate())
            }
            is DateViewHolder -> {
                val dateString = dateFormat.format(chatRoom.messageTime.toDate())
                holder.binding.txtDate.text = dateString
            }
        }
        fn(holder, chatRoom)
    }

    override fun getItemViewType(position: Int): Int {
        val chatRoom = getItem(position)
        return when (chatRoom.chatType) {
            "left" -> 1
            "right" -> 2
            "leftimage" -> 3
            "rightimage" -> 4
            else -> 0
        }
    }
}
