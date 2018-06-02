package org.ayiyikoh.model

data class Payment(val id:Long,
                   var invoice_reference:String,
                   var payment_method:String,
                   var payment_reference:String,
                   var amount:String,
                   var id_admin_paid:Long,
                   var created_at:Long,
                   var updated_at:Long)