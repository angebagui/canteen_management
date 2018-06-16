package org.ayiyikoh.service

import io.vertx.core.Vertx
import io.vertx.core.json.JsonObject
import io.vertx.ext.jdbc.JDBCClient
import io.vertx.ext.sql.SQLConnection

abstract class BaseService(vertx: Vertx, config:JsonObject) {

    val client = JDBCClient.createShared(vertx, config)

    fun connection(success:(SQLConnection)->Unit, failure: (Throwable)->Unit ){
        client.getConnection {
            if(it.succeeded()){
                success(it.result())
            }else{
                failure(it.cause())
            }
        }
    }


}