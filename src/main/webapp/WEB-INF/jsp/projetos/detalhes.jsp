<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/node_modules/bootstrap/dist/css/bootstrap.min.css">
  <title>Detalhes do Projeto</title>
  <style>
    .form-container {
      max-width: 800px;
      margin: auto;
      padding: 20px;
      background-color: #f7f7f7;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .form-actions {
      margin-top: 20px;
    }
  </style>
</head>
<body>
<%@ include file="../includes/header.jsp" %>

<div class="container mt-4">
  <div class="form-container">
    <h1 class="mb-4 text-center">Detalhes do Projeto</h1>
    <form id="projetoForm" method="post">
      <div class="form-group mb-3">
        <label for="nome">Nome do Projeto</label>
        <input type="text" class="form-control" id="nome" name="nome" required>
      </div>
      <div class="form-group mb-3">
        <label for="dataInicio">Data de Início</label>
        <input type="date" class="form-control" id="dataInicio" name="dataInicio" required>
      </div>
      <div class="form-group mb-3">
        <label for="gerenteResponsavel">Gerente Responsável</label>
        <input type="text" class="form-control" id="gerenteResponsavel" name="gerenteResponsavel" required>
      </div>
      <div class="form-group mb-3">
        <label for="previsaoTermino">Previsão de Término</label>
        <input type="date" class="form-control" id="previsaoTermino" name="previsaoTermino" required>
      </div>
      <div class="form-group mb-3">
        <label for="dataRealTermino">Data Real de Término</label>
        <input type="date" class="form-control" id="dataRealTermino" name="dataRealTermino">
      </div>
      <div class="form-group mb-3">
        <label for="orcamentoTotal">Orçamento Total</label>
        <input type="number" step="0.01" class="form-control" id="orcamentoTotal" name="orcamentoTotal" required>
      </div>
      <div class="form-group mb-3">
        <label for="descricao">Descrição</label>
        <textarea class="form-control" id="descricao" name="descricao" rows="3" required></textarea>
      </div>
      <div class="form-group mb-3">
        <label for="risco">Classificação de Risco</label>
        <select class="form-control" id="risco" name="risco" required>
          <option value="baixo risco">Baixo Risco</option>
          <option value="médio risco">Médio Risco</option>
          <option value="alto risco">Alto Risco</option>
        </select>
      </div>
      <div class="form-group mb-3">
        <label for="status">Status</label>
        <select class="form-control" id="status" name="status" required>
          <option value="EM_ANALISE" ${projeto.status == 'EM_ANALISE' ? 'selected' : ''}>Em Análise</option>
          <option value="ANALISE_REALIZADA" ${projeto.status == 'ANALISE_REALIZADA' ? 'selected' : ''}>Análise Realizada</option>
          <option value="ANALISE_APROVADA" ${projeto.status == 'ANALISE_APROVADA' ? 'selected' : ''}>Análise Aprovada</option>
          <option value="INICIADO" ${projeto.status == 'INICIADO' ? 'selected' : ''}>Iniciado</option>
          <option value="PLANEJADO" ${projeto.status == 'PLANEJADO' ? 'selected' : ''}>Planejado</option>
          <option value="EM_ANDAMENTO" ${projeto.status == 'EM_ANDAMENTO' ? 'selected' : ''}>Em Andamento</option>
          <option value="ENCERRADO" ${projeto.status == 'ENCERRADO' ? 'selected' : ''}>Encerrado</option>
          <option value="CANCELADO" ${projeto.status == 'CANCELADO' ? 'selected' : ''}>Cancelado</option>
        </select>
      </div>
      <div class="form-actions">
        <button type="submit" class="btn btn-primary">Salvar</button>
        <a href="${pageContext.request.contextPath}/projetos" class="btn btn-primary btn-custom">Cancelar</a>
      </div>
    </form>
    <form id="deleteForm" action="${pageContext.request.contextPath}/api/v1/projeto/${param.id}" method="post" class="mt-3">
      <input type="hidden" name="_method" value="delete">
      <button type="submit" class="btn btn-danger">Excluir</button>
    </form>
  </div>
</div>

<%@ include file="../includes/footer.jsp" %>

<script src="${pageContext.request.contextPath}/static/node_modules/jquery/dist/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/node_modules/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<script>
  $(document).ready(function() {
    const urlParams = new URLSearchParams(window.location.search);
    const projectId = urlParams.get('id');

    if (projectId) {
      $.ajax({
        url: '${pageContext.request.contextPath}/api/v1/projeto/get',
        type: 'GET',
        data: {
          id: projectId
        },
        success: function(projeto) {

          function formatDate(date) {
            if (!date) return '';
            const d = new Date(date);
            const month = '' + (d.getMonth() + 1);
            const day = '' + d.getDate();
            const year = d.getFullYear();

            return [year, month.padStart(2, '0'), day.padStart(2, '0')].join('-');
          }

          var statusMap = {
            'em análise': 'EM_ANALISE',
            'análise realizada':'ANALISE_REALIZADA',
            'análise aprovada': 'ANALISE_APROVADA',
            'iniciado': 'INICIADO',
            'planejado': 'PLANEJADO',
            'em andamento': 'EM_ANDAMENTO',
            'encerrado': 'ENCERRADO',
            'cancelado': 'CANCELADO'
          };

          $('#nome').val(projeto.nome);
          $('#dataInicio').val(formatDate(projeto.dataInicio));
          $('#gerenteResponsavel').val(projeto.gerente);
          $('#previsaoTermino').val(formatDate(projeto.previsaoFim));
          $('#dataRealTermino').val(formatDate(projeto.dataFim));
          $('#orcamentoTotal').val(projeto.orcamento);
          $('#descricao').val(projeto.descricao);
          $('#risco').val(projeto.risco);
          $('#status').val(statusMap[projeto.status]);
        },
        error: function(xhr, status, error) {
          alert('Erro ao carregar os detalhes do projeto.');
        }
      });

      $('#projetoForm').attr('action', `${pageContext.request.contextPath}/api/v1/projeto/${projectId}`);
      $('#projetoForm').append('<input type="hidden" name="_method" value="put">');
    } else {
      $('#projetoForm').attr('action', `${pageContext.request.contextPath}/api/v1/projeto`);
    }

    $('#projetoForm').on('submit', function(event) {
      event.preventDefault();
      if (!this.checkValidity()) {
        event.stopPropagation();
        $(this).addClass('was-validated');
      } else {
        var formData = {
          nome: $('#nome').val(),
          dataInicio: $('#dataInicio').val(),
          gerenteResponsavel: $('#gerenteResponsavel').val(),
          previsaoTermino: $('#previsaoTermino').val(),
          dataRealTermino: $('#dataRealTermino').val(),
          orcamentoTotal: $('#orcamentoTotal').val(),
          descricao: $('#descricao').val(),
          risco: $('#risco').val(),
          status: $('#status').val()
        };

        $.ajax({
          type: 'POST',
          url: $(this).attr('action'),
          contentType: 'application/json',
          data: JSON.stringify(formData),
          success: function() {
            window.location.href = '${pageContext.request.contextPath}/projetos';
          },
          error: function() {
            alert('Erro ao salvar o projeto.');
          }
        });
      }
    });
  });
</script>
</body>
</html>
