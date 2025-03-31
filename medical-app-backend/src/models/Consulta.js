import mongoose from "mongoose";

const consultaSchema = new mongoose.Schema(
  {
    id: { type: String },
    paciente: { type: mongoose.Schema.Types.ObjectId, ref: 'pacientes', required: true },
    data: { type: Date, required: true },
    descricao: { type: String, required: true },
    medico: { type: String, required: true },
    especialidade: { type: String }
  }
);

const consultas = mongoose.model('consultas', consultaSchema);

export default consultas;
