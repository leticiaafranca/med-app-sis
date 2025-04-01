import medicos from "../models/Medico.js";

class MedicoController {

  static listarMedicos = (req, res) => {
    medicos.find((err, medicos) => {
      res.status(200).json(medicos);
    });
  }

  static listarMedicoPorId = (req, res) => {
    const id = req.params.id;

    medicos.findById(id, (err, medico) => {
      if (err) {
        res.status(400).send({ message: `${err.message} - Id do Medico não localizado.` });
      } else {
        res.status(200).send(medico);
      }
    });
  }

  static cadastrarMedico = (req, res) => {
    let medico = new medicos(req.body);

    medico.save((err) => {
      if (err) {
        res.status(500).send({ message: `${err.message} - falha ao cadastrar Medico.` });
      } else {
        res.status(201).send(medico.toJSON());
      }
    });
  }

  static atualizarMedico = (req, res) => {
    const id = req.params.id;

    medicos.findByIdAndUpdate(id, { $set: req.body }, (err) => {
      if (!err) {
        res.status(200).send({ message: 'Médico atualizado com sucesso' });
      } else {
        res.status(500).send({ message: err.message });
      }
    });
  }

  static excluirMedico = (req, res) => {
    const id = req.params.id;

    medicos.findByIdAndDelete(id, (err) => {
      if (!err) {
        res.status(200).send({ message: 'Médico removido com sucesso' });
      } else {
        res.status(500).send({ message: err.message });
      }
    });
  }

}

export default MedicoController;
