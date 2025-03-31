import express from "express";
import livros from "./consultasRoutes.js"
import autores from "./pacientesRoutes.js"

const routes = (app) => {
  app.route('/').get((req, res) => {
    res.status(200).send({titulo: "API Int-Sistemas"})
  })

  app.use(
    express.json(),
    livros,
    autores
  )
}

export default routes