package com.example.assignment.ui

import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Bundle
import android.os.Environment
import android.provider.MediaStore
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import androidx.core.os.bundleOf
import androidx.core.view.size
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.navigation.fragment.findNavController
import com.example.assignment.MainActivity
import com.example.assignment.R
import com.example.assignment.data.AuthVM
import com.example.assignment.data.Chat
import com.example.assignment.data.ChatRoom
import com.example.assignment.data.ChatRoomVM
import com.example.assignment.data.ChatVM
import com.example.assignment.data.User
import com.example.assignment.data.UserVM
import com.example.assignment.databinding.FragmentMessageChatBinding
import com.example.assignment.util.ChatAdapter
import com.example.assignment.util.setImageBlob
import com.example.assignment.util.toBlob
import com.example.assignment.util.toast
import com.google.firebase.Timestamp
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.RequestBody.Companion.toRequestBody
import org.json.JSONObject
import java.io.File
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date
import java.util.Locale



class MessageChat : Fragment() {

    private lateinit var binding: FragmentMessageChatBinding
    private val nav by lazy { findNavController() }
    private val chatVM: ChatVM by activityViewModels()
    private val chatRoomVM: ChatRoomVM by activityViewModels()
    private val auth: AuthVM by activityViewModels()
    private val userVM: UserVM by activityViewModels()
    private val adapter = ChatAdapter()
    private val chatRoomId by lazy { arguments?.getString("chatRoomId") ?: "" }
    private val userMail by lazy { arguments?.getString("userMail") ?: "" }
    private val email by lazy { auth.getUserLD().value!!.email }
    private val token by lazy { arguments?.getString("token") ?: "" }
    private lateinit var imageFile: File

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {

        binding = FragmentMessageChatBinding.inflate(inflater, container, false)

        binding.btnChatBack.setOnClickListener{message()}
        binding.btnChatSend.setOnClickListener{
            var chatRoomID = chatRoomId
            if(chatRoomID.isEmpty()){
                createChatRoom()
                chatRoomVM.chatRoomListLD.observe(viewLifecycleOwner) { chatRooms ->
                    chatRoomID = chatRoomVM.getRoomByUser(userMail, email)?.chatRoomId ?: return@observe
                    if (chatRoomID != null && !chatRoomID.isEmpty()) {
                        sendMessage(null,chatRoomID,"message")
                        chatRoomVM.chatRoomListLD.removeObservers(viewLifecycleOwner)
                    }
                }
            }
            else{
                sendMessage(null,chatRoomID,"message")
            }
        }
        binding.btnCamera.setOnClickListener{ camera() }
        binding.btnStorage.setOnClickListener{ pickImage() }

        if(!chatRoomId.isEmpty()){
            var chatRoom = chatRoomVM.get(chatRoomId)
            userVM.getUserUpdate(chatRoom?.user?.email!!).observe(viewLifecycleOwner) {
                it?.forEach { chatRoom?.user = it }
                setUserInfo(chatRoom.user)
            }
            chatVM.setRead(chatRoomId,email)
            if(chatRoom.lastSender != email){
                chatRoom.isRead = true
                chatRoomVM.set(chatRoom)
            }

        }
        else{
            userVM.getUserUpdate(userMail).observe(viewLifecycleOwner) {
                it?.forEach{
                    setUserInfo(it)
                }
            }
        }

        binding.chatMsgRV.adapter = adapter

        var chatRoomID = chatRoomId
        if(chatRoomID != null && chatRoomID != ""){
            setChat(chatRoomID)
        }
        else {
            var chatRoom = chatRoomVM.getRoomByUser(userMail, email)
            chatRoomID = chatRoom?.chatRoomId ?: ""
            setChat(chatRoomID)
        }
        chatRoomVM.chatRoomListLD.observe(viewLifecycleOwner) {
            var chatRoomID = chatRoomId
            if(chatRoomID != null && chatRoomID != ""){
                setChat(chatRoomID)
            }
            else {
                var chatRoom = chatRoomVM.getRoomByUser(userMail, email)
                chatRoomID = chatRoom?.chatRoomId ?: ""
                setChat(chatRoomID)
            }
        }

        binding.btnInfoProfile.setOnClickListener{
            nav.navigate(
                R.id.messageProfileInfo, bundleOf(
                "userMail" to userMail,
                    "chatRoomId" to chatRoomID,
            ))
        }

        return binding.root
    }

    private fun setChat(chatRoomID: String){
        chatVM.getAllByRoomId(chatRoomID).observe(viewLifecycleOwner) {
            val chat: MutableList<Chat> = mutableListOf()
            var lastDate: Date? = null

            it.forEach { chatItem ->
                val currentDate = chatItem.messageTime.toDate()
                chatItem.user = userVM.get(chatItem.senderId)!!
                if (lastDate == null || !currentDate.isSameDay(lastDate!!)) {
                    val dateChat = Chat().apply {
                        messageTime = chatItem.messageTime
                    }
                    chat.add(dateChat)
                    lastDate = currentDate
                }

                setType(chatItem)
                chat.add(chatItem)
            }
            binding.chatMsgRV?.scrollToPosition(it.size - 1)
            adapter.submitList(chat)
        }
    }

    private fun sendNotification(message: String, chatRoomID: String) {
        val client = OkHttpClient()
        val mediaType = "application/json".toMediaType()
        val jsonNotif = JSONObject().apply {
            put("body", message)
            put("title", userVM.get(email)!!.name)
            put("roomId",chatRoomID)
        }
        val wholeObj = JSONObject().apply {
            put("to", token)
            put("notification", jsonNotif)
        }

        val requestBody = wholeObj.toString().toRequestBody(mediaType)
        val request = okhttp3.Request.Builder()
            .url("https://fcm.googleapis.com/fcm/send")
            .post(requestBody)
            .addHeader("Authorization", "key=AAAAJo8U3wA:APA91bHp8m5bPi6cjG2mO8fInY07wEY_qn0jGod2WrH1I3iASRqYq9O1QbmN39swKS6-nSquzVuh_UBMcr4KzkxtsukYP35-v0TPOdnAscBWOaXJDN8ovqXro2bSZDFDpGDprUROFM7a")
            .addHeader("Content-Type", "application/json")
            .build()

        CoroutineScope(Dispatchers.IO).launch {
            try {
                val response = client.newCall(request).execute()
            } catch (e: Exception) {
                Log.e("NotificationException", "Error sending notification: ${e.message}")
            }
        }
    }



    private fun message() {
        nav.navigateUp()
    }

    private fun sendMessage(bitmap: Bitmap?, chatRoomID: String, chatType: String){
        val newMsg = Chat()
        val room = chatRoomVM.get(chatRoomID)
        var message: String = ""
        newMsg.chatRoomId = chatRoomID
        newMsg.senderId = email
        if(chatType == "message" && noInputText()){
            newMsg.message = binding.txtSend.text.toString()
            sendNotification(binding.txtSend.text.toString(),chatRoomID)
            message = binding.txtSend.text.toString()
            chatVM.add(newMsg)
            binding.chatMsgRV?.scrollToPosition( binding.chatMsgRV.size - 1)
        }else if(chatType == "image"){
            newMsg.image = bitmap!!.toBlob()
            sendNotification("image",chatRoomID)
            message = "image"
            chatVM.add(newMsg)
            binding.chatMsgRV?.scrollToPosition( binding.chatMsgRV.size - 1)
        }
        else{
            toast("Please enter a message text!!")
        }
        if (room != null) {
            room.user.email =userMail
            room.lastSender = email
            room.lastMessage = message
            room.lastMessageTime = newMsg.messageTime
            room.isRead = false
            chatRoomVM.set(room)
        }
        binding.txtSend.text.clear()
    }



    private fun camera() {
        if (ContextCompat.checkSelfPermission(requireContext(), android.Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(requireActivity(), arrayOf(android.Manifest.permission.CAMERA), 100)
        } else {
            val intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
            imageFile = createImageFile()
            val photoURI = FileProvider.getUriForFile(requireContext(), "your.package.name.fileprovider", imageFile)
            intent.putExtra(MediaStore.EXTRA_OUTPUT, photoURI)
            startActivityForResult(intent, 100)
        }
    }

    private fun createImageFile(): File {
        val timeStamp = SimpleDateFormat("yyyyMMdd_HHmmss", Locale.getDefault()).format(Date())
        val storageDir = requireContext().getExternalFilesDir(Environment.DIRECTORY_PICTURES)
        return File.createTempFile(
            "JPEG_${timeStamp}_", /* prefix */
            ".jpg", /* suffix */
            storageDir /* directory */
        )
    }

    private fun pickImage() {
        val intent = Intent()
        intent.type = "image/*"
        intent.action = Intent.ACTION_GET_CONTENT
        intent.putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true)
        startActivityForResult(Intent.createChooser(intent, "Select Picture"), 200)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if(requestCode == 100){
            val bitmap = BitmapFactory.decodeFile(imageFile.absolutePath)
            val resizedBitmap = resizeBitmap(bitmap, 750)
            checkImageMsg(resizedBitmap)
        }
        else if(requestCode == 200){
            if (data?.clipData != null) {
                val clipData = data.clipData
                for (i in 0 until clipData!!.itemCount) {
                    val uri = clipData.getItemAt(i).uri
                    val bitmap = MediaStore.Images.Media.getBitmap(requireContext().contentResolver, uri)
                    val resizedBitmap = resizeBitmap(bitmap, 750)
                    checkImageMsg(resizedBitmap)
                }
            } else if (data?.data != null) {
                val uri = data.data
                val bitmap = MediaStore.Images.Media.getBitmap(requireContext().contentResolver, uri)
                val resizedBitmap = resizeBitmap(bitmap, 750)
                checkImageMsg(resizedBitmap)
            }
        }
    }

    private fun resizeBitmap(bitmap: Bitmap, desiredHeight: Int): Bitmap {
        val aspectRatio = bitmap.width.toFloat() / bitmap.height.toFloat()
        val width = (desiredHeight * aspectRatio).toInt()
        return Bitmap.createScaledBitmap(bitmap, width, desiredHeight, false)
    }

    private fun checkImageMsg(bitmap: Bitmap){
        var chatRoomID = chatRoomId
        if(chatRoomID.isEmpty()){
            createChatRoom()
            chatRoomVM.chatRoomListLD.observe(viewLifecycleOwner) { chatRooms ->
                chatRoomID = chatRoomVM.getRoomByUser(userMail, email)?.chatRoomId ?: return@observe
                if (chatRoomID != null && !chatRoomID.isEmpty()) {
                    sendMessage(bitmap,chatRoomID,"image")
                    chatRoomVM.chatRoomListLD.removeObservers(viewLifecycleOwner)
                }
            }
        }else{
            sendMessage(bitmap,chatRoomID,"image")
        }
    }


    private fun noInputText(): Boolean{
        if(binding.txtSend.text == null || binding.txtSend.text.toString().isEmpty()){
            return false
        }
        return true
    }

    private fun createChatRoom(){
        if(chatRoomVM.getRoomByUser(userMail,email) == null){
            val newChatRoom = ChatRoom()
            newChatRoom.userId = listOf(userMail,email)
            chatRoomVM.add(newChatRoom)
        }
    }

    private fun setType(chat: Chat){
        if(chat.senderId == email && chat.message.isEmpty()){
            chat.chatType = "rightimage"
        }
        else if(chat.senderId != email && chat.message.isEmpty()){
            chat.chatType = "leftimage"
        }
        else if(chat.senderId == email){
            chat.chatType = "right"
        }
        else{
            chat.chatType = "left"
        }
    }

    fun Date.isSameDay(other: Date): Boolean {
        val calendar1 = Calendar.getInstance().apply { time = this@isSameDay }
        val calendar2 = Calendar.getInstance().apply { time = other }
        return calendar1.get(Calendar.YEAR) == calendar2.get(Calendar.YEAR) &&
                calendar1.get(Calendar.DAY_OF_YEAR) == calendar2.get(Calendar.DAY_OF_YEAR)
    }

    fun setUserInfo(user: User){
        val dateFormat = SimpleDateFormat("yyyy/MM/dd", Locale.getDefault())
        val timeFormat = SimpleDateFormat("hh:mm a", Locale.getDefault())
        binding.imgChatUser.setImageBlob(user.photo)
        binding.txtSendName.text = user.name
        if(user.status == "online"){
            binding.txtStatus.text = "Online"
        }
        else if(dateFormat.format(user.lastLoginTime.toDate()) == dateFormat.format(Timestamp.now().toDate())){
            binding.txtStatus.text = "Last online time: today ${timeFormat.format(user.lastLoginTime.toDate())}"
        }
        else{
            binding.txtStatus.text = "Last online time: ${dateFormat.format(user.lastLoginTime.toDate())}"
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

}