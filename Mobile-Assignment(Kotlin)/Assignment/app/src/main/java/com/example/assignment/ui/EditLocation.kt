package com.example.assignment.ui

import android.location.Geocoder
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import android.location.Address
import androidx.core.os.bundleOf
import androidx.navigation.fragment.findNavController
import com.example.assignment.MainActivity
import com.example.assignment.R
import com.example.assignment.databinding.FragmentEditmapBinding
import com.google.android.gms.maps.SupportMapFragment
import java.io.IOException
import com.example.assignment.util.toast

class EditLocation : Fragment(), OnMapReadyCallback {


    private lateinit var mMap: GoogleMap
    private lateinit var binding: FragmentEditmapBinding
    private val nav by lazy { findNavController() }
    private val place by lazy { arguments?.getString("place") ?: "" }
    private val roomId by lazy { arguments?.getString("roomId") ?: "" }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentEditmapBinding.inflate(inflater, container, false)

        var latitude: Double = 0.0
        var longitude: Double = 0.0
        var locationName: String = ""

        binding.mapsearch.setOnQueryTextListener(object : android.widget.SearchView.OnQueryTextListener{
            override fun onQueryTextSubmit(name: String): Boolean{
                var location: String = binding.mapsearch.query.toString()
                var addressList: List<Address> = listOf()
                if(location != null){
                    addressList = setLocation(location)
                    locationName = addressList.get(0).getAddressLine(0)
                    latitude = addressList.get(0).latitude
                    longitude = addressList.get(0).longitude
                }
                return false
            }
            override fun onQueryTextChange(name: String): Boolean {
                return false
            }

        })

        binding.btnEditAddress.setOnClickListener {
            if (latitude != 0.0 && longitude != 0.0 && locationName.isNotEmpty()) {
                nav.navigate(
                    R.id.activityUpdatePost, bundleOf(
                        "latitude" to latitude.toString(),
                        "longitude" to longitude.toString(),
                        "location" to locationName,
                        "roomId" to roomId
                    )
                )
            } else {
                toast("Please search for a location first.")
            }
        }
        val mapFragment = childFragmentManager.findFragmentById(R.id.map) as SupportMapFragment
        mapFragment.getMapAsync(this)
        return binding.root
    }


    override fun onMapReady(googleMap: GoogleMap) {
        mMap = googleMap
    }

    fun setLocation(location: String): List<Address> {
        var addressList: List<Address> = listOf()
        if(location != null){
            var geocoder: Geocoder = Geocoder(requireContext())

            try{
                addressList = geocoder.getFromLocationName(location,1) as List<Address>

            }catch (e: IOException){
                e.printStackTrace()
            }

            val address: Address = addressList.get(0)
            val latLng: LatLng = LatLng(address.latitude,address.longitude)
            mMap.clear()
            mMap.addMarker(MarkerOptions().position(latLng).title(location))
            mMap.animateCamera(CameraUpdateFactory.newLatLngZoom(latLng, 10F))
            binding.tvAddressLine.text = address.getAddressLine(0)
        }
        return addressList
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