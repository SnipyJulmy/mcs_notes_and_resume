package ch.snipy.thingyClientYellow.animal

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import ch.snipy.thingyClientYellow.Animal
import ch.snipy.thingyClientYellow.R

class AnimalsFragment : Fragment() {

    // For the recycler view
    private lateinit var recyclerView: RecyclerView
    private lateinit var viewAdapter: RecyclerView.Adapter<*>
    private lateinit var viewManager: RecyclerView.LayoutManager

    // For API call
    // TODO

    companion object {
        fun newInstance() = AnimalsFragment()
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val rootView = inflater.inflate(R.layout.animals_fragment, container, false)
        viewManager = LinearLayoutManager(activity)
        viewAdapter = AnimalAdapter(
            dataset = arrayOf(
                Animal(null, "Cat"),
                Animal(null, "Dog")
            )
        ) // TODO call the API

        recyclerView = rootView.findViewById<RecyclerView>(R.id.animals_recycler_view).apply {
            setHasFixedSize(true)
            layoutManager = viewManager
            adapter = viewAdapter
        }
        return rootView
    }
}