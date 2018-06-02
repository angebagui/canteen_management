package org.ayiyikoh.model

data class Invoice(val id:Long,
                   var reference:String,
                   var customer_name:String,
                   var customer_address:String,
                   var customer_email:String,
                   var customer_phone:String,
                   var order_reference:String,
                   var amount:String,
                   var is_paid:Boolean,
                   var created_at:Long,
                   var updated_at:Long)