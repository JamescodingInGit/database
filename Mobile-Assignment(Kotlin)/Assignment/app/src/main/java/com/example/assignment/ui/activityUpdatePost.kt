package com.example.assignment.ui

import com.example.assignment.R
import android.app.Activity
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.net.Uri
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.example.assignment.data.AuthVM
import com.example.assignment.data.Room
import com.example.assignment.data.RoomVM
import com.example.assignment.databinding.FragmentActivityUpdatePostBinding
import com.example.assignment.util.errorDialog
import com.google.firebase.firestore.Blob
import com.google.firebase.firestore.GeoPoint
import kotlinx.coroutines.launch
import java.io.ByteArrayOutputStream
import java.io.FileNotFoundException
import java.io.InputStream


class activityUpdatePost : Fragment() {

    private lateinit var binding: FragmentActivityUpdatePostBinding
    private val vm: RoomVM by activityViewModels()
    private val REQUEST_EXTERNAL_STORAGE = 100
    private val auth: AuthVM by activityViewModels()
    private val nav by lazy { findNavController() }
    private val roomId by lazy { arguments?.getString("roomId") ?: "" }
    private var existingRoom: Room? = null
    private val latitude by lazy { arguments?.getString("latitude") ?: "" }
    private val longitude by lazy { arguments?.getString("longitude") ?: "" }
    private val location by lazy { arguments?.getString("location") ?: "" }
    private val MAX_IMAGE_COUNT = 9

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentActivityUpdatePostBinding.inflate(inflater, container, false)
        binding.btnLocation.setOnClickListener  {  nav.navigate(R.id.editLocationFragment, bundleOf(
            "roomId" to roomId
        ))

        }

//        reset()
        binding.btnUpdate.setOnClickListener { update() }
        binding.btnReset.setOnClickListener { reset() }
        binding.btnInPhoto.setOnClickListener {
            launchGalleryIntent()
        }
//        vm.roomId.value = roomId

        lifecycleScope.launch{
            if (!vm.dataRetrieved) {
                retrieve()
//                 Update the flag to indicate data retrieval
                vm.dataRetrieved = true
            }else{
                retain(roomId)
            }
        }

        if(latitude.isNotEmpty() && longitude.isNotEmpty()){
            binding.btnLocation.text = location
        }

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        // Get references to checkboxes
        val single = binding.chbSingleRoom
        val medium = binding.chbMediumRoom
        val master = binding.chbMasterRoom

        val bed1 = binding.chbBedOne
        val bed2 = binding.chbBedTwo
        val bed3 = binding.chbBedThree
        val bed4 = binding.chbBedFour

        val bath1 = binding.chbBathOne
        val bath2 = binding.chbBathTwo
        val bath3 = binding.chbBathThree

        // Set listeners to ensure only one checkbox is checked at a time
        single.setOnCheckedChangeListener { _, isChecked ->
            if (isChecked) {
                medium.isChecked = false
                master.isChecked = false
            }
        }

        medium.setOnCheckedChangeListener { _, isChecked ->
            if (isChecked) {
                single.isChecked = false
                master.isChecked = false
            }
        }

        master.setOnCheckedChangeListener { _, isChecked ->
            if (isChecked) {
                single.isChecked = false
                medium.isChecked = false
            }
        }
        // check let the bedroom checkbox only can choose one only
        bed1.setOnCheckedChangeListener { _, isChecked ->
            if (isChecked) {
                bed4.isChecked = false
                bed2.isChecked = false
                bed3.isChecked = false
            }
        }

        bed2.setOnCheckedChangeListener { _, isChecked ->
            if (isChecked) {
                bed4.isChecked = false
                bed1.isChecked = false
                bed3.isChecked = false
            }
        }

        bed3.setOnCheckedChangeListener { _, isChecked ->
            if (isChecked) {
                bed1.isChecked = false
                bed2.isChecked = false
                bed4.isChecked = false
            }
        }
        bed4.setOnCheckedChangeListener { _, isChecked ->
            if (isChecked) {
                bed1.isChecked = false
                bed2.isChecked = false
                bed3.isChecked = false
            }
        }
        //check and make the bath checkbox only can choose one only
        bath1.setOnCheckedChangeListener { _, isChecked ->
            if (isChecked) {
                bath2.isChecked = false
                bath3.isChecked = false
            }
        }

        bath2.setOnCheckedChangeListener { _, isChecked ->
            if (isChecked) {
                bath1.isChecked = false
                bath3.isChecked = false
            }
        }

        bath3.setOnCheckedChangeListener { _, isChecked ->
            if (isChecked) {
                bath1.isChecked = false
                bath2.isChecked = false
            }
        }


    }

    private fun retrieve() {
        lifecycleScope.launch {
            val r = vm.get(roomId)
            if(r == null){
                nav.navigateUp()
                return@launch
            }
            existingRoom = r
            binding.ettTitle.setText(r.roomName)
            binding.btnLocation.setText(r.roomPlace)
            binding.dttDetails.setText(r.roomDetail)
            for (photo in r.photo) {
                val bitmap = blobToBitmap(photo)
                addImageToContainer(bitmap, binding.imageContainer)
            }
            binding.ettRoomSize.setText(r.roomSize.toString())
            setRoomType(r.roomType)
            setNumBed(r.numOfBed)
            setNumBath(r.numOfBath)
            setSelectedAmenities(r.homeAmenities.toMutableList())
            binding.ettPrice.setText(r.roomPrice.toString())

            binding.ettTitle.requestFocus()
        }
    }

    private fun retain(roomId: String) {
        lifecycleScope.launch {
            val r = vm.get(roomId)
            if(r == null){
                nav.navigateUp()
                return@launch
            }
            existingRoom = r
            binding.ettTitle.setText(r.roomName)
            binding.dttDetails.setText(r.roomDetail)
            for (photo in r.photo) {
                val bitmap = blobToBitmap(photo)
                addImageToContainer(bitmap, binding.imageContainer)
            }
            binding.ettRoomSize.setText(r.roomSize.toString())
            setRoomType(r.roomType)
            setNumBed(r.numOfBed)
            setNumBath(r.numOfBath)
            setSelectedAmenities(r.homeAmenities.toMutableList())
            binding.ettPrice.setText(r.roomPrice.toString())

            binding.ettTitle.requestFocus()
        }
    }

    private fun reset() {
        binding.ettTitle.text.clear()
//        binding.btnLocation.text.clear()
        binding.dttDetails.text.clear()
        binding.imageContainer.removeAllViews()
        binding.ettRoomSize.text.clear()
        binding.chbSingleRoom.isChecked = false
        binding.chbMediumRoom.isChecked = false
        binding.chbMasterRoom.isChecked = false
        binding.chbBedOne.isChecked = false
        binding.chbBedTwo.isChecked = false
        binding.chbBedThree.isChecked = false
        binding.chbBedFour.isChecked = false
        binding.chbBathOne.isChecked = false
        binding.chbBathTwo.isChecked = false
        binding.chbBathThree.isChecked = false
        binding.chbWifi.isChecked = false
        binding.chbTv.isChecked = false
        binding.chbAir.isChecked = false
        binding.chbWashM.isChecked = false
        binding.ettPrice.text.clear()

        binding.ettTitle.requestFocus()
    }

    private fun blobToBitmap(blob: Blob): Bitmap {
        val byteArray = blob.toBytes()
        return BitmapFactory.decodeByteArray(byteArray, 0, byteArray.size)
    }

    private fun setRoomType(RoomType: String) {
        when (RoomType){
            "Single" -> binding.chbSingleRoom.isChecked = true
            "Medium" -> binding.chbMediumRoom.isChecked = true
            "Master" -> binding.chbMasterRoom.isChecked = true
        }
    }
    private fun setNumBed(NumBed: Int) {
        when (NumBed){
            1 -> binding.chbBedOne.isChecked = true
            2 -> binding.chbBedTwo.isChecked = true
            3 -> binding.chbBedThree.isChecked = true
            4 -> binding.chbBedFour.isChecked = true
        }
    }
    private fun setNumBath(NumBath: Int) {
        when (NumBath){
            1 -> binding.chbBathOne.isChecked = true
            2 -> binding.chbBathTwo.isChecked = true
            3 -> binding.chbBathThree.isChecked = true
        }
    }
    private fun setSelectedAmenities(selectedAmenities: MutableList<String>) {
        for (amenity in selectedAmenities) {
            when (amenity) {
                "Wifi" -> binding.chbWifi.isChecked = true
                "TV" -> binding.chbTv.isChecked = true
                "Air-Condition" -> binding.chbAir.isChecked = true
                "Washing Machine" -> binding.chbWashM.isChecked = true
            }
        }
    }

    private fun launchGalleryIntent() {
        val intent = Intent(Intent.ACTION_GET_CONTENT)
        intent.putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true)
        intent.type = "image/*"
        startActivityForResult(intent, REQUEST_EXTERNAL_STORAGE)
    }

    private fun addImageToContainer(bitmap: Bitmap, container: LinearLayout) {
        val imageView = ImageView(requireContext())
        // Resize the bitmap to 200dp width and height
        val resizedBitmap = Bitmap.createScaledBitmap(bitmap, dpToPx(100), dpToPx(100), true)
        imageView.setImageBitmap(resizedBitmap)
        val layoutParams = LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT,
            LinearLayout.LayoutParams.WRAP_CONTENT
        )
        layoutParams.setMargins(8, 0, 8, 0)
        imageView.layoutParams = layoutParams
        container.addView(imageView)
    }

    private fun dpToPx(dp: Int): Int {
        val density = resources.displayMetrics.density
        return (dp * density).toInt()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_EXTERNAL_STORAGE && resultCode == Activity.RESULT_OK) {
            val imageContainer = binding.root.findViewById<LinearLayout>(R.id.imageContainer)

            // Clear existing images
            imageContainer.removeAllViews()

            val newImageUris = mutableListOf<Uri>()

            val clipData = data?.clipData
            if (clipData != null) {
                for (i in 0 until clipData.itemCount) {
                    newImageUris.add(clipData.getItemAt(i).uri)
                }
            } else {
                data?.data?.let { newImageUris.add(it) }
            }

            if (newImageUris.size > MAX_IMAGE_COUNT) {
                errorDialog("You can only select up to $MAX_IMAGE_COUNT images.")
                return
            }

            newImageUris.forEach { uri ->
                Log.d("URI", uri.toString())
                try {
                    val inputStream: InputStream? = requireContext().contentResolver.openInputStream(uri)
                    val bitmap = BitmapFactory.decodeStream(inputStream)
                    if (bitmap != null) {
                        addImageToContainer(bitmap, imageContainer)
                    }
                } catch (e: FileNotFoundException) {
                    e.printStackTrace()
                }
            }
        }
    }


    private fun combineImages(bitmaps: List<Bitmap>): Bitmap {
        // Determine total height and maximum width
        var totalHeight = 0
        var maxWidth = 0
        for (bitmap in bitmaps) {
            totalHeight += bitmap.height
            if (bitmap.width > maxWidth) {
                maxWidth = bitmap.width
            }
        }

        // Create a new bitmap to combine all images
        val combinedBitmap = Bitmap.createBitmap(maxWidth, totalHeight, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(combinedBitmap)

        // Draw each image onto the canvas
        var currentHeight = 0
        for (bitmap in bitmaps) {
            canvas.drawBitmap(bitmap, 0f, currentHeight.toFloat(), null)
            currentHeight += bitmap.height
        }

        return combinedBitmap
    }

    private fun update() {
        val roomtype = when {
            binding.chbSingleRoom.isChecked -> "Single"
            binding.chbMediumRoom.isChecked -> "Medium"
            binding.chbMasterRoom.isChecked -> "Master"
            else -> "" // Default or error handling
        }
        val numBed = when {
            binding.chbBedOne.isChecked -> 1
            binding.chbBedTwo.isChecked -> 2
            binding.chbBedThree.isChecked -> 3
            binding.chbBedFour.isChecked -> 4
            else -> 0 // Default or error handling
        }

        val numBath = when {
            binding.chbBathOne.isChecked -> 1
            binding.chbBathTwo.isChecked -> 2
            binding.chbBathThree.isChecked -> 3
            else -> 0 // Default or error handling
        }

        val selectedAmenities: MutableList<String> = ArrayList()
        if (binding.chbWifi.isChecked)
            selectedAmenities.add("Wifi")

        if(binding.chbTv.isChecked)
            selectedAmenities.add("TV")

        if (binding.chbAir.isChecked)
            selectedAmenities.add("Air-Condition")

        if (binding.chbWashM.isChecked)
            selectedAmenities.add("Washing Machine")


        // Get selected images
        val imageContainer = binding.imageContainer
        val bitmaps = mutableListOf<Bitmap>()
        for (i in 0 until imageContainer.childCount) {
            val imageView = imageContainer.getChildAt(i) as ImageView
            val bitmap = (imageView.drawable as BitmapDrawable).bitmap
            bitmaps.add(bitmap)
        }

        val photoByteList: MutableList<Blob> = ArrayList()
        // Convert each bitmap to a byte array and add to the list

// Convert each bitmap to a Blob and add to the list
        bitmaps.forEach { bitmap ->
            val byteArrayOutputStream = ByteArrayOutputStream()
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream)
            val byteArray = byteArrayOutputStream.toByteArray()
            val photoBlob = Blob.fromBytes(byteArray)
            photoByteList.add(photoBlob)
        }

//        val roomLocation = GeoPoint(latDouble, longDouble)
        // update room
        val room = Room(
            roomId = existingRoom?.roomId ?: "",
            roomName = binding.ettTitle.text.toString().trim(),
            roomPlace = binding.btnLocation.text.toString().trim(),
            roomDetail = binding.dttDetails.text.toString().trim(),
            photo    = photoByteList,
            roomSize = binding.ettRoomSize.text.toString().toDoubleOrNull() ?: 0.0,
            roomType = roomtype,
            numOfBed = numBed,
            numOfBath = numBath,
            homeAmenities = selectedAmenities,
            roomPrice = binding.ettPrice.text.toString().toDoubleOrNull() ?: 0.0,
            userId = auth.getUser()!!.email,
            roomLocation = GeoPoint(latitude.toDoubleOrNull() ?: 0.0,longitude.toDoubleOrNull() ?: 0.0)
        )

        val e = vm.validate(room)
        if (e != "") {
            errorDialog(e)
            return
        }

        Log.d("Room:",room.toString())

        vm.set(room)
        nav.navigate(R.id.activityFragment)
    }

}