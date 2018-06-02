package org.ayiyikoh.controller

import io.vertx.core.AbstractVerticle
import io.vertx.core.Future
import io.vertx.core.Handler
import io.vertx.core.json.Json
import io.vertx.core.json.JsonArray
import io.vertx.core.json.JsonObject
import io.vertx.ext.web.Router
import io.vertx.ext.web.RoutingContext
import io.vertx.ext.web.handler.BodyHandler
import io.vertx.ext.jdbc.JDBCClient
import org.ayiyikoh.model.User

class MainVerticle: AbstractVerticle() {

    override fun start(startFuture: Future<Void>) {
        super.start(startFuture)



        val router = createRouter()

        vertx.createHttpServer()
                .requestHandler{
                    router.accept(it)
                }
                .listen(config().getInteger("http.port", 8080)) { result ->
                    if (result.succeeded()) {
                        startFuture.complete()
                    } else {
                        startFuture.fail(result.cause())
                    }
                }

    }


    private fun createRouter() = Router.router(vertx).apply {


        // body handler
        route().handler(BodyHandler.create())

        /**
         * Page index
         */
        get("/").handler(index)


        /**
         * POST /users/register
         * params: name, phone, email, role_code
         */
        post("/users/register").handler(registerUser())



    }

    // Handlers

    val index = Handler<RoutingContext> { req ->
        req.response().end("<h1>Welcome!</h1>")
    }

    /**
     * 1 - Register Users
     * 2 - Authenticate Users
     * 3 -  List Users
     */

    /**
     * POST /users/register
     * params: name, phone, email, role_code
     */
    fun registerUser() = Handler<RoutingContext>{
        val name = it.request().getParam("name")
        val phone = it.request().getParam("phone")
        val email = it.request().getParam("email")
        val roleCode = it.request().getParam("role_code")
        val password = it.request().getParam("password")


        if(name.isNullOrEmpty()){
            it.sendError("Name is not available")
        }


        val user =  User(-1,name, phone, email,password,roleCode)

        // Save user in database
        val config = createJdbcConfig()
        var client = JDBCClient.createShared(vertx, config)

        client.getConnection({ res ->
            if (res.succeeded()) {

                var connection = res.result()

                val params  = JsonArray()
                params.add(name)
                params.add(phone)
                params.add(email)
                params.add(password)
                params.add(roleCode)

                connection.queryWithParams("INSERT INTO users (name,phone, email, password, role_code) VALUES(?,?,?,?,?)", params, { res2 ->
                    if (res2.succeeded()) {

                        val resultSql = res2.result()

                      //  println("LAST_INSERT_ID >>>"+resultSql)

                        // Do something with results

                        it.sendResponse(JsonObject(), "User saved")
                    }else{
                        it.sendError(res2.cause().message?:"Error service")
                    }
                })
            } else {
                // Failed to get connection - deal with it
                it.sendError(res.cause().message?:"Error service")
            }
        })


       val  result   = Json.encode(user)




    }

    private fun createJdbcConfig(): JsonObject {
        val config = JsonObject()
        config.put("service.type", "jdbc")
        config.put("url", "jdbc:mysql://localhost:8889/canteen_management_db_v1 ?characterEncoding=UTF-8&useSSL=false&zeroDateTimeBehavior=convertToNull")
        config.put("driver_class", "com.mysql.cj.jdbc.Driver")
        config.put("user", "root")
        config.put("password", "root")
        config.put("http.host", "0.0.0.0")
        config.put("http.port", 8080)
        return config
    }


    fun RoutingContext.sendError(message:String){
        val result = JsonObject()
        result.put("success", false)
        result.put("message", message)
       this.response().setStatusCode(400).putHeader("Content-Type", "application/json; charset=utf-8").end(result.encodePrettily())
    }


    fun RoutingContext.sendResponse(data:Any,message:String){
        val result = JsonObject()
        result.put("success", true)
        result.put("message", message)
        result.put("data", Json.encode(data))
        this.response().setStatusCode(200).putHeader("Content-Type", "application/json; charset=utf-8").end(result.encodePrettily())
    }
}