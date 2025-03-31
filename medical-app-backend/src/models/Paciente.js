import mongoose from "mongoose";

const pacienteSchema = new mongoose.Schema(
  {
    id: { type: String },
    nome: { type: String, required: true },
    idade: { type: Number },
    endereco: { type: String },
    telefone: { type: String },
    email: { type: String }
  },
  {
    versionKey: false
  }
)

const pacientes = mongoose.model("pacientes", pacienteSchema)

export default pacientes;
