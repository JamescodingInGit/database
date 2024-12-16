package com.example.assignment.ui

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.assignment.MainActivity
import com.example.assignment.R
import com.example.assignment.data.AuthVM
import com.example.assignment.data.FavoriteVM
import com.example.assignment.data.Room
import com.example.assignment.data.RoomVM
import com.example.assignment.data.UserVM
import com.example.assignment.databinding.FragmentRoomDetailsBinding
import com.example.assignment.util.ImageSliderAdapter
import com.example.assignment.util.RoomAdapter
import com.example.assignment.util.setImageBlob
import com.example.assignment.util.toast

class roomDetails : Fragment() {

    private lateinit var binding: FragmentRoomDetailsBinding
    private val nav by lazy { findNavController() }
    private val roomId by lazy {arguments?.getString("roomId") ?: "" }
    private val isFavorite by lazy {arguments?.getBoolean("isFavorite") ?: false }
    private val roomVM: RoomVM by activityViewModels()
    private val favoriteVM: FavoriteVM by activityViewModels()
    private val auth: AuthVM by activityViewModels()
    private val users: UserVM by activityViewModels()

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentRoomDetailsBinding.inflate(inflater, container, false)

        // -----------------------------------------------------------------------------------------
        val room = roomVM.get(roomId)
        if (room == null) {
            nav.navigateUp()
            return null
        }

        var drawableRes = if (isFavorite == true) {
            R.drawable.ic_is_favorite
        } else {
            R.drawable.ic_favorite2
        }

        if(auth.getUser()!!.email == roomVM.get(roomId)!!.userId ){
            binding.btnFavDetail.visibility = View.GONE
            binding.btnMessage.visibility = View.GONE
        }else{
            binding.btnFavDetail.visibility = View.VISIBLE
            binding.btnMessage.visibility = View.VISIBLE
        }

        var drawable = ContextCompat.getDrawable(requireContext(), drawableRes)
        binding.btnFavDetail.setImageDrawable(drawable)

        auth.getUserLD().observe(viewLifecycleOwner) { user ->
            // Log.d("User:", user.toString())
            if (user != null) {
                binding.btnFavDetail.setOnClickListener {

                    room.isFavorite = !room.isFavorite

                    if (room.isFavorite) {
                        if (user != null) {
                            favoriteVM.addToFavorites(user, room)
                        }

                    } else {
                        if (user != null) {
                            favoriteVM.removeFromFavorites(user, room)
                        }
                    }
                    drawableRes = if (room.isFavorite == true) {
                        R.drawable.ic_is_favorite
                    } else {
                        R.drawable.ic_favorite2
                    }

                    drawable = ContextCompat.getDrawable(requireContext(), drawableRes)
                    binding.btnFavDetail.setImageDrawable(drawable)
                }

                binding.btnMessage.setOnClickListener {
                    chat(room.userId, users.get(room.userId)!!.fcmToken)
                }
            } else {
                binding.btnFavDetail.setOnClickListener {
                    toast("Please login to add to favorites")
                }
            }


        }



        val imageSlider = binding.imageSliderDetail
        val imageSliderAdapter = ImageSliderAdapter(room.photo)
        imageSlider.adapter = imageSliderAdapter

        //binding.roomDetailImage.setImageBlob(room.photo)
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


    private fun chat(userMail: String, token: String) {
        nav.navigate(R.id.messageChatFragment, bundleOf(
            "userMail" to userMail
            )
        )
    }

    override fun onResume() {
        super.onResume();
        val mainActivity = requireActivity() as MainActivity
        mainActivity.hideBV()
    }
    override fun onStop() {
        super.onStop();
        val mainActivity = requireActivity() as MainActivity
        mainActivity.showBV()
    }
}