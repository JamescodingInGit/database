package com.example.assignment.ui

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.assignment.R
import com.example.assignment.data.AuthVM
import com.example.assignment.data.FavoriteVM
import com.example.assignment.data.Room
import com.example.assignment.data.RoomVM
import com.example.assignment.databinding.FragmentActivityRoomDetailsBinding
import com.example.assignment.databinding.FragmentRoomDetailsBinding
import com.example.assignment.util.ImageSliderAdapter
import com.example.assignment.util.RoomAdapter
import com.example.assignment.util.setImageBlob

class activityRoomDetails : Fragment() {

    private lateinit var binding: FragmentActivityRoomDetailsBinding
    private val nav by lazy { findNavController() }
    private val roomId by lazy {arguments?.getString("roomId") ?: "" }
    private val roomVM: RoomVM by activityViewModels()

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentActivityRoomDetailsBinding.inflate(inflater, container, false)

        // -----------------------------------------------------------------------------------------
        val room = roomVM.get(roomId)
        if (room == null) {
            nav.navigateUp()
            return null
        }

        //binding.roomDetailImage.setImageBlob(room.photo)
        val imageSlider = binding.imageSliderDetail
        val imageSliderAdapter = ImageSliderAdapter(room.photo)
        imageSlider.adapter = imageSliderAdapter
        binding.txtRoomDName.text = room.roomName
        binding.txtRoomDPlace.text = room.roomPlace
        binding.txtRoomDPrice.text = "RM %.2f".format(room.roomPrice)
        binding.txtRoomD.text = room.roomDetail

        // Setup RecyclerView for facilities
        setupFacilitiesRecyclerView(room)

        // -----------------------------------------------------------------------------------------

        return binding.root
    }

    private fun setupFacilitiesRecyclerView(room: Room) {
        val facilitiesAdapter = RoomAdapter.FacilityAdapter(
            amenities = room.homeAmenities,
            roomSize = room.roomSize,
            numBath = room.numOfBath,
            numBed = room.numOfBed,
            roomType = room.roomType
        )

        binding.recyclerView.apply {
            layoutManager = LinearLayoutManager(context, LinearLayoutManager.HORIZONTAL, false)
            adapter = facilitiesAdapter
        }
    }
}