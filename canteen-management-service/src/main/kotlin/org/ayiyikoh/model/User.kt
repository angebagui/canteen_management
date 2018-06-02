package org.ayiyikoh.model

data class User(val id:Long,
                var name:String,
                var phone:String,
                var email:String,
                var password:String,
                var photo:String,
                var role_code:String,
                var created_at:Long,
                var updated_at:Long
)