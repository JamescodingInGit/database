package com.example.assignment.util

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.assignment.R
import com.example.assignment.data.DataClass

class helpCentreAdapter(private val dataList: ArrayList<DataClass>): RecyclerView.Adapter<helpCentreAdapter.ViewHolderClass>() {
    var onItemClick: ((DataClass) -> Unit)? = null
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolderClass {
        val itemView = LayoutInflater.from(parent.context).inflate(R.layout.help_layout, parent, false)
        return ViewHolderClass(itemView)
    }
    override fun onBindViewHolder(holder: ViewHolderClass, position: Int) {
        val currentItem = dataList[position]
        holder.rvImage.setImageResource(currentItem.dataImage)
        holder.rvTitle.text = currentItem.dataTitle
        holder.rvMessage.text = currentItem.dataDesc
        holder.itemView.setOnClickListener{
            onItemClick?.invoke(currentItem)
        }
    }
    override fun getItemCount(): Int {
        return dataList.size
    }
    class ViewHolderClass(itemView: View): RecyclerView.ViewHolder(itemView) {
        val rvImage:ImageView = itemView.findViewById(R.id.image)
        val rvTitle:TextView = itemView.findViewById(R.id.title)
        val rvMessage:TextView = itemView.findViewById(R.id.message)
    }
}