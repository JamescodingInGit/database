package com.example.assignment.data

import android.content.ContentValues.TAG
import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.google.firebase.firestore.GeoPoint
import com.google.firebase.firestore.ListenerRegistration
import com.google.firebase.firestore.toObjects
import kotlin.math.atan2
import kotlin.math.cos
import kotlin.math.sin
import kotlin.math.sqrt

class RoomVM : ViewModel() {

    val roomListLD = MutableLiveData<List<Room>>()
    private var listener: ListenerRegistration? = null
    private var searchLocation: GeoPoint = GeoPoint(0.0,0.0)
    private var originalList = MutableLiveData<List<Room>>()
    private var filterOptions: RoomFilterOptions = RoomFilterOptions("",0,0, listOf())
    var dataRetrieved: Boolean = false

    // Collection reference
    init {
        // TODO: Add snapshot listener (real-time updates)
        listener = ROOM.addSnapshotListener { v, _ ->
            roomListLD.value = v?.toObjects()
            originalList.value = v?.toObjects()
        }
    }

    // ---------------------------------------------------------------------------------------------

    override fun onCleared() {
        listener?.remove()
    }


    fun init() = Unit

    fun getRoomsLD() = roomListLD

    fun getAllRoomByUser(email: String): LiveData<List<Room>> {
        val filteredRoomListLD = MutableLiveData<List<Room>>()

        roomListLD.observeForever { roomList ->
            val filteredRoomList = roomList
                .filter { it.userId == email }
            filteredRoomListLD.value = filteredRoomList
        }

        return filteredRoomListLD
    }

    fun getAll() = originalList.value

    fun get(id: String) = roomListLD.value?.find { it.roomId == id }

    fun add(f: Room){
        if(!idExists(f.roomId)){
            ROOM.add(f)
        }
    }

    fun delete(id: String) {
        // TODO: Delete record by id
        ROOM.document(id).delete()
    }

    fun deleteAll() {
        // TODO: Delete all records
        roomListLD.value?.forEach{ROOM.document(it.roomId).delete()}
    }

    fun set(f: Room) {
        // TODO: Set record (insert or update)
        ROOM.document(f.roomId).set(f)
    }

    // ---------------------------------------------------------------------------------------------

    private fun idExists(id: String) = roomListLD.value?.any { it.roomId == id } ?: false

    fun validate(room: Room, insert: Boolean = true): String {
        var e = ""

        e += if (room.roomName == "") "- Room name required.\n"
        else if (room.roomName.length < 5) "- Room name too short (min 5 chars).\n"
        else if (room.roomName.length > 60) "- Room name too long (max 60 chars).\n"
        else ""

        e += if (room.roomDetail == "") "- Room Details required.\n"
        else if (room.roomDetail.length < 10) "- Room details too short (min 10 chars).\n"
        else ""

        e += if (room.roomSize == 0.0) "- Room Size shouldn't be 0.\n"
        else ""

        e += if (room.roomType == "") "- Room Type required You should choose either one.\n"
        else ""

        e += if (room.numOfBed == 0) "- Number of room required You should choose either one.\n"
        else ""

        e += if (room.numOfBath == 0) "- Number of bath room required You should choose either one.\n"
        else ""

        e += if (room.homeAmenities.isEmpty()) "- Home Amenitied required You should choose either one.\n"
        else ""

        e += if (room.roomPrice == 0.0) "- Room price shouldn't be 0 or empty.\n"
        else ""

        e += if (room.photo.isEmpty()) "- Photo required.\n"
        else ""

        return e
    }

    fun searchByLocation(searchLocation: GeoPoint){
        this.searchLocation = searchLocation
        resultSearch()
    }

    fun clearSearch(){
        this.roomListLD.value = originalList.value
    }

    fun filterRooms(filterOptions: RoomFilterOptions) {
        this.filterOptions = filterOptions
        updateResult()
    }

    fun resultSearch(){
        var list = getAll()
        if (list != null) {
            list = list.filter {
                val roomLocation = it.roomLocation
                val distance = calculateDistance(searchLocation, roomLocation)
                distance <= 3 // Filter rooms within 3 km radius
            }
        }
        this.roomListLD.value = list
    }

    fun updateResult() {
        val list = getAll() ?: return

        val filteredList = list.filter { room ->
            // Filter based on room type if provided
            val roomTypeMatches = filterOptions.roomType?.let { room.roomType == it } ?: true
            // Filter based on number of bedrooms if provided
            val numberOfBedroomsMatches = filterOptions.numberOfBedrooms?.let { room.numOfBed == it } ?: true
            // Filter based on number of bathrooms if provided
            val numberOfBathroomsMatches = filterOptions.numberOfBathrooms?.let { room.numOfBath == it } ?: true
            // Filter based on selected features if provided
            val selectedFeaturesMatches = filterOptions.selectedFeatures?.all { room.homeAmenities.contains(it) } ?: true

            roomTypeMatches && numberOfBedroomsMatches && numberOfBathroomsMatches && selectedFeaturesMatches
        }

        this.roomListLD.value = filteredList
    }

    fun calculateDistance(point1: GeoPoint, point2: GeoPoint): Double {
        val R = 6371 // Earth radius in kilometers
        val lat1 = Math.toRadians(point1.latitude)
        val lon1 = Math.toRadians(point1.longitude)
        val lat2 = Math.toRadians(point2.latitude)
        val lon2 = Math.toRadians(point2.longitude)

        val dLat = lat2 - lat1
        val dLon = lon2 - lon1

        val a = sin(dLat / 2) * sin(dLat / 2) +
                cos(lat1) * cos(lat2) *
                sin(dLon / 2) * sin(dLon / 2)
        val c = 2 * atan2(sqrt(a), sqrt(1 - a))

        return R * c
    }


}