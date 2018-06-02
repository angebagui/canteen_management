package org.ayiyikoh.model

data class PaymentReceipt(val id:Long,
                          var reference:String,
                          var invoice_reference:String,
                          var payment_reference:String,
                          var created_at:Long,
                          var updated_at:Long)