# Análise de Dirigibilidade e Estabilidade Veicular com Simulação Multi-Corpos

![Status do Projeto](https://img.shields.io/badge/Projeto-Concluído-brightgreen)
![Plataforma](https://img.shields.io/badge/Plataforma-MATLAB%2C%20Simulink%2C%20Unreal%20Engine-blueviolet)

## 🎯 Visão Geral do Projeto

Este projeto de engenharia documenta a construção, do zero, de uma ferramenta de simulação de dinâmica veicular de alta fidelidade em **MATLAB** e **Simulink**, com visualização 3D em tempo real através da integração com a **Unreal Engine**. O objetivo principal foi criar um ambiente virtual para analisar e visualizar os complexos comportamentos de um veículo, como dirigibilidade, estabilidade, e a resposta da suspensão a perturbações da pista.

O modelo evoluiu progressivamente, começando com um simples modelo bicicleta de 3 Graus de Liberdade (DOF) e culminando em um modelo completo de 8-DOF, incorporando dinâmicas não-lineares dos pneus (Pacejka), rolagem (roll), arfagem (pitch) e o movimento vertical de cada uma das quatro suspensões.

## 🎥 Visualização Final (Resultados da Fase 5)

A culminação do projeto é a capacidade de executar manobras complexas e visualizar os resultados tanto em gráficos técnicos quanto em animações 3D. Abaixo estão os resultados de uma manobra de **Slalom com um obstáculo** para testar a agilidade e a suspensão simultaneamente.

### Animação 3D da Manobra

A animação abaixo foi gerada conectando a saída de pose 6-DOF do modelo Simulink a um bloco de veículo na Unreal Engine. Ela mostra o carro executando a manobra de zigue-zague e reagindo ao obstáculo na pista.

> ![Animação 3D da Manobra](03_Resultados/animacao_slalom_3d.gif)

### Animação dos Gráficos de Análise

Para entender a física por trás da animação, os principais estados do veículo foram plotados e animados de forma sincronizada. O gráfico mostra a trajetória do veículo, a atitude do chassi (rolagem e arfagem), o ângulo de guinada e o deslocamento da suspensão que passou pelo obstáculo.

> ![Animação dos Gráficos](03_Resultados/animacao_graficos_2d.gif)

## 🛠️ Ferramentas e Conceitos Chave

* **Software Principal:** MATLAB, Simulink, Unreal Engine
* **Controle de Versão:** Git, GitHub
* **Conceitos de Dinâmica Veicular:**
    * Modelo Bicicleta (3-DOF) -> Modelo de Veículo Completo (8-DOF)
    * Dinâmica Vertical (Heave), Rolagem (Roll), Arfagem (Pitch) e Guinada (Yaw)
    * Modelo de Pneu Não-Linear (Magic Formula de Pacejka)
    * Transferência de Carga Lateral
    * Análise de Dirigibilidade (Subesterço/Understeer)

## 챌린지 Desafios e Aprendizados

Durante o desenvolvimento, vários desafios técnicos foram superados, consolidando o aprendizado:
* **Depuração de Instabilidade Numérica:** O modelo inicialmente apresentou instabilidades, que foram resolvidas através de uma depuração sistemática, corrigindo erros de sinal nos loops de feedback (Ação e Reação) e adicionando amortecimento passivo para estabilizar o solver.
* **Configuração de "Bus Objects":** A integração entre modelos no Simulink (Model Referencing) exigiu a criação de interfaces de dados formais (`Simulink.Bus`) para garantir a robustez, um conceito chave em engenharia de software de simulação.
* **Incompatibilidade de Ferramentas:** Foi descoberto que as ferramentas legadas da `Simulink 3D Animation` (`vrbuild`, `vrworlded`) não são compatíveis com versões recentes do MATLAB (R2025a), exigindo uma pivotagem para a nova e mais poderosa integração com a Unreal Engine.

## 🔮 Próximos Passos (Trabalho Futuro)

* **Expansão para 14-DOF:** Adicionar a dinâmica de rotação de cada roda para simular aceleração e frenagem (dinâmica longitudinal).
* **Controle do Veículo:** Implementar um controlador de trajetória para fazer o carro seguir um caminho pré-definido autonomamente.
* **Cenários Customizados:** Criar pistas de teste personalizadas no Unreal Editor para análises mais específicas.

## 📚 Referências

* Milliken, W. F., & Milliken, D. L. (1995). *Race Car Vehicle Dynamics*. SAE International.
* Gillespie, T. D. (1992). *Fundamentals of Vehicle Dynamics*. SAE International.
* Documentação da MathWorks para Simulação 3D com Unreal Engine.