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
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.assignment.R
import com.example.assignment.data.AuthVM
import com.example.assignment.data.Favorite
import com.example.assignment.data.FavoriteVM
import com.example.assignment.data.Room
import com.example.assignment.data.RoomFilterOptions
import com.example.assignment.data.RoomVM
import com.example.assignment.databinding.FragmentFavoriteBinding
import com.example.assignment.databinding.FragmentHomeBinding
import com.example.assignment.util.FavoriteAdapter
import com.example.assignment.util.RoomAdapter
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.chip.Chip

class favorite : Fragment() {

    private lateinit var binding: FragmentFavoriteBinding
    private val nav by lazy { findNavController() }
    private val roomVM: RoomVM by activityViewModels()
    private val favoriteVM: FavoriteVM by activityViewModels()
    private val auth: AuthVM by activityViewModels()
    private lateinit var dialog: BottomSheetDialog
    private lateinit var filteredFavRoom: List<Favorite>
    private var isFiltering: Boolean = false
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentFavoriteBinding.inflate(inflater, container, false)

        binding.frView.layoutManager = LinearLayoutManager(context)
        val adapter = FavoriteAdapter(roomVM, auth) { h, f ->
            h.binding.root.setOnClickListener { detail(f.roomId, f.room.isFavorite) }

            auth.getUserLD().observe(viewLifecycleOwner) { user ->
                if (user != null) {
                    h.binding.btnFav.setOnClickListener {
                        f.room.isFavorite = !f.room.isFavorite

                        if (f.room.isFavorite) {
                            favoriteVM.addToFavorites(user, f.room)
                        } else {
                            favoriteVM.removeFromFavorites(user, f.room)
                        }

                        val drawableRes = if (f.room.isFavorite) {
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

        binding.frView.adapter = adapter
        binding.frView.addItemDecoration(DividerItemDecoration(context, DividerItemDecoration.VERTICAL))
        auth.getUserLD().observe(viewLifecycleOwner) { user ->
            favoriteVM.getFavoritesLD().observe(viewLifecycleOwner) { favorites ->
                if (user != null) {
                    val filteredFavorites = favorites.filter { it.userId == user.email }
                    filteredFavRoom = filteredFavorites
                    binding.txtResult.text = "%d Results".format(filteredFavorites.size)
                    adapter.submitList(filteredFavorites)
                }
            }
        }

        binding.btnFilter.setOnClickListener {
            showFilterDialog()
            isFiltering = true
        }
        // -----------------------------------------------------------------------------------------

        return binding.root
    }

    private fun detail(roomId: String, isFavorite: Boolean) {
        nav.navigate(R.id.roomDetails4, bundleOf(
            "roomId" to roomId,
            "isFavorite" to isFavorite
        )
        )
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

            favoriteVM.filterRooms(filterOptions, filteredFavRoom)
            dialog.dismiss()

            val selectedFeaturesText = selectedFeatures.joinToString(", ") // Join selected features into a single string
            Toast.makeText(requireContext(), "Selected room type: $selectedRoomType\nBedrooms: $selectedBedrooms\nBathrooms: $selectedBathrooms\nSelected features: $selectedFeaturesText", Toast.LENGTH_SHORT).show()
        }


        refreshButton.setOnClickListener {
            favoriteVM.clearSearch() // Call a function in your RoomVM to refresh the rooms
            dialog.dismiss() // Dismiss the dialog after triggering the refresh
        }

        dialog.show()
    }

    override fun onPause() {
        super.onPause()
        favoriteVM.clearSearch()
    }


}