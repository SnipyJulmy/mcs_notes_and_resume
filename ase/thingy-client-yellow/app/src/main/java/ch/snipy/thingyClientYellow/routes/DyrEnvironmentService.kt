package ch.snipy.thingyClientYellow.routes

import android.os.Environment
import retrofit2.Call
import retrofit2.Retrofit
import retrofit2.http.*

interface DyrEnvironmentService {

    @GET("/all/{userId}")
    fun getEnvironments(@Path("userId") userId: Int): Call<List<Environment>>

    @GET("/one/{envId}")
    fun getEnvironment(@Path("envId") envId: Int): Call<Environment>

    @POST("/{userId}")
    fun createEnvironment(@Path("userId") userId: Int): Call<Environment>

    @PATCH("/{envId}")
    fun updateEnvironment(@Path("envId") envId: Int): Call<Environment>

    @DELETE("/{envId}")
    fun deleteEnvironment(@Path("envId") envId: Int): Call<String>

    @PUT("/enableNotif/{envId}")
    fun enableNotification(@Path("envId") envId: Int, @Body body: Map<String, String>): Call<String>

    companion object Factory {
        fun create(): DyrEnvironmentService {
            val retrofit = Retrofit.Builder()
                .addConverterFactory(null) // TODO
                .baseUrl("/environment")
                .build()
            return retrofit.create(DyrEnvironmentService::class.java)
        }
    }
}