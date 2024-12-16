package com.example.assignment.ui

import android.annotation.SuppressLint
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.widget.SearchView
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.assignment.R
import com.example.assignment.data.DataClass
import com.example.assignment.util.helpCentreAdapter
import com.example.assignment.databinding.FragmentHelpCentreBinding
import java.util.Locale


class HelpCentre : Fragment() {

    private lateinit var binding: FragmentHelpCentreBinding
    private val nav by lazy { findNavController() }

    private lateinit var recyclerView: RecyclerView
    private lateinit var dataList: ArrayList<DataClass>
    lateinit var imageList:Array<Int>
    lateinit var titleList:Array<String>
    lateinit var descList: Array<String>
    private lateinit var myAdapter: helpCentreAdapter
    private lateinit var searchView: SearchView
    private lateinit var searchList: ArrayList<DataClass>

    @SuppressLint("SuspiciousIndentation")
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding = FragmentHelpCentreBinding.inflate(inflater, container, false)

        imageList = arrayOf(
            R.drawable.helpcentre_roomrtl,
            R.drawable.helpcentre_furn,
            R.drawable.helpcentre_avdscam,
            R.drawable.helpcentre_roomfil,
            R.drawable.helpcentre_commit,
            R.drawable.helpcentre_cleanhome,
            R.drawable.helpcentre_rules,
            R.drawable.helpcentre_exactrent,
            R.drawable.helpcentre_policy,
        )

        titleList = arrayOf(
            "What is Room Rental",
            "Is Room furnished",
            "Ways Avoid scam",
            "Confused by Room filter",
            "Resident & Guest Commitments",
            "Who cleans the home",
            "House Rules",
            "What is the exact rent",
            "COVID-19 Policies"
        )


        descList = arrayOf(
            getString(R.string.RoomRental),
            getString(R.string.RoomFurnished),
            getString(R.string.Scam),
            getString(R.string.RoomFilter),
            getString(R.string.Commitments),
            getString(R.string.Cleans),
            getString(R.string.Rules),
            getString(R.string.ExactRent),
            getString(R.string.COVID)
        )

        recyclerView = binding.root.findViewById(R.id.recyclerView)
        searchView = binding.root.findViewById(R.id.search)
        recyclerView.layoutManager = LinearLayoutManager(context)
        recyclerView.setHasFixedSize(true)
        dataList = arrayListOf<DataClass>()
        searchList = arrayListOf<DataClass>()
        getData()
        searchView.clearFocus()
        searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                searchView.clearFocus()
                return true
            }

            @SuppressLint("NotifyDataSetChanged")
            override fun onQueryTextChange(newText: String?): Boolean {
                searchList.clear()
                val searchText = newText!!.toLowerCase(Locale.getDefault())
                if (searchText.isNotEmpty()) {
                    dataList.forEach {
                        if (it.dataTitle.lowercase(Locale.getDefault()).contains(searchText)) {
                            searchList.add(it)
                        }
                    }
                    recyclerView.adapter!!.notifyDataSetChanged()
                } else {
                    searchList.clear()
                    searchList.addAll(dataList)
                    recyclerView.adapter!!.notifyDataSetChanged()
                }
                return false
            }
        })
        myAdapter = helpCentreAdapter(searchList)
        recyclerView.adapter = myAdapter

                return binding.root

            }
            private fun getData() {
                for (i in imageList.indices) {
                    val dataClass =
                        DataClass(imageList[i], titleList[i], descList[i])
                    dataList.add(dataClass)
                }
                searchList.addAll(dataList)
                recyclerView.adapter = helpCentreAdapter(searchList)
            }


}