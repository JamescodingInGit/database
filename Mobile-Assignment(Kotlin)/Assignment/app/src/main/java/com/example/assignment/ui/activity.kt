package com.example.assignment.ui

import android.os.Bundle
import android.view.*
import android.widget.Button
import android.widget.NumberPicker
import android.widget.Spinner
import android.widget.Toast
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.DividerItemDecoration
import com.example.assignment.R
import com.example.assignment.data.AuthVM
import com.example.assignment.data.RoomVM
import com.example.assignment.databinding.FragmentActivityBinding
import com.example.assignment.util.PostCountListener
import com.example.assignment.util.RoomActivityAdapter
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.chip.Chip
import android.view.ContextThemeWrapper
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.example.assignment.data.FavoriteVM
import com.example.assignment.data.RoomFilterOptions



class activity : Fragment(), PostCountListener { // Implement PostCountListener

    private lateinit var binding: FragmentActivityBinding
    private val nav by lazy { findNavController() }
    private val vm: RoomVM by activityViewModels()
    private val favoriteVM: FavoriteVM by activityViewModels()
    private lateinit var adapter: RoomActivityAdapter
    private val auth: AuthVM by activityViewModels()
    private lateinit var dialog: BottomSheetDialog
    private var isFiltering: Boolean = false

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentActivityBinding.inflate(inflater, container, false)

        adapter = RoomActivityAdapter({ h, f ->
            h.binding.root.setOnClickListener { detail(f.roomId) }
        }, this)

        binding.rdView.adapter = adapter
        binding.rdView.addItemDecoration(
            DividerItemDecoration(
                context,
                DividerItemDecoration.VERTICAL
            )
        )

        vm.getAllRoomByUser(auth.getUser()!!.email).observe(viewLifecycleOwner) {
            adapter.submitList(it)
        }

        // Activity post create button
        binding.btnCreate.setOnClickListener { nav.navigate(R.id.activityAddPostFragment) }

        binding.btnFilter.setOnClickListener {
            showFilterDialog()
            isFiltering = true
        }

        return binding.root
    }

    override fun onContextItemSelected(item: MenuItem): Boolean {
        return adapter.onContextItemSelected(
            item,
            nav,
            vm,
            requireContext(),
            favoriteVM
        ) || super.onContextItemSelected(item)
    }

    private fun detail(roomId: String) {
        nav.navigate(R.id.activityRoomDetails, bundleOf("roomId" to roomId))
    }

    // Implement the PostCountListener method
    override fun onPostCountUpdated(count: Int) {
        binding.txtPostNum.text = "$count Post${if (count != 1) "s" else ""}"
    }

    private fun showFilterDialog() {

        val dialogView = layoutInflater.inflate(R.layout.fragment_room_filtering, null)
        dialog = BottomSheetDialog(requireContext())
        dialog.setContentView(dialogView)

        val chipGroup: com.google.android.material.chip.ChipGroup =
            dialogView.findViewById(R.id.chipGroup)
        val refreshButton: Button = dialogView.findViewById(R.id.btnRefresh)
        val applyButton: Button = dialogView.findViewById(R.id.btnApplyFilter)
        val numberPickerBedrooms: NumberPicker = dialogView.findViewById(R.id.numberPickerBedrooms)
        val numberPickerBathrooms: NumberPicker =
            dialogView.findViewById(R.id.numberPickerBathrooms)
        val spType: Spinner = dialogView.findViewById(R.id.spRoomType)
        val facilityOptions: List<String> = listOf("Wifi", "TV", "Air-Condition", "Washing Machine")

        facilityOptions.forEach { option ->
            val chip = Chip(ContextThemeWrapper(requireContext(), R.style.CustomChipStyle)).apply {
                text = option
                isCheckable = true
                isChecked = false
            }
            chipGroup.addView(chip)
        }

        numberPickerBedrooms.minValue = 1
        numberPickerBedrooms.maxValue = 10
        numberPickerBedrooms.value = 1

        numberPickerBathrooms.minValue = 1
        numberPickerBathrooms.maxValue = 10
        numberPickerBathrooms.value = 1

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

            vm.filterRooms(filterOptions)
            dialog.dismiss()

            val selectedFeaturesText = selectedFeatures.joinToString(", ")
            Toast.makeText(
                requireContext(),
                "Selected room type: $selectedRoomType\nBedrooms: $selectedBedrooms\nBathrooms: $selectedBathrooms\nSelected features: $selectedFeaturesText",
                Toast.LENGTH_SHORT
            ).show()
        }


        refreshButton.setOnClickListener {
            vm.clearSearch()
            dialog.dismiss()
        }

        dialog.show()
    }

    override fun onPause() {
        super.onPause()
        vm.clearSearch()
    }

}