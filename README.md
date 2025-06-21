# Análise de Dirigibilidade e Estabilidade Veicular Através de Simulação Multi-Corpos de Alta Fidelidade

![Status da Fase 1](https://img.shields.io/badge/Fase%201-Concluída%20%26%20Validada-brightgreen)
![Plataforma](https://img.shields.io/badge/Plataforma-MATLAB%20%26%20Simulink-blue)

## 🎯 Visão Geral do Projeto

Este projeto de engenharia documenta o desenvolvimento de uma ferramenta de simulação de dinâmica veicular construída do zero em **MATLAB** e **Simulink**. O objetivo principal é analisar os fundamentos da dirigibilidade e estabilidade de um veículo, evoluindo de um modelo simples de 3 Graus de Liberdade (DOF) para um modelo de alta fidelidade de até 14-DOF.

O projeto serve como um estudo aprofundado dos princípios da física veicular e como um portfólio prático de modelagem matemática, simulação de sistemas dinâmicos e resolução de problemas de engenharia. O processo incluiu um ciclo completo de desenvolvimento: da revisão teórica e implementação, passando por uma extensiva fase de depuração para corrigir instabilidades no modelo, até a validação final dos resultados contra a teoria estabelecida.

## 🛠️ Ferramentas e Conceitos Chave

* **Software Principal:** MATLAB, Simulink
* **Controle de Versão:** Git, GitHub
* **Conceitos de Dinâmica Veicular:**
    * Sistemas de Coordenadas SAE J670e
    * Modelo Bicicleta (3-DOF)
    * Forças nos Pneus (Modelo Linear)
    * Ângulo de Deriva (Slip Angle)
    * Dirigibilidade: Subesterço (Understeer) e Sobre-esterço (Oversteer)
    * Ganho de Taxa de Guinada (Yaw Rate Gain)

## 📁 Estrutura do Projeto

O repositório está organizado de forma modular para garantir clareza e manutenibilidade:

```
/Analise_Dirigibilidade_Estabilidade/
|-- 01_Modelos_Simulink/  # Arquivos .slx dos modelos
|-- 02_Scripts_MATLAB/    # Scripts .m para parâmetros e análises
|-- 03_Resultados/        # Gráficos, GIFs e dados exportados
|-- README.md             # Esta documentação
`-- .gitignore            # Arquivos ignorados pelo Git
```

## 📈 Fases do Projeto

O desenvolvimento segue um plano incremental:

-   [x] **Fase 0: A Fundação** - Preparação do ambiente e revisão teórica.
-   [x] **Fase 1: O Modelo Bicicleta (3-DOF)** - Implementação, depuração e validação do modelo lateral linear.
-   [ ] **Fase 2: Introduzindo o Modelo de Pneu Não-Linear (Pacejka)**
-   [ ] **Fase 3: Adicionando a Dinâmica de Rolagem (Roll) e Transferência de Carga (4-DOF)**
-   [ ] **Fase 4: A Simulação Completa (7-DOF a 14-DOF)**
-   [ ] **Fase 5: Análise e Visualização Final**

## 📊 Resultados da Fase 1

A primeira fase do projeto foi concluída e validada com sucesso.

### 1. Validação do Modelo: Resposta ao Degrau

Para verificar a estabilidade fundamental do modelo, uma simulação com entrada degrau no volante (`delta`) foi executada. O gráfico abaixo mostra a resposta da taxa de guinada (`r`) e da velocidade lateral (`vy`). A resposta oscilatória que se estabiliza em um valor de regime permanente confirma o comportamento estável de segunda ordem do sistema, como esperado pela teoria.

> ![Resposta ao Degrau](03_Resultados/grafico_resposta_degrau.png)

### 2. Análise de Característica de Dirigibilidade

Uma ferramenta de análise foi desenvolvida em MATLAB para automatizar a execução do modelo Simulink em uma ampla faixa de velocidades (10 a 40 m/s). O script calcula o ganho de taxa de guinada em regime permanente e plota a curva característica do veículo.

Após um processo iterativo de ajuste de parâmetros (distribuição de peso, rigidez dos pneus e momento de inércia), o modelo foi configurado para exibir um comportamento **subesterçante**, que é o padrão de segurança para veículos de passeio. O gráfico abaixo demonstra este comportamento, indicado pela queda do ganho em altas velocidades.

> ![Característica Subesterçante](03_Resultados/grafico_final_subestercante.png)

## 🚀 Como Executar a Simulação

O projeto é executado através de um script mestre que controla todo o processo.

## 🔮 Próximos Passos

O próximo grande passo é a **Fase 2**, que consiste em substituir o modelo de pneu linear por um modelo não-linear **"Magic Formula" de Pacejka**. Isso permitirá a simulação de manobras no limite de aderência e uma análise de estabilidade muito mais aprofundada.

## 📚 Referências

* Milliken, W. F., & Milliken, D. L. (1995). *Race Car Vehicle Dynamics*. SAE International.
* Gillespie, T. D. (1992). *Fundamentals of Vehicle Dynamics*. SAE International.
