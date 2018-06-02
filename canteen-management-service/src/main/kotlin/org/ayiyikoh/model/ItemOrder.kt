package org.ayiyikoh.model

data class ItemOrder(val id:Long,
                     var meal_id:Long,
                     var order_reference:String,
                     var drink_id:Long,
                     var quantity:Long,
                     var is_meal:Boolean,
                     var price:String,
                     var created_at:Long,
                     var updated_at:Long)