import mongoose from "mongoose";

const pacienteSchema = new mongoose.Schema(
  {
    id: { type: String },
    nome: { type: String, required: true },
    dataNascimento: { type: Date, required: true },
    sexo: { type: String, enum: ['Masculino', 'Feminino', 'Outro'], required: true },
    cpf: { type: String, required: true, unique: true },
    endereco: { 
        rua: { type: String },
        numero: { type: String },
        bairro: { type: String },
        cidade: { type: String },
        estado: { type: String },
        cep: { type: String }
    },
    telefone: { type: String },
    email: { type: String, unique: true },
    medico: [{ type: mongoose.Schema.Types.ObjectId, ref: 'medicos' }]
  },
  {
    versionKey: false
  }
)

const pacientes = mongoose.model("pacientes", pacienteSchema)

export default pacientes;