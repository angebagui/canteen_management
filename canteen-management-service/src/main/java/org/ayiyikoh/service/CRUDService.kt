package org.ayiyikoh.service

import io.vertx.core.json.JsonObject

interface CRUDService<T> {

    fun createAsync(element:T, success: (JsonObject)->Unit, failure: (Throwable)->Unit)

    //READ
    fun findAllAsync(success: (List<JsonObject>)->Unit, failure: (Throwable)->Unit)

    fun findOneAsync(id: Long, success: (JsonObject)->Unit, failure: (Throwable)->Unit)

    fun updateAsync(element:T, success: (T)->Unit, failure: (Throwable)->Unit)

    fun deleteAsync(element:T, success: (T)->Unit, failure: (Throwable)->Unit)
}