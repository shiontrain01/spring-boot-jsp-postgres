package com.company.app.application.dtos;

import com.company.app.domain.models.Pessoa;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProjetoDTO implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private Long id;
    private String nome;
    private LocalDate dataInicio;
    private LocalDate previsaoFim;
    private LocalDate dataFim;
    private String descricao;
    private String status;
    private Float orcamento;
    private String risco;
    private Pessoa gerente;
}