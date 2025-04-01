import mongoose from "mongoose";

const consultaSchema = new mongoose.Schema(
  {
    id: { type: String },
    dataConsulta: { type: Date, required: true },
    motivo: { type: String, required: true },
    diagnostico: { type: String },
    tratamento: { type: String },
    medico: { type: mongoose.Schema.Types.ObjectId, ref: 'medicos', required: true }, 
    paciente: { type: mongoose.Schema.Types.ObjectId, ref: 'pacientes', required: true }, 
    prescricao: { type: mongoose.Schema.Types.ObjectId, ref: 'prescricoes'}, 
    horarioConsulta: { 
        dia: { type: String, required: true },
        horaInicio: { type: String, required: true },
        horaFim: { type: String, required: true } 
    },
    observacoes: { type: String }
  }
);

const consultas = mongoose.model('consultas', consultaSchema);

export default consultas;