import consultas from "../models/Consulta.js";

class ConsultaController {

  static listarConsultasPorMotivo = (req, res) => {
    const motivo = req.params.motivo;
  
    consultas.find({ motivo: motivo })
      .populate('paciente', 'nome')
      .populate('medico', 'nome')
      .exec((err, consultas) => {
        if (err) {
          return res.status(500).send({ message: `Erro ao buscar consultas pelo motivo ${motivo}: ${err.message}` });
        }
  
        if (!consultas || consultas.length === 0) {
          return res.status(404).send({ message: `Nenhuma consulta encontrada com o motivo ${motivo}.` });
        }
  
        res.status(200).json({
          motivo: motivo,
          consultas: consultas
        });
      });
  }

  static listarConsultasPorData = (req, res) => {
    const dataConsulta = req.params.dataConsulta;
  
    const dataInicio = new Date(dataConsulta);
    const dataFim = new Date(dataInicio);
    dataFim.setDate(dataFim.getDate() + 1);
  
    consultas.find({
      dataConsulta: { $gte: dataInicio, $lt: dataFim }
    })
      .populate('paciente', 'nome')
      .populate('medico', 'nome')
      .exec((err, consultas) => {
        if (err) {
          return res.status(500).send({ message: `Erro ao buscar consultas do dia ${dataConsulta}: ${err.message}` });
        }
  
        if (!consultas || consultas.length === 0) {
          return res.status(404).send({ message: `Nenhuma consulta encontrada com o dia ${dataConsulta}.` });
        }
  
        res.status(200).json({
          dataConsulta: dataConsulta,
          consultas: consultas
        });
      });
  }
  
  

  static listarConsultas = (req, res) => {
    consultas.find()
      .populate('paciente')
      .exec((err, consultas) => {
        res.status(200).json(consultas);
    });
  }

static listarConsultasPorMedico = (req, res) => {
  const medico = req.params.id;
  
  consultas.find({ medico: medico })
    .populate('paciente', 'nome')
    .exec((err, consultas) => {
      if (err) {
        return res.status(500).send({ message: `Erro ao buscar consultas do médico com ID ${medico}: ${err.message}` });
      }

      if (!consultas || consultas.length === 0) {
        return res.status(404).send({ message: `Nenhuma consulta encontrada para o médico com ID ${medico}.` });
      }
      const numConsultas = consultas.length;
      res.status(200).json({
        medico: medico,
        numeroConsultas: numConsultas,
        consultas: consultas
      });
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

}

export default ConsultaController;
