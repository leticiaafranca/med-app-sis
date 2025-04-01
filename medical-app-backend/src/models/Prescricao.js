import mongoose from "mongoose";

const prescricaoSchema = new mongoose.Schema(
  {
    id: { type: String },
    nomeMedicamento: { type: String, required: true },
    formaFarmaceutica: { type: String, required: true },
    concentracao: { type: String },
    posologia: { type: String, required: true },
    modoUso: { type: String },
    dataInicio: { type: Date, required: true },
    dataTermino: { type: Date },
    quantidade: { type: Number, required: true },
    quantidadeTotalDias: { type: Number, required: true },
    observacoes: { type: String },
    medico: { type: mongoose.Schema.Types.ObjectId, ref: 'medicos' },
    paciente: { type: mongoose.Schema.Types.ObjectId, ref: 'pacientes' }
  },
  {
    versionKey: false
  }
)

const prescricoes = mongoose.model("prescricoes", prescricaoSchema)

export default prescricoes;