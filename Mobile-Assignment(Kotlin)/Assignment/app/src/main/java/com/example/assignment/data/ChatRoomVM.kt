package com.example.assignment.data

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.google.firebase.firestore.ListenerRegistration
import com.google.firebase.firestore.toObjects


class ChatRoomVM : ViewModel() {

    val chatRoomListLD = MutableLiveData<List<ChatRoom>>()
    val filteredChatListLD = MutableLiveData<List<ChatRoom>>()
    private var listener: ListenerRegistration? = null
    private var name = ""
    private var email = ""

    // Collection reference
    init {
        listener = CHATROOM.addSnapshotListener { v, _ ->
            chatRoomListLD.value = v?.toObjects()
            sortByTime()
        }
    }

    // ---------------------------------------------------------------------------------------------

    override fun onCleared() {
        listener?.remove()
    }


    fun init() = Unit

    fun getChatRoomLD() = chatRoomListLD

    fun getAll() = chatRoomListLD.value

    fun getAllByEmail(email: String): MutableLiveData<List<ChatRoom>> {
        this.email = email
        chatRoomListLD.observeForever { chatRoomList ->
            val filteredSortedChatList = chatRoomList
                .filter { it.userId.contains(email) }
            filteredChatListLD.value = filteredSortedChatList
        }

        return filteredChatListLD
    }


    fun getRoomByUser(sender: String, receiver: String): ChatRoom? {
        chatRoomListLD.value?.forEach {
            if (it.userId.contains(sender) && it.userId.contains(receiver)) {
                return it
            }
        }
        return null
    }

    fun sortByTime(){
        val chatList = chatRoomListLD.value ?: emptyList()
        val sortedChatList = chatList.sortedBy { it.lastMessageTime }
        chatRoomListLD.value = sortedChatList.reversed()
    }


    fun get(id: String) = chatRoomListLD.value?.find { it.chatRoomId == id }

    fun add(f: ChatRoom){
        if (!idExists(f.chatRoomId)) {
            CHATROOM.add(f)
        }
    }

    fun set(chatRoom: ChatRoom) {
        CHATROOM.document(chatRoom.chatRoomId).set(chatRoom)
    }

    fun delete(id: String) {
        CHATROOM.document(id).delete()

    }

    fun deleteAll() {
        chatRoomListLD.value?.forEach{CHATROOM.document(it.chatRoomId).delete()}
    }

    private fun idExists(id: String) = chatRoomListLD.value?.any { it.chatRoomId == id } ?: false

    fun search(name: String) {
        this.name = name
        updateResult()
    }

    fun updateResult() {
        var list = getAllByEmail(email).value

        if (list != null) {
            list = list.filter {
                it.user.name.contains(name, true)
            }
        }

        this.filteredChatListLD.value = list
    }

}