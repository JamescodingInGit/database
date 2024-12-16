package com.example.assignment.data

import android.os.Parcel
import android.os.Parcelable
import com.google.firebase.firestore.Blob
import com.google.firebase.firestore.DocumentId
import com.google.firebase.firestore.Exclude
import com.google.firebase.firestore.GeoPoint
import com.google.firebase.Timestamp
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase

data class Room(

    @DocumentId
    var roomId: String = "",
    var roomName: String = "",
    var roomPlace: String = "",
    var roomDetail: String = "",
    var photo: List<Blob> = listOf(),
    var roomSize: Double = 0.0,
    var roomType: String = "",
    var numOfBed: Int = 0,
    var numOfBath: Int = 0,
    var homeAmenities: List<String> = listOf(""),
    var roomPrice: Double = 0.0,
    var roomLocation: GeoPoint = GeoPoint(0.0,0.0),
    var userId: String = ""
){
    @get: Exclude
    var isFavorite:Boolean= false
}

data class RoomFilterOptions(
    val roomType: String?,
    val numberOfBedrooms: Int?,
    val numberOfBathrooms: Int?,
    val selectedFeatures: List<String>?
)

data class Favorite(
    @DocumentId
    var favoriteId: String = "",
    var userId: String = "",
    var roomId: String = ""
){
    @get: Exclude
    var room: Room = Room()
}



val ROOM = Firebase.firestore.collection("Rooms")

data class ChatRoom(
    @DocumentId
    var chatRoomId: String = "",
    var lastSender: String = "",
    var lastMessage: String = "",
    var lastMessageTime: Timestamp = Timestamp.now(),
    var userId: List<String> = listOf(),
    var isRead: Boolean = false
){
    @get:Exclude
    var user: User = User()
}

data class Chat(
    @DocumentId
    var chatId: String = "",
    var chatRoomId: String = "",
    var senderId: String = "",
    var message: String = "",
    var messageTime: Timestamp = Timestamp.now(),
    var isRead: Boolean = false,
    var image: Blob = Blob.fromBytes(ByteArray(0))
){
    @get:Exclude
    var chatType: String = ""
    var user: User = User()
}

data class User (
    @DocumentId
    var email: String = "",
    var password: String = "",
    var name: String = "",
    var photo: Blob = Blob.fromBytes(ByteArray(0)),
    val gender: String = "",
    val age:Int = 0,
    val birthday: Timestamp = Timestamp(0, 0),
    val mobile: String = "",
    var status: String = "",
    var lastLoginTime: Timestamp = Timestamp.now(),
    var fcmToken: String = ""
)

data class DataClass(var dataImage:Int, var dataTitle:String, var dataDesc: String): Parcelable {
    constructor(parcel: Parcel) : this(
        parcel.readInt(),
        parcel.readString()!!,
        parcel.readString()!!,

        ) {
    }
    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeInt(dataImage)
        parcel.writeString(dataTitle)
        parcel.writeString(dataDesc)

    }
    override fun describeContents(): Int {
        return 0
    }
    companion object CREATOR : Parcelable.Creator<DataClass> {
        override fun createFromParcel(parcel: Parcel): DataClass {
            return DataClass(parcel)
        }
        override fun newArray(size: Int): Array<DataClass?> {
            return arrayOfNulls(size)
        }
    }
}

val CHATROOM = Firebase.firestore.collection("ChatRoom")
val CHAT = Firebase.firestore.collection("Chat")
val USERS = Firebase.firestore.collection("users")
val FAVORITE = Firebase.firestore.collection("Favorite")