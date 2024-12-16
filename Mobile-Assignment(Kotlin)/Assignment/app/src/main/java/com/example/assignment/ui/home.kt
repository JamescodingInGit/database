package com.example.assignment.ui

import android.os.Bundle
import android.view.ContextThemeWrapper
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.NumberPicker
import android.widget.Spinner
import android.widget.Toast
import androidx.core.content.ContextCompat
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.DividerItemDecoration
import com.example.assignment.R
import com.example.assignment.data.AuthVM
import com.example.assignment.data.FavoriteVM
import com.example.assignment.data.RoomVM
import com.example.assignment.data.RoomFilterOptions
import com.example.assignment.databinding.FragmentHomeBinding
import com.example.assignment.util.RoomAdapter
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.chip.Chip
import com.google.firebase.firestore.GeoPoint


class home : Fragment() {

    private lateinit var binding: FragmentHomeBinding
    private val nav by lazy { findNavController() }
    private val roomVM: RoomVM by activityViewModels()
    private val favoriteVM: FavoriteVM by activityViewModels()
    private val auth: AuthVM by activityViewModels()
    private lateinit var dialog: BottomSheetDialog
    private var isFiltering: Boolean = false
    private val latitude by lazy { arguments?.getString("latitude") ?: "" }
    private val longitude by lazy { arguments?.getString("longitude") ?: "" }
    private val location by lazy { arguments?.getString("location") ?: "" }
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {

        // Inflate the layout for this fragment
        binding = FragmentHomeBinding.inflate(inflater, container, false)


        val adapter = RoomAdapter { h, f ->
            h.binding.root.setOnClickListener { detail(f.roomId, f.isFavorite) }

            auth.getUserLD().observe(viewLifecycleOwner) { user ->

                if(user != null){
                    h.binding.btnFav.setOnClickListener {
                        f.isFavorite = !f.isFavorite

                        if (f.isFavorite) {
                            favoriteVM.addToFavorites(user, f)
                        } else {
                            favoriteVM.removeFromFavorites(user, f)
                        }


                        val drawableRes = if (f.isFavorite) {
                            R.drawable.ic_is_favorite
                        } else {
                            R.drawable.ic_favorite2
                        }
                        val drawable = ContextCompat.getDrawable(requireContext(), drawableRes)
                        h.binding.btnFav.setImageDrawable(drawable)
                    }
                }
            }
        }

        binding.rdView.adapter = adapter
        binding.rdView.addItemDecoration(DividerItemDecoration(context, DividerItemDecoration.VERTICAL))

        binding.btnFilter.setOnClickListener {
            showFilterDialog()
            isFiltering = true
        }

        if(latitude.isNotEmpty() && longitude.isNotEmpty()){
            binding.btnSearch.text = location
            roomVM.searchByLocation(GeoPoint(latitude.toDouble(), longitude.toDouble()))
        }

        auth.getUserLD().observe(viewLifecycleOwner) { user ->
            if (user != null) {
                favoriteVM.getFavoritesLD().observe(viewLifecycleOwner) { favorites ->
                    roomVM.getRoomsLD().observe(viewLifecycleOwner) { rooms ->
                        val favoriteRoomIds = favorites.filter { it.userId == user.email }
                        rooms.forEach { room ->
                            room.isFavorite = favoriteRoomIds.any { it.roomId == room.roomId }
                        }
                        binding.txtResult.text = "%d Results".format(rooms.size)
                        adapter.submitList(rooms)
                    }
                }
            } else {
                    roomVM.getRoomsLD().observe(viewLifecycleOwner) { rooms ->
                        rooms.forEach{ room ->
                            room.isFavorite = false
                        }
                        binding.txtResult.text = "%d Results".format(rooms.size)
                        adapter.submitList(rooms)
                    }
                // If no user is logged in, show rooms without favorite status

            }
        }

        binding.btnSearch.setOnClickListener{
            nav.navigate(R.id.mapSearchFragment)
        }

        binding.btnClearSearch.setOnClickListener{
            binding.btnSearch.setText("Search Location")
            roomVM.clearSearch()
        }

        return binding.root
    }

    private fun detail(roomId: String, isFavorite: Boolean) {
        nav.navigate(R.id.roomDetails4, bundleOf(
            "roomId" to roomId,
            "isFavorite" to isFavorite
        ))
    }

    private fun showFilterDialog() {

        val dialogView = layoutInflater.inflate(R.layout.fragment_room_filtering, null)
        dialog = BottomSheetDialog(requireContext())
        dialog.setContentView(dialogView)

        val chipGroup: com.google.android.material.chip.ChipGroup = dialogView.findViewById(R.id.chipGroup)
        val refreshButton: Button = dialogView.findViewById(R.id.btnRefresh)
        val applyButton: Button = dialogView.findViewById(R.id.btnApplyFilter)
        val numberPickerBedrooms: NumberPicker = dialogView.findViewById(R.id.numberPickerBedrooms)
        val numberPickerBathrooms: NumberPicker = dialogView.findViewById(R.id.numberPickerBathrooms)
        val spType : Spinner = dialogView.findViewById(R.id.spRoomType)
        val facilityOptions: List<String> = listOf("Wi-Fi", "TV", "Air-Conditioner", "Washing Machine")

        // Dynamically add chips to the ChipGroup
        facilityOptions.forEach { option ->
            val chip = com.google.android.material.chip.Chip(ContextThemeWrapper(requireContext(), R.style.CustomChipStyle)).apply {
                text = option
                isCheckable = true
                isChecked = false // Ensure the chip is not selected by default
            }
            chipGroup.addView(chip)
        }

        // Set initial values for NumberPickers
        numberPickerBedrooms.minValue = 1
        numberPickerBedrooms.maxValue = 10
        numberPickerBedrooms.value = 1 // Set initial value for bedrooms

        numberPickerBathrooms.minValue = 1
        numberPickerBathrooms.maxValue = 10
        numberPickerBathrooms.value = 1 // Set initial value for bathrooms

        applyButton.setOnClickListener {

            val selectedRoomType = spType.selectedItem.toString() // Corrected reference to spType
            val selectedBedrooms = numberPickerBedrooms.value
            val selectedBathrooms = numberPickerBathrooms.value
            val selectedFeatures = chipGroup.checkedChipIds.map { chipId ->
                val selectedChip: Chip? = chipGroup.findViewById(chipId)
                selectedChip?.text.toString()
            }

            val filterOptions = RoomFilterOptions(
                roomType = selectedRoomType,
                numberOfBedrooms = selectedBedrooms,
                numberOfBathrooms = selectedBathrooms,
                selectedFeatures = selectedFeatures
            )

            roomVM.filterRooms(filterOptions)
            dialog.dismiss()

            val selectedFeaturesText = selectedFeatures.joinToString(", ") // Join selected features into a single string
            Toast.makeText(requireContext(), "Selected room type: $selectedRoomType\nBedrooms: $selectedBedrooms\nBathrooms: $selectedBathrooms\nSelected features: $selectedFeaturesText", Toast.LENGTH_SHORT).show()
        }


        refreshButton.setOnClickListener {
            roomVM.clearSearch() // Call a function in your RoomVM to refresh the rooms
            dialog.dismiss() // Dismiss the dialog after triggering the refresh
            if(latitude.isNotEmpty() && longitude.isNotEmpty()){
                roomVM.searchByLocation(GeoPoint(latitude.toDouble(), longitude.toDouble()))
            }
        }

        dialog.show()
    }

    override fun onPause() {
        super.onPause()
        roomVM.clearSearch()
    }

}


