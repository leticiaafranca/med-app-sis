import express from "express";
import ConsultaController from "../controllers/consultasController.js";

const router = express.Router();

router
  .get("/consultas", ConsultaController.listarConsultas)
  .get("/consultas/:id", ConsultaController.listarConsultaPorId)
  .post("/consultas", ConsultaController.cadastrarConsulta)
  .put("/consultas/:id", ConsultaController.atualizarConsulta)
  .delete("/consultas/:id", ConsultaController.excluirConsulta)

export default router;
