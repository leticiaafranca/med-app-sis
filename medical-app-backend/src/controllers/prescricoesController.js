import prescricoes from "../models/Prescricao.js";
class PrescricaoController {

  static listarPrescricoes = (req, res) => {
    prescricoes.find()
      .populate('paciente')
      .populate('medico')
      .exec((err, prescricoes) => {
        res.status(200).json(prescricoes);
    });
  }

  static listarPrescricaoPorId = (req, res) => {
    const id = req.params.id;

    prescricoes.findById(id)
      .populate('paciente', 'nome')
      .populate('medico', 'nome')
      .exec((err, prescricao) => {
      if (err) {
        res.status(400).send({ message: `${err.message} - Id da prescricao não localizado.` });
      } else {
        res.status(200).send(prescricao);
      }
    });
  }


  static cadastrarPrescricao = (req, res) => {
    let prescricao = new prescricoes(req.body);

    prescricao.save((err) => {
      if (err) {
        res.status(500).send({ message: `${err.message} - falha ao cadastrar prescricao.` });
      } else {
        res.status(201).send(prescricao.toJSON());
      }
    });
  }

  static atualizarPrescricao = (req, res) => {
    const id = req.params.id;

    prescricoes.findByIdAndUpdate(id, { $set: req.body }, (err) => {
      if (!err) {
        res.status(200).send({ message: 'Prescricao atualizada com sucesso' });
      } else {
        res.status(500).send({ message: err.message });
      }
    });
  }

  static excluirPrescricao = (req, res) => {
    const id = req.params.id;

    prescricoes.findByIdAndDelete(id, (err) => {
      if (!err) {
        res.status(200).send({ message: 'Prescricao removida com sucesso' });
      } else {
        res.status(500).send({ message: err.message });
      }
    });
  }
}

export default PrescricaoController;
