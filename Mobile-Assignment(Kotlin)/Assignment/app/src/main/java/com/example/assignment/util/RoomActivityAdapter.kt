package com.example.assignment.util

import android.app.AlertDialog
import android.content.Context
import android.view.ContextMenu
import android.view.LayoutInflater
import android.view.MenuInflater
import android.view.MenuItem
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.core.os.bundleOf
import androidx.navigation.NavController
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.assignment.R
import com.example.assignment.data.FavoriteVM
import com.example.assignment.data.Room
import com.example.assignment.data.RoomVM
import com.example.assignment.databinding.ItemActivityRoomdetailsBinding
import com.example.assignment.ui.favorite


class RoomActivityAdapter (
    val fn: (ViewHolder, Room) -> Unit = { _, _ -> },
    private val postCountListener: PostCountListener
) : ListAdapter<Room, RoomActivityAdapter.ViewHolder>(Diff) {


    private var currentRoom: Room? = null

    companion object Diff : DiffUtil.ItemCallback<Room>() {
        override fun areItemsTheSame(a: Room, b: Room) = a.roomId == b.roomId
        override fun areContentsTheSame(a: Room, b: Room) = a == b
    }

    class ViewHolder(val binding: ItemActivityRoomdetailsBinding) : RecyclerView.ViewHolder(binding.root),
        View.OnCreateContextMenuListener {

        init {
            binding.root.setOnCreateContextMenuListener(this)
        }

        override fun onCreateContextMenu(menu: ContextMenu, v: View, menuInfo: ContextMenu.ContextMenuInfo?) {
            val inflater: MenuInflater = MenuInflater(v.context)
            inflater.inflate(R.menu.post_setting, menu)
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =
        ViewHolder(ItemActivityRoomdetailsBinding.inflate(LayoutInflater.from(parent.context), parent, false))

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val f = getItem(position)

//        holder.binding.roomImage.setImageBlob(f.photo[0])
//        holder.binding.imageContainer

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
        if (currentAdapter !is RoomAdapter.FacilityAdapter || currentAdapter.needsUpdate(f.homeAmenities, f.roomSize, f.numOfBath, f.numOfBed)) {
            val facilityAdapter =
                RoomAdapter.FacilityAdapter(f.homeAmenities, f.roomSize, f.numOfBath, f.numOfBed, f.roomType)
            facView.adapter = facilityAdapter
        }

        // Popup menu handling
        holder.binding.root.setOnLongClickListener {
            currentRoom = f // Store the current room when the context menu is shown
            holder.binding.root.showContextMenu()
            true
        }

        fn(holder, f)
    }

    override fun submitList(list: List<Room>?) {
        super.submitList(list)
        postCountListener.onPostCountUpdated(list?.size ?: 0)
    }

    fun onContextItemSelected(item: MenuItem, nav: NavController, viewModel: RoomVM, context: Context, favoriteVM: FavoriteVM): Boolean {
        return when (item.itemId) {
            R.id.opt1 -> {
                currentRoom?.let { room ->
                    nav.navigate(R.id.activityUpdatePost, bundleOf(
                        "roomId" to room.roomId
                    ))
                }
                true
            }
            R.id.opt2 -> {
                currentRoom?.let { room ->
                    showDeleteConfirmationDialog(room, viewModel, context, favoriteVM)
                }
                true
            }
            else -> false
        }
    }

    private fun showDeleteConfirmationDialog(room: Room, viewModel: RoomVM, context: Context, favoriteVM: FavoriteVM) {
        AlertDialog.Builder(context)
            .setTitle("Delete Room")
            .setMessage("Are you sure you want to delete this room?")
            .setPositiveButton("Confirm") { dialog, _ ->
                viewModel.delete(room.roomId)
                favoriteVM.deleteByRoomId(room.roomId)
                Toast.makeText(context, "Room deleted", Toast.LENGTH_SHORT).show()
                dialog.dismiss()
            }
            .setNegativeButton("Cancel") { dialog, _ ->
                Toast.makeText(context, "Delete cancelled", Toast.LENGTH_SHORT).show()
                dialog.dismiss()
            }
            .create()
            .show()
    }


}