package org.ayiyikoh.controller

import io.vertx.core.AbstractVerticle
import io.vertx.core.Future
import io.vertx.core.Handler
import io.vertx.ext.web.Router
import io.vertx.ext.web.RoutingContext

class MainVerticle: AbstractVerticle() {

    override fun start(startFuture: Future<Void>) {
        super.start(startFuture)

        val router = createRouter()

        vertx.createHttpServer()
                .requestHandler{
                    router.accept(it)
                }.listen(config().getInteger("http.port", 8080)) { result ->
                    if (result.succeeded()) {
                        startFuture.complete()
                    } else {
                        startFuture.fail(result.cause())
                    }
                }

    }


    private fun createRouter() = Router.router(vertx).apply {

        get("/").handler(index)

    }

    // Handlers

    val index = Handler<RoutingContext> { req ->
        req.response().end("<h1>Welcome!</h1>")
    }
}