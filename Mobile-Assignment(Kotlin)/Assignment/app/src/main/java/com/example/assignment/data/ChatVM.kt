package com.example.assignment.data

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.google.firebase.firestore.ListenerRegistration
import com.google.firebase.firestore.toObjects

class ChatVM : ViewModel() {

    val chatListLD = MutableLiveData<List<Chat>>()
    private var listener: ListenerRegistration? = null

    init {
        listener = CHAT.addSnapshotListener { v, _ ->
            chatListLD.value = v?.toObjects()
            sortByTime()
        }
    }

    // ---------------------------------------------------------------------------------------------

    override fun onCleared() {
        listener?.remove()
    }


    fun init() = Unit

    fun getChatLD() = chatListLD

    fun getAll() = chatListLD.value

    fun getAllByRoomId(chatRoomId: String): LiveData<List<Chat>> {
        val filteredChatListLD = MutableLiveData<List<Chat>>()

        chatListLD.observeForever { chatList ->
            val filteredSortedChatList = chatList
                .filter { it.chatRoomId == chatRoomId }
                .sortedBy { it.messageTime }
            filteredChatListLD.value = filteredSortedChatList
        }

        return filteredChatListLD
    }

    fun sortByTime(){
        val chatList = chatListLD.value ?: emptyList()
        val sortedChatList = chatList.sortedBy { it.messageTime }
        chatListLD.value = sortedChatList
    }

    fun getAllChatRooms(roomId: String, email: String): List<Chat>? {
        val filteredChatList = mutableListOf<Chat>()
        chatListLD.value?.forEach { chat ->
            if (chat.chatRoomId == roomId && chat.senderId!= email) {
                filteredChatList.add(chat)
            }
        }
        return filteredChatList
    }

    fun setRead(roomId: String, email: String) {
        val chatRooms = getAllChatRooms(roomId, email)
        chatRooms?.forEach { chatRoom ->
            if (!chatRoom.isRead) {
                chatRoom.isRead = true
                set(chatRoom)
            }
        }
    }

    fun get(id: String) = chatListLD.value?.find { it.chatId == id }

    fun add(f: Chat){
        if (!idExists(f.chatId)) {
            CHAT.add(f)
        }
    }

    fun set(f: Chat) {
        CHAT.document(f.chatId).set(f)
    }

    fun delete(id: String) {
        CHAT.document(id).delete()

    }

    fun deleteAll() {
        chatListLD.value?.forEach{CHAT.document(it.chatId).delete()}
    }

    private fun idExists(id: String) = chatListLD.value?.any { it.chatId == id } ?: false


}