package ch.snipy.thingyClientYellow

import com.google.gson.annotations.SerializedName

typealias Token = String

data class User(
    @SerializedName("token") val token: Token?,
    @SerializedName("id") val id: Int?,
    @SerializedName("email") val email: String,
    @SerializedName("password") val password: String
)

data class Environment(
    @SerializedName("id") val id: Int?,
    @SerializedName("name") val name: String,
    @SerializedName("env_type") val envType: String,
    @SerializedName("animals") val animals: List<Animal>,
    @SerializedName("humidity") val humidity: Double,
    @SerializedName("temperature") val temperature: Double,
    @SerializedName("luminosity") val luminosity: Double,
    @SerializedName("humidity_notif") val humidityNotification: Boolean,
    @SerializedName("temperature_notif") val temperatureNotification: Boolean,
    @SerializedName("luminosity_notif") val luminosityNotification: Boolean
)

data class Animal(
    @SerializedName("id") val id: Int?,
    @SerializedName("name") val name: String
)