package ch.snipy.thingyClientYellow.routes

import ch.snipy.thingyClientYellow.User
import retrofit2.Call
import retrofit2.Retrofit
import retrofit2.http.*


interface DyrAccountService {
    @POST("/register")
    fun register(@Body body: User): Call<User>

    @POST("/connect")
    fun connect(@Body body: User): Call<User>

    @PATCH("/update/{userId}")
    fun update(@Path("userId") userId: Int): Call<User>

    @DELETE("/delete/{userId}")
    fun delete(@Path("userId") userId: Int): Call<String>

    companion object Factory {
        fun create(): DyrAccountService {
            val retrofit = Retrofit.Builder()
                .addConverterFactory(null) // TODO
                .baseUrl("/account")
                .build()
            return retrofit.create(DyrAccountService::class.java)
        }
    }
}