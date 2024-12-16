package com.example.assignment.util

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.assignment.R
import com.example.assignment.data.AuthVM
import com.example.assignment.data.Favorite
import com.example.assignment.data.Room
import com.example.assignment.data.RoomVM
import com.example.assignment.databinding.ItemRoomdetailsBinding
import com.google.rpc.context.AttributeContext.Auth

class FavoriteAdapter (
    private val roomVM: RoomVM,
    private val auth: AuthVM,
    val fn: (ViewHolder, Favorite) -> Unit = { _, _ -> }
) : ListAdapter<Favorite, FavoriteAdapter.ViewHolder>(Diff) {

    companion object Diff : DiffUtil.ItemCallback<Favorite>() {
        override fun areItemsTheSame(a: Favorite, b: Favorite) = a.roomId == b.roomId
        override fun areContentsTheSame(a: Favorite, b: Favorite) = a == b
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

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val binding = ItemRoomdetailsBinding.inflate(inflater, parent, false)
        return ViewHolder(binding)
    }
    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val f = getItem(position)
        val room = roomVM.get(f.roomId)
        if (room != null) {
            f.room = room
        }

        val imageSlider = holder.binding.imageSlider
        val imageSliderAdapter = ImageSliderAdapter(f.room.photo)
        imageSlider.adapter = imageSliderAdapter

        f.room.isFavorite = true
            holder.binding.txtPrice.text = "RM %.2f".format(f.room.roomPrice)
            holder.binding.txtAddress.text = f.room.roomPlace
            holder.binding.txtRoomName.text = f.room.roomName

            val facView = holder.binding.facView

            if (facView.layoutManager == null) {
                facView.layoutManager = LinearLayoutManager(
                    holder.itemView.context,
                    LinearLayoutManager.HORIZONTAL,
                    false
                )
            }

            val currentAdapter = facView.adapter
            if (currentAdapter !is RoomAdapter.FacilityAdapter || currentAdapter.needsUpdate(
                    f.room.homeAmenities,
                    f.room.roomSize,
                    f.room.numOfBath,
                    f.room.numOfBed
                )
            ) {
                val facilityAdapter = RoomAdapter.FacilityAdapter(
                    f.room.homeAmenities,
                    f.room.roomSize,
                    f.room.numOfBath,
                    f.room.numOfBed,
                    f.room.roomType
                )
                facView.adapter = facilityAdapter
            }

            holder.updateFavoriteIcon(f.room.isFavorite)
            fn(holder, f)

    }

}