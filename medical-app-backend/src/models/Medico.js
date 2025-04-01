import mongoose from "mongoose";

const medicoSchema = new mongoose.Schema(
  {
    id: { type: String },
    nome: { type: String, required: true },
    crm: { type: String, required: true },
    especialidade: { type: String, required: true },
    endereco: { type: String },
    telefone: { type: String },
    email: { type: String },
    horariosAtendimento: [{
        dia: { type: String, required: true },
        horaInicio: { type: String, required: true },
        horaFim: { type: String, required: true },
        paciente: { type: mongoose.Schema.Types.ObjectId, ref: 'pacientes' },
        consulta: { type: mongoose.Schema.Types.ObjectId, ref: 'consultas' } 
    }],
        paciente: [{ type: mongoose.Schema.Types.ObjectId, ref: 'pacientes' }]
  },
  {
    versionKey: false
  }
)

const medicos = mongoose.model("medicos", medicoSchema)

export default medicos;
