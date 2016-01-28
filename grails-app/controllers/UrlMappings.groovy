class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller:"index")
        "/optimizelogin"(view:"/optimizelogin")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
