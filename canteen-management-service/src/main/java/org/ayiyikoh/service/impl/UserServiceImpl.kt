package org.ayiyikoh.service.impl

import io.vertx.core.Handler
import io.vertx.core.Vertx
import io.vertx.core.json.JsonArray
import io.vertx.core.json.JsonObject
import org.ayiyikoh.model.User
import org.ayiyikoh.service.BaseService
import org.ayiyikoh.service.UserService

class UserServiceImpl(vertx: Vertx, config: JsonObject) :BaseService(vertx,config),UserService{

    override fun createAsync(element: User, success: (JsonObject) -> Unit, failure: (Throwable) -> Unit) {

        val params  = JsonArray()
        params.add(element.name)
        params.add(element.phone)
        params.add(element.email)
        params.add(element.password)
        params.add(element.role_code)
        params.add(System.currentTimeMillis()/1000)
        params.add(System.currentTimeMillis()/1000)


        connection({
            //OnSuccess, we are connected
            it.queryWithParams("INSERT INTO users (name,phone, email, password, role_code,created_at,updated_at) VALUES(?,?,?,?,?,FROM_UNIXTIME(?),FROM_UNIXTIME(?))", params, {asyncRes->
                if(asyncRes.succeeded()){

                    it.query("SELECT last_insert_id() as id FROM users",{asyncRes2->

                        if(asyncRes2.succeeded()){
                            val id = asyncRes2.result().rows[0].getLong("id")

                            findOneAsync(id,{userJson->

                                success(userJson)

                            }, {throwable ->
                                failure(throwable)
                            })
                        }else{
                            failure(asyncRes2.cause())
                        }


                    })



                }else{
                    failure(asyncRes.cause())
                }
            })

        },{
            //onError, we have error
            failure(it)
        })



    }

    override fun findOneAsync(id: Long, success: (JsonObject) -> Unit, failure: (Throwable) -> Unit) {
        connection({
            //OnSuccess, we are connected
            val params  = JsonArray()
            params.add(id)
            it.queryWithParams("SELECT * FROM users WHERE id = ?", params, {asyncRes->
                if(asyncRes.succeeded()){

                    if(asyncRes.result() != null){
                        val result = asyncRes.result().rows
                        if(result.isNotEmpty()){
                            success(result[0])
                        }else{
                            failure(NullPointerException("Result is null"))
                        }
                    }else{
                        failure(NullPointerException("Result is null"))
                    }


                }else{
                    failure(asyncRes.cause())
                }
            })

        },{
            //onError, we have error
            failure(it)
        })
    }

    override fun findAllAsync(success: (List<JsonObject>) -> Unit, failure: (Throwable) -> Unit) {
        connection({
            //OnSuccess, we are connected
            it.query("SELECT * FROM users",  {asyncRes->
                if(asyncRes.succeeded()){
                    val result = asyncRes.result().rows
                    success(result)

                }else{
                    failure(asyncRes.cause())
                }
            })

        },{
            //onError, we have error
            failure(it)
        })
    }

    override fun updateAsync(element: User, success: (User) -> Unit, failure: (Throwable) -> Unit) {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }

    override fun deleteAsync(element: User, success: (User) -> Unit, failure: (Throwable) -> Unit) {
        TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
    }
}