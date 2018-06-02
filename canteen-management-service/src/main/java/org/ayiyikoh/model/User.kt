package org.ayiyikoh.model

data class User(val id:Long = -1,
                var name:String,
                var phone:String,
                var email:String,
                var password:String = "123456789",
                var photo:String = "#",
                var role_code:String = "customer",
                var created_at:Long = System.currentTimeMillis(),
                var updated_at:Long = System.currentTimeMillis()
)