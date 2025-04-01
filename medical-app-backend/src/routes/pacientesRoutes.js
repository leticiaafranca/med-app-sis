import express from "express";
import PacienteController from "../controllers/pacientesController.js";

const router = express.Router();

router
  .get("/pacientes", PacienteController.listarPacientes)
  .get("/pacientes/:id", PacienteController.listarPacientePorId) 
  .post("/pacientes", PacienteController.cadastrarPaciente) 
  .get("/pacientes/medico/:id", PacienteController.listarPacientesPorMedico)
  .put("/pacientes/:id", PacienteController.atualizarPaciente)
  .delete("/pacientes/:id", PacienteController.excluirPaciente)

export default router;
