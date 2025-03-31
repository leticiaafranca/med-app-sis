import consultas from "../models/Consulta.js";

class ConsultaController {

  static listarConsultas = (req, res) => {
    consultas.find()
      .populate('paciente')
      .exec((err, consultas) => {
        res.status(200).json(consultas);
    });
  }

  static listarConsultaPorId = (req, res) => {
    const id = req.params.id;

    consultas.findById(id)
      .populate('paciente', 'nome')
      .exec((err, consulta) => {
      if (err) {
        res.status(400).send({ message: `${err.message} - Id da consulta não localizado.` });
      } else {
        res.status(200).send(consulta);
      }
    });
  }

  static cadastrarConsulta = (req, res) => {
    let consulta = new consultas(req.body);

    consulta.save((err) => {
      if (err) {
        res.status(500).send({ message: `${err.message} - falha ao cadastrar consulta.` });
      } else {
        res.status(201).send(consulta.toJSON());
      }
    });
  }

  static atualizarConsulta = (req, res) => {
    const id = req.params.id;

    consultas.findByIdAndUpdate(id, { $set: req.body }, (err) => {
      if (!err) {
        res.status(200).send({ message: 'Consulta atualizada com sucesso' });
      } else {
        res.status(500).send({ message: err.message });
      }
    });
  }

  static excluirConsulta = (req, res) => {
    const id = req.params.id;

    consultas.findByIdAndDelete(id, (err) => {
      if (!err) {
        res.status(200).send({ message: 'Consulta removida com sucesso' });
      } else {
        res.status(500).send({ message: err.message });
      }
    });
  }

  static listarConsultasPorMedico = (req, res) => {
    const medico = req.query.medico;

    consultas.find({ 'medico': medico }, {}, (err, consultas) => {
      res.status(200).send(consultas);
    });
  }

}

export default ConsultaController;
