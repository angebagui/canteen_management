package org.ayiyikoh.model

data class Order(val id:Long,
                 var reference:String,
                 var customer_id:Long,
                 var is_validated:Boolean,
                 var validation_date:Long,
                 var id_admin_validation:Long,
                 var created_at:Long,
                 var updated_at:Long)