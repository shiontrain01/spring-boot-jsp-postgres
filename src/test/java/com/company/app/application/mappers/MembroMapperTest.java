package com.company.app.application.mappers;

import com.company.app.application.dtos.MembroDTO;
import com.company.app.domain.models.Membro;
import com.company.app.domain.models.Pessoa;
import com.company.app.domain.models.Projeto;
import org.junit.jupiter.api.Test;

import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class MembroMapperTest {

    private final MembroMapper membroMapper = MembroMapper.INSTANCE;

    @Test
    public void toDto_deveConverterEntityParaDto() {
        Membro membro = new Membro(1L, new Projeto(1L, "Projeto Teste", LocalDate.now(), LocalDate.now().plusDays(10), LocalDate.now().plusDays(20), "Descrição", "Status", 1000.0f, "Risco", new Pessoa()), new Pessoa(1L, "Pessoa Teste", LocalDate.now(), "123.456.789-00", true, false));

        MembroDTO membroDTO = membroMapper.toDto(membro);

        assertEquals(membro.getId(), membroDTO.getId());
        assertEquals(membro.getProjeto().getId(), membroDTO.getProjeto().getId());
        assertEquals(membro.getPessoa().getId(), membroDTO.getPessoa().getId());
    }

    @Test
    public void toEntity_deveConverterDtoParaEntity() {
        MembroDTO membroDTO = new MembroDTO(1L, new Projeto(), new Pessoa());

        Membro membro = membroMapper.toEntity(membroDTO);

        assertEquals(membroDTO.getId(), membro.getId());
        assertEquals(membroDTO.getProjeto().getId(), membro.getProjeto().getId());
        assertEquals(membroDTO.getPessoa().getId(), membro.getPessoa().getId());
    }
}
