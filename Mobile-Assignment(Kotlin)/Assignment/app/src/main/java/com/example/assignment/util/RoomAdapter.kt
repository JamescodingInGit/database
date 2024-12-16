package com.example.assignment.util

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.assignment.R
import com.example.assignment.data.Room
import com.example.assignment.databinding.ItemFacilityBinding
import com.example.assignment.databinding.ItemRoomdetailsBinding

class RoomAdapter (
    val fn: (ViewHolder, Room) -> Unit = { _, _ -> }
) :ListAdapter<Room, RoomAdapter.ViewHolder>(Diff){

    companion object Diff : DiffUtil.ItemCallback<Room>() {
        override fun areItemsTheSame(a: Room, b: Room) = a.roomId == b.roomId
        override fun areContentsTheSame(a: Room, b: Room) = a == b
    }
    class ViewHolder(val binding: ItemRoomdetailsBinding) : RecyclerView.ViewHolder(binding.root){
        fun updateFavoriteIcon(isFavorite: Boolean) {
            val drawableRes = if (isFavorite) {
                R.drawable.ic_is_favorite
            } else {
                R.drawable.ic_favorite2
            }
            val drawable = ContextCompat.getDrawable(binding.root.context, drawableRes)
            binding.btnFav.setImageDrawable(drawable)
        }
    }

//    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =
//        ViewHolder(ItemRoomdetailsBinding.inflate(LayoutInflater.from(parent.context), parent, false))

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val binding = ItemRoomdetailsBinding.inflate(inflater, parent, false)
        return ViewHolder(binding)
    }




    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val f = getItem(position)

        val imageSlider = holder.binding.imageSlider
        val imageSliderAdapter = ImageSliderAdapter(f.photo)
        imageSlider.adapter = imageSliderAdapter

        holder.binding.txtPrice.text = "RM %.2f".format(f.roomPrice)
        holder.binding.txtAddress.text = f.roomPlace
        holder.binding.txtRoomName.text = f.roomName

        val facView = holder.binding.facView

        if (facView.layoutManager == null) {
            facView.layoutManager = LinearLayoutManager(holder.itemView.context, LinearLayoutManager.HORIZONTAL, false)
        }

        val currentAdapter = facView.adapter
        if (currentAdapter !is FacilityAdapter || currentAdapter.needsUpdate(f.homeAmenities, f.roomSize, f.numOfBath, f.numOfBed)) {
            val facilityAdapter = FacilityAdapter(f.homeAmenities, f.roomSize, f.numOfBath, f.numOfBed, f.roomType)
            facView.adapter = facilityAdapter
        }

        holder.updateFavoriteIcon(f.isFavorite)
        fn(holder, f)

    }

    class FacilityAdapter(
        private val amenities: List<String>,
        private val roomSize: Double,
        private val numBath: Int,
        private val numBed: Int,
        private val roomType: String
    ) : RecyclerView.Adapter<FacilityAdapter.FacilityViewHolder>() {

        private val VIEW_TYPE_ROOM_SIZE = 0
        private val VIEW_TYPE_BATHROOM = 1
        private val VIEW_TYPE_BEDROOM = 2
        private val VIEW_TYPE_ROOM_TYPE = 3
        private val VIEW_TYPE_AMENITY = 4


        // ViewHolder for Facility Items
        class FacilityViewHolder(val binding: ItemFacilityBinding) : RecyclerView.ViewHolder(binding.root)
        fun needsUpdate(amenities: List<String>, roomSize: Double, numBath: Int, numBed: Int): Boolean {
            return this.amenities != amenities || this.roomSize != roomSize || this.numBath != numBath || this.numBed != numBed || this.roomType != roomType
        }

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): FacilityViewHolder {
            val inflater = LayoutInflater.from(parent.context)
            val binding = ItemFacilityBinding.inflate(inflater, parent, false)
            return FacilityViewHolder(binding)
        }

        override fun onBindViewHolder(holder: FacilityViewHolder, position: Int) {
            when (getItemViewType(position)) {
                VIEW_TYPE_ROOM_SIZE -> {
                    holder.binding.imgIcon.setImageResource(R.drawable.ic_room_size)
                    holder.binding.txtFacility.text = "$roomSize sq ft"
                    holder.binding.imgIcon.visibility = View.VISIBLE
                    holder.binding.txtFacility.visibility = View.VISIBLE
                }
                VIEW_TYPE_BATHROOM -> {
                    holder.binding.imgIcon.setImageResource(R.drawable.bathtub)
                    holder.binding.txtFacility.text = "$numBath Bathroom${if (numBath > 1) "s" else ""}"
                    holder.binding.imgIcon.visibility = View.VISIBLE
                    holder.binding.txtFacility.visibility = View.VISIBLE
                }
                VIEW_TYPE_BEDROOM -> {
                    holder.binding.imgIcon.setImageResource(R.drawable.icon_bedroom)
                    holder.binding.txtFacility.text = "$numBed Bedroom${if (numBed > 1) "s" else ""}"
                    holder.binding.imgIcon.visibility = View.VISIBLE
                    holder.binding.txtFacility.visibility = View.VISIBLE
                }
                VIEW_TYPE_ROOM_TYPE -> {
                    holder.binding.imgIcon.setImageResource(R.drawable.ic_room_type)
                    holder.binding.txtFacility.text = "$roomType"
                    holder.binding.imgIcon.visibility = View.VISIBLE
                    holder.binding.txtFacility.visibility = View.VISIBLE
                }
                VIEW_TYPE_AMENITY -> {
                    val amenity = amenities[position - getExtraItemCount()]
                    val iconResId = when (amenity) {
                        "Wi-Fi" -> R.drawable.ic_wifi
                        "TV" -> R.drawable.ic_tv
                        "Air-Conditioner" -> R.drawable.ic_air_conditioner
                        "Washing Machine" -> R.drawable.washing_machine
                        else -> R.drawable.ic_unknown
                    }
                    holder.binding.imgIcon.setImageResource(iconResId)
                    holder.binding.txtFacility.text = amenity
                    holder.binding.imgIcon.visibility = View.VISIBLE
                    holder.binding.txtFacility.visibility = View.VISIBLE
                }

            }
        }

        override fun getItemViewType(position: Int): Int {
            return when (position) {
                0 -> if (roomSize > 0) VIEW_TYPE_ROOM_SIZE else getItemViewTypeForPosition(position)
                1 -> if (numBath > 0) VIEW_TYPE_BATHROOM else getItemViewTypeForPosition(position)
                2 -> if (numBed > 0) VIEW_TYPE_BEDROOM else getItemViewTypeForPosition(position)
                3 -> VIEW_TYPE_ROOM_TYPE
                else -> VIEW_TYPE_AMENITY
            }
        }

        private fun getItemViewTypeForPosition(position: Int): Int {
            var adjustedPosition = position
            if (roomSize <= 0 && adjustedPosition == 0) adjustedPosition++
            if (numBath <= 0 && adjustedPosition == 1) adjustedPosition++
            if (numBed <= 0 && adjustedPosition == 2) adjustedPosition++
            if (roomType.isEmpty() && adjustedPosition == 3) adjustedPosition++
            return if (adjustedPosition >= 4) VIEW_TYPE_AMENITY else adjustedPosition

        }

        private fun getExtraItemCount(): Int {
            var count = 0
            if (roomSize > 0) count++
            if (numBath > 0) count++
            if (numBed > 0) count++
            if (roomType.isNotEmpty()) count++
            return count
        }

        override fun getItemCount(): Int {
            return getExtraItemCount() + amenities.size
        }
    }

}