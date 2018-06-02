package org.ayiyikoh.model

import java.util.*

data class Menu(val id:Long,
                var name:String,
                var is_published:Boolean,
                var published_at:Long,
                var menu_date:Date,
                var created_at:Long,
                var updated_at:Long)