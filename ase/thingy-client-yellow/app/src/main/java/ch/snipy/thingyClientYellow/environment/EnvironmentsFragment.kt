package ch.snipy.thingyClientYellow.environment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import ch.snipy.thingyClientYellow.R

// Fragment which show all the environments for a specific user
class EnvironmentsFragment : Fragment() {

    // For the recycler view
    private lateinit var recyclerView: RecyclerView
    private lateinit var viewAdapter: RecyclerView.Adapter<*>
    private lateinit var viewManager: RecyclerView.LayoutManager

    // For API call
    // TODO

    companion object {
        fun newInstance() = EnvironmentsFragment()
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val rootView = inflater.inflate(R.layout.environments_fragment, container, false)
        viewManager = LinearLayoutManager(activity)
        viewAdapter = EnvironmentAdapter(dataset = arrayOf("Env1", "Env2")) // TODO call the API

        recyclerView = rootView.findViewById<RecyclerView>(R.id.environments_recycler_view).apply {
            setHasFixedSize(true)
            layoutManager = viewManager
            adapter = viewAdapter
        }
        return rootView
    }
}
