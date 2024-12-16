package com.example.assignment.data

import android.app.Application
import android.widget.Toast
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.google.firebase.firestore.ListenerRegistration
import com.google.firebase.firestore.toObjects

class FavoriteVM(application: Application) : AndroidViewModel(application) {

    private val favoriteLD = MutableLiveData<List<Favorite>>()
    private val orginialFavLD = MutableLiveData<List<Favorite>>()
    private var listener : ListenerRegistration? = null
    private var filterOptions: RoomFilterOptions = RoomFilterOptions("",0,0, listOf())


    init {
        listener = FAVORITE.addSnapshotListener { snap, _ ->
            favoriteLD.value = snap?.toObjects()
            orginialFavLD.value = snap?.toObjects()
        }
    }

    override fun onCleared() {
        listener?.remove()
    }

    // ---------------------------------------------------------------------------------------------

    fun init() = Unit

    fun getFavoritesLD() = favoriteLD

    fun getAll() = favoriteLD.value ?: emptyList()

    fun get(id: String) = getAll().find { it.roomId == id }

    fun deleteByRoomId(roomId: String){
        val list = getAll()
        list.forEach {
            if(it.roomId == roomId){
                FAVORITE.document(it.favoriteId).delete()
            }
        }
    }

    fun addToFavorites(user: User, room: Room) {
        val favorite = Favorite(userId = user.email, roomId = room.roomId)
        FAVORITE.document().set(favorite)
            .addOnSuccessListener {
                val context = getApplication<Application>().applicationContext
                Toast.makeText(context, "Favorite added successfully", Toast.LENGTH_SHORT).show()

            }
            .addOnFailureListener { exception ->
                val context = getApplication<Application>().applicationContext
                Toast.makeText(context, "Favorite added failed", Toast.LENGTH_SHORT).show()

            }
    }


    fun removeFromFavorites(user: User, room: Room) {
        val favoriteQuery = FAVORITE
            .whereEqualTo("userId", user.email)
            .whereEqualTo("roomId", room.roomId)
        favoriteQuery.get()
            .addOnSuccessListener { documents ->
                for (document in documents) {
                    FAVORITE
                        .document(document.id)
                        .delete()
                        .addOnSuccessListener {
                            // Handle success if needed
                        }
                        .addOnFailureListener { exception ->
                            // Handle failure if needed
                        }
                }
            }
            .addOnFailureListener { exception ->
                // Handle failure if needed
            }
    }

    fun clearSearch(){
        this.favoriteLD.value = orginialFavLD.value
    }

    fun filterRooms(filterOptions: RoomFilterOptions, favRoom: List<Favorite>) {
        this.filterOptions = filterOptions
        updateResult(favRoom)
    }

    fun updateResult(favRooms: List<Favorite>) {
        val list = favRooms ?: return

        val filteredList = list.filter { rm ->
            // Filter based on room type if provided
            val roomTypeMatches = filterOptions.roomType?.let { rm.room.roomType == it } ?: true
            // Filter based on number of bedrooms if provided
            val numberOfBedroomsMatches = filterOptions.numberOfBedrooms?.let { rm.room.numOfBed == it } ?: true
            // Filter based on number of bathrooms if provided
            val numberOfBathroomsMatches = filterOptions.numberOfBathrooms?.let { rm.room.numOfBath == it } ?: true
            // Filter based on selected features if provided
            val selectedFeaturesMatches = filterOptions.selectedFeatures?.all { rm.room.homeAmenities.contains(it) } ?: true

            roomTypeMatches && numberOfBedroomsMatches && numberOfBathroomsMatches && selectedFeaturesMatches
        }

        this.favoriteLD.value = filteredList
    }
}