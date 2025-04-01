import express from "express";
import PrescricaoController from "../controllers/prescricoesController.js";

const router = express.Router();

router
  .get("/prescricoes", PrescricaoController.listarPrescricoes)
  .get("/prescricoes/:id", PrescricaoController.listarPrescricaoPorId)
  .post("/prescricoes", PrescricaoController.cadastrarPrescricao)
  .put("/prescricoes/:id", PrescricaoController.atualizarPrescricao)
  .delete("/prescricoes/:id", PrescricaoController.excluirPrescricao)

export default router;
