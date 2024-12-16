package com.example.assignment.ui

import android.location.Geocoder
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.example.assignment.databinding.FragmentSearchmapBinding
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import android.location.Address
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.core.os.bundleOf
import androidx.navigation.fragment.findNavController
import com.example.assignment.MainActivity
import com.example.assignment.R
import com.google.android.gms.maps.SupportMapFragment
import java.io.IOException
import com.example.assignment.util.toast
import com.google.android.gms.maps.model.CircleOptions

class SearchLocation : Fragment(), OnMapReadyCallback {


    private lateinit var mMap: GoogleMap
    private lateinit var binding: FragmentSearchmapBinding
    private val nav by lazy { findNavController() }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = FragmentSearchmapBinding.inflate(inflater, container, false)

        var latitude: Double = 0.0
        var longitude: Double = 0.0
        var locationName: String = ""

        binding.mapsearch.setOnQueryTextListener(object : android.widget.SearchView.OnQueryTextListener{
            override fun onQueryTextSubmit(name: String): Boolean{
                var location: String = binding.mapsearch.query.toString()
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
                    locationName = address.getAddressLine(0)
                    latitude = address.latitude
                    longitude = address.longitude
                    updateMap(latLng, location)
                }
                return false
            }
            override fun onQueryTextChange(name: String): Boolean {
                return false
            }

        })

        binding.btnSearchAddress.setOnClickListener {
            if (latitude != 0.0 && longitude != 0.0 && locationName.isNotEmpty()) {
                nav.navigate(
                    R.id.homeFragment, bundleOf(
                        "latitude" to latitude.toString(),
                        "longitude" to longitude.toString(),
                        "location" to locationName
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

    private fun updateMap(latLng: LatLng, location: String) {
        mMap.clear()
        mMap.addMarker(MarkerOptions().position(latLng).title(location))
        mMap.animateCamera(CameraUpdateFactory.newLatLngZoom(latLng, 10F))
        binding.tvAddressLine.text = location
        drawCircle(latLng, 1000.0) // Example radius of 1000 meters
    }

    private fun drawCircle(latLng: LatLng, radius: Double) {
        val circleOptions = CircleOptions()
            .center(latLng)
            .radius(radius)
            .strokeWidth(3f)
            .strokeColor(0x550000FF) // Semi-transparent blue stroke
            .fillColor(0x220000FF) // Semi-transparent blue fill
        mMap.addCircle(circleOptions)
    }

    override fun onMapReady(googleMap: GoogleMap) {
        mMap = googleMap
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